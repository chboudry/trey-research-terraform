# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

module "platform" {
  source                                   = "./platform"
  location                                 = var.location
  TreyResearch-mgmt-rg-name                = var.plaform_mgmt_rg_name
  TreyResearch-connectivity-rg-name        = var.plaform_connectivity_rg_name
  TreyResearch-identity-rg-name            = var.plaform_identity_rg_name
  
}