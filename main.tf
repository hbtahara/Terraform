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
#crias os grupos de recuros 

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

#Network 

resource "azurerm_resource_group" "RGnetworkPRD" {
  name     = "RGnetworkPRD"
  location = "Westus2"
}

resource "azurerm_virtual_network" "VNnetworkPRD" {
  name                = "network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RGnetworkPRD.location
  resource_group_name = azurerm_resource_group.RGnetworkPRD.name
}

resource "azurerm_subnet" "SUBnetworkPRD" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.RGnetworkPRD.name
  virtual_network_name = azurerm_virtual_network.VNnetworkPRD.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "ITFnetworkPRD" {
  name                = "InterfaceEXT"
  location            = azurerm_resource_group.RGnetworkPRD.location
  resource_group_name = azurerm_resource_group.RGnetworkPRD.name

  ip_configuration {
    name                          = "InterfaceEXT"
    subnet_id                     = azurerm_subnet.SUBnetworkPRD.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "ITFnetworkPRDINT" {
  name                = "InterfaceINT"
  location            = azurerm_resource_group.RGnetworkPRD.location
  resource_group_name = azurerm_resource_group.RGnetworkPRD.name

  ip_configuration {
    name                          = "InterfaceINT"
    subnet_id                     = azurerm_subnet.SUBnetworkPRD.id
    private_ip_address_allocation = "Dynamic"
  }
}


#crias storage accouts

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

