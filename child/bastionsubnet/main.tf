resource "azurerm_subnet" "bastion_subnet" {
  name =  var.bastion_subnets.name
  virtual_network_name = var.bastion_subnets.virtual_network_name 
  resource_group_name =  var.bastion_subnets.resource_group_name
  address_prefixes = var.bastion_subnets.address_prefixes
}