resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vms
  name =  each.value.name
  location = each.value.location  
  resource_group_name =  each.value.resource_group_name
  size =  each.value.size
  admin_username =  each.value.admin_username
  admin_password =  each.value.admin_password
  disable_password_authentication =  each.value.disable_password_authentication
  network_interface_ids = [data.azurerm_network_interface.data_nic[each.key].id]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

}