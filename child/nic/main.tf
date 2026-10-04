resource "azurerm_network_interface" "nic" {
    for_each = var.nics
  name =  each.value.name
  location = each.value.location
  resource_group_name =  each.value.resource_group_name
   
  ip_configuration {
    name =  each.value.ip_configuration.name
    subnet_id =  data.azurerm_subnet.data_subnetB[each.key].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
    
  }
}
