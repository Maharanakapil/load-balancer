resource "azurerm_virtual_network" "vnet" {
  name =  var.vnets.name
  location =  var.vnets.location
  resource_group_name =  var.vnets.resource_group_name
  address_space =  var.vnets.address_space
}