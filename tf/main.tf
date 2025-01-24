#Azure Resource Group
resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}

terraform {
  backend "azurerm" {
    resource_group_name  = "storage-rg"
    storage_account_name = "tfbackend23"
    container_name       = "default"
    key                  = "terraform.tfstate"
  }
}
