module "worker-two" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "worker-two"

  instance_type               = "t3.micro"
  key_name                    = "eu-west-1-labs"
  ami                         = "ami-0df5428164f725e3a"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.worker-instance-sg.id]
  subnet_id                   = module.vpc.private_subnets[1]
  associate_public_ip_address = false
  iam_instance_profile        = "SSM_EC2"

  // for tests
  create = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
