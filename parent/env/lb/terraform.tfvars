rgm = {
  name     = "rg-lb-ci-01"
  location = "centralindia"
}


vnetm = {

  name                = "vnet-lb-ci-01"
  location            = "centralindia"
  resource_group_name = "rg-lb-ci-01"
  address_space       = ["172.169.0.0/22"]
}


subnetm = {
  subnet1 = {
    name                 = "subnet-fk-01"
    virtual_network_name = "vnet-lb-ci-01"
    resource_group_name  = "rg-lb-ci-01"
    address_prefixes     = ["172.169.0.0/24"]
  }
  subnet2 = {
    name                 = "subnet-fk-02"
    virtual_network_name = "vnet-lb-ci-01"
    resource_group_name  = "rg-lb-ci-01"
    address_prefixes     = ["172.169.1.0/24"]
  }
}


nicm = {
  nic1 = {
    name                 = "fk-nic01"
    resource_group_name  = "rg-lb-ci-01"
    location             = "centralindia"
    virtual_network_name = "vnet-lb-ci-01"
    subnet_name          = "subnet-fk-01"
    ip_configuration = {
      name                          = "ipconfig1"
      private_ip_address_allocation = "Dynamic"
    }
  }
  nic2 = {
    name                 = "fk-nic02"
    location             = "centralindia"
    resource_group_name  = "rg-lb-ci-01"
    virtual_network_name = "vnet-lb-ci-01"
    subnet_name          = "subnet-fk-02"
    ip_configuration = {
      name                          = "ipconfig2"
      private_ip_address_allocation = "Dynamic"
    }
  }
}


vmm = {
  vm1 = {
    name                            = "vm-fk-01"
    location                        = "centralindia"
    resource_group_name             = "rg-lb-ci-01"
    size                            = "Standard_F2"
    admin_username                  = "fkvm01"
    admin_password                  = "fkvm01@123456"
    disable_password_authentication = false
    nic_name                        = "fk-nic01"

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }

  vm2 = {
    name                            = "vm-fk-02"
    location                        = "centralindia"
    resource_group_name             = "rg-lb-ci-01"
    size                            = "Standard_F2"
    admin_username                  = "fkvm02"
    admin_password                  = "fkvm02@123456"
    disable_password_authentication = false
    nic_name                        = "fk-nic02"

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}



nsgm = {
  name                = "fknsg01"
  location            = "centralindia"
  resource_group_name = "rg-lb-ci-01"
  subnet_name1        = "subnet-fk-01"
  subnet_name2        = "subnet-fk-02"
  nic_name1           = "fk-nic01"
  nic_name1           = "fk-nic02"

  security_rule = {
    name                       = "fkrule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}


ass_SNm = {
  ass1 = {
    subnet_name         = "subnet-fk-01"
    nic_name            = "fk-nic01"
    resource_group_name = "rg-lb-ci-01"
    nsg                 = "fknsg01"
    vnet_name           = "vnet-lb-ci-01"
  }

  ass2 = {
    subnet_name         = "subnet-fk-02"
    nic_name            = "fk-nic02"
    resource_group_name = "rg-lb-ci-01"
    nsg                 = "fknsg01"
    vnet_name           = "vnet-lb-ci-01"
  }
}


bastion_subnetm = {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "vnet-lb-ci-01"
  resource_group_name  = "rg-lb-ci-01"
  address_prefixes     = ["172.169.2.0/28"]
}


bpipm = {
  name                = "bastionpip01"
  location            = "centralindia"
  resource_group_name = "rg-lb-ci-01"
  allocation_method   = "Static"
  sku                 = "Standard"
}


bastionm = {
  name                 = "fkbastion"
  location             = "centralindia"
  resource_group_name  = "rg-lb-ci-01"
  virtual_network_name = "vnet-lb-ci-01"
  Bastion_subnet_name  = "AzureBastionSubnet"
  pip_name             = "bastionpip01"

  ip_configuration = {
    name = "bastionip"
  }
}


lbm = {
  name                = "fk-lb"
  location            = "centralindia"
  resource_group_name = "rg-lb-ci-01"
  sku                 = "Standard"
  lbpip_name          = "lbpip01"
  vnet_name           = "vnet-lb-ci-01"
  ip_config1          = "ipconfig1"
  ip_config2          = "ipconfig2"
  nic1_name           = "fk-nic01"
  nic2_name           = "fk-nic02"

  frontend_ip_configuration = {
    name = "lb-frontend-ip"
  }
  azurerm_lb_probe = {
    name                = "http-health-probe"
    port                = 80
    interval_in_seconds = 5
    number_of_probes    = 2
  }
  azurerm_lb_backend_address_pool = {
    name = "backendaddresspool"
  }

  azurerm_public_ip = {
    name              = "lbpip"
    allocation_method = "Static"
    sku               = "Standard"
  }

  azurerm_lb_rule = {
    name                           = "lbrule"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "lb-frontend-ip"
    idle_timeout_in_minutes        = 4
    enable_floating_ip             = false
  }
}





















