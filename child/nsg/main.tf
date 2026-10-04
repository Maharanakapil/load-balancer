resource "azurerm_network_security_group" "nsg" {
  name                = var.nsgs.name
  location            = var.nsgs.location
  resource_group_name = var.nsgs.resource_group_name

  security_rule {
    name                       = var.nsgs.security_rule.name
    priority                   = var.nsgs.security_rule.priority
    direction                  = var.nsgs.security_rule.direction
    access                     = var.nsgs.security_rule.access
    protocol                   = var.nsgs.security_rule.protocol
    source_port_range          = var.nsgs.security_rule.source_port_range
    destination_port_range     = var.nsgs.security_rule.destination_port_range
    source_address_prefix      = var.nsgs.security_rule.source_address_prefix
    destination_address_prefix = var.nsgs.security_rule.destination_address_prefix
  }

  tags = {
    environment = var.nsgs.tags.environment
  }
}

