resource "aws_security_group" "builder-instance-sg" {
  name        = "builder-instance-sg"
  vpc_id      = module.vpc.vpc_id
  description = "group used during instance image preparation."

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port   = 0
    to_port     = 65500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh from open internet"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ping from open internet"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "default egress to internet"
  }
}

resource "aws_security_group" "worker-instance-sg" {
  name        = "worker-instance-sg"
  vpc_id      = module.vpc.vpc_id
  description = "group used for lb testing used on worker nodes"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "ssh from open internet"
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "ssh from open internet"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    description = "ping from open internet"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "default egress to internet"
  }
}
