module "img_prep" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "img_prep"

  instance_type               = "t2.micro"
  key_name                    = "user1"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.builder-instance-sg.id]
  subnet_id                   = module.vpc.public_subnets[1]
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
