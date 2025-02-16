module "nlb" {
  source = "terraform-aws-modules/alb/aws"

  name               = "lb-nlb-1"
  load_balancer_type = "network"
  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets]

  # Security Group
  enforce_security_group_inbound_rules_on_private_link_traffic = "on"
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 3000
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 445
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  # access_logs = {
  #   bucket = "my-nlb-logs"
  # }

  listeners = {

    ex-tcp = {
      port     = 80
      protocol = "TCP"
      forward = {
        target_group_key = "ex-target"
      }
    }

    # ex-tls = {
    #   port            = 84
    #   protocol        = "TLS"
    #   certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
    #   forward = {
    #     target_group_key = "ex-target"
    #   }
    # }
  }

  target_groups = {
    ex-target-one = {
      name        = "node-1"
      port        = 3000
      target_type = "ip"
      target_id   = "10.0.47.1"
    }

    ex-target-two = {
      name        = "node-2"
      protocol    = "TCP"
      port        = 3000
      target_type = "ip"
      target_id   = "10.0.47.1"
    }

    ex-target-third = {
      name        = "node-3"
      protocol    = "TCP"
      port        = 3000
      target_type = "ip"
      target_id   = "10.0.47.1"
    }
  }

  tags = {
    Environment = "sandbox"
    Project     = "lb-labs"
    Terraform   = "true"
  }
}