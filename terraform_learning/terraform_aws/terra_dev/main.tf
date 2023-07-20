module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"
  name    = "zirconsys-${local.region}-${local.env}-vpc"
  cidr    = "10.31.0.0/16"

  azs             = data.aws_availability_zones.available.names
  public_subnets  = ["10.31.0.0/24", "10.31.1.0/24", "10.31.2.0/24"]
  private_subnets = ["10.31.3.0/24", "10.31.4.0/24", "10.31.5.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = local.tags
}