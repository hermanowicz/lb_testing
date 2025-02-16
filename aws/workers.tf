module "workers" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["worker-one", "worker-two", "worker-three"])

  name = "instance-${each.key}"

  instance_type               = "t3.micro"
  key_name                    = "eu-west-1-labs"
  ami                         = "ami-0df5428164f725e3a"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.worker-instance-sg.id]
  subnet_id                   = module.vpc.private_subnets[1]
  associate_public_ip_address = false
  iam_instance_profile        = "SSM_EC2"

  // for tests
  create = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
