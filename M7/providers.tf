terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-backend-dk"
    storage_account_name = "sabackenddkpxa7788paa"
    container_name       = "scbackenddk"
    key                  = "oving.m7.tfstate"
  }
}

provider "azurerm" {
  features {}
}
