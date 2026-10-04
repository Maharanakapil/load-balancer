data "azurerm_lb" "data-lb" {
    depends_on = [ azurerm_lb.lb ]
  name                = var.lbs.name
  resource_group_name = var.lbs.resource_group_name
}

data "azurerm_lb_backend_address_pool" "data-bap" {
    depends_on = [ azurerm_lb_backend_address_pool.bap ]
  name            = var.lbs.azurerm_lb_backend_address_pool.name
  loadbalancer_id = data.azurerm_lb.data-lb.id
}

data "azurerm_network_interface" "data_nicvm1" {
  name =  var.lbs.nic1_name
  resource_group_name = var.lbs.resource_group_name 
}

data "azurerm_network_interface" "data_nicvm2" {
  name =  var.lbs.nic2_name
  resource_group_name = var.lbs.resource_group_name
}

data "azurerm_virtual_network" "data-vnet" {
  name                = var.lbs.vnet_name
  resource_group_name = var.lbs.resource_group_name
}
