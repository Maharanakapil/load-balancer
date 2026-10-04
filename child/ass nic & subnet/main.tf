resource "azurerm_network_interface_security_group_association" "nic_association" {
    for_each = var.ass_SNs
  network_interface_id      = data.azurerm_network_interface.data-nic[each.key].id
  network_security_group_id = data.azurerm_network_security_group.data-nsg[each.key].id
}

resource "azurerm_subnet_network_security_group_association" "subnet_association" {
    for_each = var.ass_SNs
  subnet_id                 = data.azurerm_subnet.data-subnet[each.key].id
  network_security_group_id = data.azurerm_network_security_group.data-nsg[each.key].id
}