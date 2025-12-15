terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "mend-state-739929374881"
    key            = "cluster/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "tf-state-lock-739929374881"
    profile = "mend"
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}
