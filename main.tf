terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.12.0"
    }
  }
}


provider "azurerm" {
  resource_provider_registrations = "none" 
  features {}
  subscription_id="3a72be92-287b-4f1e-840a-5e3e71100139"
}

# resource "azurerm_resource_group" "rg-aztraining-cat-uk" {
#   name     = "rg-aztraining-cat-uk"
#   location = "UK South"
# }

resource "azurerm_storage_account" "storageaccountrefname01" {
  name                     = "deeptistorage011"
  resource_group_name      = "rg-aztraining-cat-uk"
  location                 = "UK South"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "test"
  }
}


resource "azurerm_virtual_network" "deeptitestvnet" {
  name                = "deeptinetwork01"
  resource_group_name = "rg-aztraining-cat-uk"
  location            = "UK South"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "deeptitestvsubnet" {
  name                 = "deeptinetworksubnetname"
  resource_group_name  = "rg-aztraining-cat-uk"
  virtual_network_name = "deeptinetwork01"
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}