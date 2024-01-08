provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host = data.aws_eks_cluster.webapp-eks.endpoint
  token = data.aws_eks_cluster_auth.webapp-eks.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.webapp-eks.certificate_authority[0].data)
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}