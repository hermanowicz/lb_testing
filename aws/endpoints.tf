resource "aws_vpc_endpoint" "s3" {
  vpc_id          = module.vpc.vpc_id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = flatten(module.vpc.private_route_table_ids[*])

  tags = {
    Name : "s3-vpc-endpoint-gateway"
    Terraform : true
    Version : "0.1.0"
    Envrionment : "sandbox"
  }
}

# set of endpoint for ssm sessions in vpc
# ---------------------------------------

resource "aws_vpc_endpoint" "ec2-messages-vpc-endpoint" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm-endpoints-sg.id]
  subnet_ids          = flatten(module.vpc.private_subnets[*])
  private_dns_enabled = true

}

resource "aws_vpc_endpoint" "ssm-vpc-endpoint" {
  vpc_id              = module.vpc.vpc_id
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm-endpoints-sg.id]
  subnet_ids          = flatten(module.vpc.private_subnets[*])
  service_name        = "com.amazonaws.${var.region}.ssm"
  private_dns_enabled = true

}

resource "aws_vpc_endpoint" "ssm-messages-vpc-endpoint" {
  vpc_id = module.vpc.vpc_id

  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm-endpoints-sg.id]
  subnet_ids          = flatten(module.vpc.private_subnets[*])
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  private_dns_enabled = true

}

resource "aws_vpc_endpoint" "kms-service-vpc-endpoint" {
  vpc_id              = module.vpc.vpc_id
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm-endpoints-sg.id]
  subnet_ids          = flatten(module.vpc.private_subnets[*])
  service_name        = "com.amazonaws.${var.region}.kms"
  private_dns_enabled = true

}

resource "aws_vpc_endpoint" "logs-vpc-endpoint" {
  vpc_id              = module.vpc.vpc_id
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm-endpoints-sg.id]
  subnet_ids          = flatten(module.vpc.private_subnets[*])
  service_name        = "com.amazonaws.${var.region}.logs"
  private_dns_enabled = true

}

resource "aws_vpc_endpoint" "eks-ipv4-vpc-endpoint" {
  vpc_id              = module.vpc.vpc_id
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm-endpoints-sg.id]
  subnet_ids          = flatten(module.vpc.private_subnets[*])
  service_name        = "com.amazonaws.${var.region}.eks"
  private_dns_enabled = true

}


resource "aws_security_group" "ssm-endpoints-sg" {
  name   = "ssm-endpoints-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }
}
