# This file is used to define the provider and its version

provider "azurerm" {
  features {}
  client_id       = ${{ secrets.AZURE_CLIENT_ID }}
  client_secret   = ${{ secrets.AZURE_CLIENT_SECRET }}
  tenant_id       = ${{ secrets.AZURE_TENANT_ID }}
  subscription_id = ${{ secrets.AZURE_SUBSCRIPTION_ID }}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.6"
    }
  }
}
