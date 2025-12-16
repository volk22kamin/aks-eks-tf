terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80" # newer version required for ingress_application_gateway.user_assigned_identity_id
    }
  }
}

provider "azurerm" {
  features {}
}
