resource "azurerm_public_ip" "lbpip" {
  name                = var.lbs.azurerm_public_ip.name
  location            = var.lbs.location
  resource_group_name = var.lbs.resource_group_name
  allocation_method   = var.lbs.azurerm_public_ip.allocation_method
  sku = var.lbs.azurerm_public_ip.sku
}

resource "azurerm_lb" "lb" {
    depends_on = [ azurerm_public_ip.lbpip ]
  name = var.lbs.name
  location = var.lbs.location
  resource_group_name = var.lbs.resource_group_name 
  sku = var.lbs.sku

  frontend_ip_configuration {
    name =   var.lbs.frontend_ip_configuration.name
    public_ip_address_id = azurerm_public_ip.lbpip.id
  }
  
}

resource "azurerm_lb_probe" "hb" {
    depends_on = [ azurerm_lb.lb ]
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.lbs.azurerm_lb_probe.name
  port            = var.lbs.azurerm_lb_probe.port
  interval_in_seconds =  var.lbs.azurerm_lb_probe.interval_in_seconds
  number_of_probes = var.lbs.azurerm_lb_probe.number_of_probes
}

resource "azurerm_lb_backend_address_pool" "bap" {
    depends_on = [ azurerm_lb.lb ]
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.lbs.azurerm_lb_backend_address_pool.name
}

resource "azurerm_lb_rule" "lbrule" {
    depends_on = [ azurerm_lb_backend_address_pool.bap ]
  loadbalancer_id                = azurerm_lb.lb.id
  
  name                           = var.lbs.azurerm_lb_rule.name
  protocol                       = var.lbs.azurerm_lb_rule.protocol
  frontend_port                  = var.lbs.azurerm_lb_rule.frontend_port
  backend_port                   = var.lbs.azurerm_lb_rule.backend_port
  frontend_ip_configuration_name = var.lbs.azurerm_lb_rule.frontend_ip_configuration_name
  probe_id =  azurerm_lb_probe.hb.id
  backend_address_pool_ids = [data.azurerm_lb_backend_address_pool.data-bap.id]
  idle_timeout_in_minutes = var.lbs.azurerm_lb_rule.idle_timeout_in_minutes
  enable_floating_ip =  var.lbs.azurerm_lb_rule.enable_floating_ip
}

# Associate VM1's NIC with Load Balancer Backend Pool
resource "azurerm_network_interface_backend_address_pool_association" "vm1_association" {
  network_interface_id      = data.azurerm_network_interface.data_nicvm1.id
  ip_configuration_name     = var.lbs.ip_config1
  backend_address_pool_id   = azurerm_lb_backend_address_pool.bap.id
  
}

# Associate VM2's NIC with Load Balancer Backend Pool
resource "azurerm_network_interface_backend_address_pool_association" "vm2_association" {
  network_interface_id      = data.azurerm_network_interface.data_nicvm2.id
  ip_configuration_name     = var.lbs.ip_config2
  backend_address_pool_id   = azurerm_lb_backend_address_pool.bap.id
}



