resource "aws_lb" "nlb-test-labs" {
  name               = "nlb-test-labs"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb-sg.id]
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]

  enable_deletion_protection = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "nlb-sg" {
  vpc_id      = module.vpc.vpc_id
  name        = "nlb-sg"
  description = "Security group for the NLB"

  ingress {
    from_port   = 80
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
