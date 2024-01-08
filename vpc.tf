data "aws_availability_zones" "azs" {}

module "eks-vps" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = "eks-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks
  azs = data.aws_availability_zones.azs.names
  
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/webapp-eks" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/webapp-eks" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/webapp-eks" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
