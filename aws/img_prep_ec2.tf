resource "aws_instance" "builder-1" {
  instance_type = "t3.large"
  # default amazon linux 2023, for now
  ami = var.dub-ami
  iam_instance_profile = "SSM_EC2"
  # default for now
  key_name = var.dub-key-name
  associate_public_ip_address = true
  monitoring = true
  ebs_optimized = true

  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.builder-instance-sg.id]

  root_block_device {
    delete_on_termination = true
    encrypted = true
    iops = 3000
    volume_size = 50
    volume_type = "gp3"
    tags = {
      Name = "builder-1-labs-vol-1"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "builder | test-vm"
  }
}