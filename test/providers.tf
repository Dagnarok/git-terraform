terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-backend-dk"
    storage_account_name = "sabackenddkpxa7788paa"
    container_name       = "scbackenddk"
    key                  = "test.dk.tfstate"
  }
}

provider "azurerm" {
  features {}
}