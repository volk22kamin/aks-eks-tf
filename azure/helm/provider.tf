terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

locals {
  kube_config = yamldecode(data.terraform_remote_state.cluster.outputs.kube_config)
}

provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host                   = local.kube_config.clusters[0].cluster.server
    client_certificate     = base64decode(local.kube_config.users[0].user["client-certificate-data"])
    client_key             = base64decode(local.kube_config.users[0].user["client-key-data"])
    cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster["certificate-authority-data"])
  }
}

provider "kubernetes" {
  host                   = local.kube_config.clusters[0].cluster.server
  client_certificate     = base64decode(local.kube_config.users[0].user["client-certificate-data"])
  client_key             = base64decode(local.kube_config.users[0].user["client-key-data"])
  cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster["certificate-authority-data"])
}
