terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }

  backend "s3" {
    bucket         = "mend-state-739929374881"
    key            = "helm/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "tf-state-lock-739929374881"
    profile        = "mend"
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile

  default_tags {
    tags = var.default_tags
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.cluster.outputs.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.eks_cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    env = {
      AWS_PROFILE = var.aws_profile
    }
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.terraform_remote_state.cluster.outputs.eks_cluster_id,
      "--region",
      var.region,
      "--profile",
      var.aws_profile
    ]
  }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.cluster.outputs.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.eks_cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      env = {
        AWS_PROFILE = var.aws_profile
      }
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        data.terraform_remote_state.cluster.outputs.eks_cluster_id,
        "--region",
        var.region,
        "--profile",
        var.aws_profile
      ]
    }
  }
}
