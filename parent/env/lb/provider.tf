terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116.0"
    }
  }
     backend "azurerm" {
    resource_group_name = "rg-pf"
    storage_account_name = "jiopfstorage"
    container_name = "peoplefirst"
    key = "peoplefirst.terraform.tfstate"
    
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "0d2956b9-d3f8-4687-b7dc-a8e09657c57a"
}
