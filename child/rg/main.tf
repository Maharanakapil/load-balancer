resource "azurerm_resource_group" "rg" {
  name = var.rgs.name
  location =  var.rgs.location
}