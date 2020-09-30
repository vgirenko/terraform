module vpc {
  source = "terraform-aws-modules/vpc/aws"

  name               = "vpc-module"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-west-1a", "eu-west-1b"]
  private_subnets    = ["10.0.1.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.2.0/24", "10.0.4.0/24"]
  enable_nat_gateway = true

}