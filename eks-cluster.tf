data "aws_eks_cluster" "webapp-eks" {
  name = module.eks.cluster_name
  depends_on = [module.eks.cluster_name]
}

data "aws_eks_cluster_auth" "webapp-eks" {
  name = module.eks.cluster_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name = "webapp-eks"
  cluster_version = "1.28"

  subnet_ids = module.eks-vps.private_subnets
  vpc_id = module.eks-vps.vpc_id
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      instance_types = ["t2.small"]
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"
      instance_types = ["t2.medium"]
      min_size = 1
      max_size = 2
      desired_size = 1
    }
  }

  tags = {
    environment = "development"
    app = "webapp"
  }
}