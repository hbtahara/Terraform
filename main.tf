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

resource "azurerm_resource_group" "rgHOM" {
  name     = "HOM"
  location = "westus2"
}
resource "azurerm_resource_group" "rgDEV" {
  name     = "DEV"
  location = "westus2"
}
resource "azurerm_resource_group" "rgPROD" {
  name     = "PRD"
  location = "westus2"
}
resource "azurerm_resource_group" "FrontEnd" {
  name     = "FrontEnd"
  location = "westus2"
}
resource "azurerm_resource_group" "BackEnd" {
  name     = "BacktEnd"
  location = "westus2"
}

resource "azurerm_resource_group" "StrgPRD" {
  name     = "StrgPRD"
  location = "West Europe"
}
resource "azurerm_resource_group" "StrgDEV" {
  name     = "StrgDEV"
  location = "West Europe"
}
resource "azurerm_resource_group" "StrgHOM" {
  name     = "StrgHOM"
  location = "West Europe"
}


resource "azurerm_storage_account" "StrgACPRD" {
  name                     = "strgacprd"
  resource_group_name      = azurerm_resource_group.StrgPRD.name
  location                 = azurerm_resource_group.StrgPRD.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    environment = "staging"
  }
}
resource "azurerm_storage_account" "StrgDEV" {

  name                     = "storageacdevhbs"
  resource_group_name      = azurerm_resource_group.StrgDEV.name
  location                 = azurerm_resource_group.StrgDEV.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    environment = "staging"
  }
}
resource "azurerm_storage_account" "StrgHOM" {
  name                     = "storageachom"
  resource_group_name      = azurerm_resource_group.StrgHOM.name
  location                 = azurerm_resource_group.StrgHOM.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    environment = "staging"
  }
}

