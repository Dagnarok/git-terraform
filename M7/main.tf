locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"
}

resource "azurerm_resource_group" "rg-name" {
  name = var.rg-name
  location =  var.rg-location
}