resource "azurerm_bastion_host" "bastion_host" {
  name =  var.bastions.name
  location =  var.bastions.location
  resource_group_name =  var.bastions.resource_group_name

  ip_configuration {
    name =  var.bastions.ip_configuration.name
    subnet_id =  data.azurerm_subnet.data-subnet-bh.id
    public_ip_address_id = data.azurerm_public_ip.data-pipB.id
  }
}