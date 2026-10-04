data "azurerm_subnet" "data-subnet" {
    for_each = var.ass_SNs
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_network_interface" "data-nic" {
    for_each = var.ass_SNs
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_network_security_group" "data-nsg" {
    for_each = var.ass_SNs
  name                = each.value.nsg
  resource_group_name = each.value.resource_group_name
}