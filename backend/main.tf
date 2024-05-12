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
    key                  = "backend.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "random_string" "random_string" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg-backend" {
  name     = var.rg-backend-name
  location = var.rg-backend-location
}

resource "azurerm_storage_account" "sa-backend" {
  name                     = "${lower(var.sa-backend-name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg-backend.name
  location                 = azurerm_resource_group.rg-backend.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc-backend" {
  name                  = var.sc-backend-name
  storage_account_name  = azurerm_storage_account.sa-backend.name
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault-backend" {
  name                        = "${lower(var.kv-backend-name)}${random_string.random_string.result}"
  location                    = azurerm_resource_group.rg-backend.location
  resource_group_name         = azurerm_resource_group.rg-backend.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create",
    ]

    secret_permissions = [
      "Get", "List", "Set",
    ]

    storage_permissions = [
      "Get", "List", "Set",
    ]
  }
}

resource "azurerm_key_vault_secret" "sa-backend-accesskey" {
  name         = var.sa-backend-accesskey-name
  value        = azurerm_storage_account.sa-backend.primary_access_key
  key_vault_id = azurerm_key_vault.keyvault-backend.id
}