resource "azurerm_public_ip" "Bpip" {
  name                = var.bpips.name
  location            = var.bpips.location
  resource_group_name = var.bpips.resource_group_name
  allocation_method   = var.bpips.allocation_method
  sku                 = var.bpips.sku
}