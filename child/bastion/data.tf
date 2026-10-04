data "azurerm_subnet" "data-subnet-bh" {
  name =  var.bastions.Bastion_subnet_name
  virtual_network_name =  var.bastions.virtual_network_name
  resource_group_name = var.bastions.resource_group_name
}

data "azurerm_public_ip" "data-pipB" {
  name =  var.bastions.pip_name
  resource_group_name =  var.bastions.resource_group_name
}