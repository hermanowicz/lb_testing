module "img_prep" {
  source = "terraform-aws-modules/ec2-instance/aws"

  # create = false
  name = "img_prep"

  instance_type               = "t3.large"
  key_name                    = "eu-west-1-labs"
  ami                         = "ami-0e063207e92b63437"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.builder-instance-sg.id]
  subnet_id                   = module.vpc.public_subnets[1]
  associate_public_ip_address = true
  iam_instance_profile        = "SSM_EC2"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
