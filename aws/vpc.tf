module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "lb-labs"
  cidr = "10.0.0.0/16"

  azs                                                        = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets                                            = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_names                                       = ["private-subnet-1", "private-subnet-2", "private-subnet-3"]
  private_subnet_enable_resource_name_dns_a_record_on_launch = true
  intra_subnets                                              = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  intra_subnet_names                                         = ["intra-subnet-1", "intra-subnet-2", "intra-subnet-3"]
  intra_subnet_enable_resource_name_dns_a_record_on_launch   = true
  public_subnets                                             = ["10.0.203.0/24", "10.0.206.0/24", "10.0.209.0/24"]
  public_subnet_names                                        = ["public-subnet-1", "public-subnet-2", "public-subnet-3"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
