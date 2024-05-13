resource "random_string" "random_string" {
  length  = 6
  special = false
  upper   = false
}

locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"
  rg-name           = "${var.rg-name}-${local.workspaces_suffix}"
}

resource "azurerm_resource_group" "rg-name" {
  name     = local.rg-name
  location = var.rg-location
}

resource "azurerm_storage_account" "sa-name" {
  name                     = "${var.sa-name}${local.workspaces_suffix}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg-name.name
  location                 = azurerm_resource_group.rg-name.location
  account_tier             = "Standard"
  account_replication_type = "LRS"


  static_website {
    index_document = var.index-document
  }
}

resource "azurerm_storage_blob" "index-html" {
  name                   = var.index-document
  storage_account_name   = azurerm_storage_account.sa-name.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = "${var.source_content}${local.workspaces_suffix}"
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.sa-name.primary_web_endpoint
}