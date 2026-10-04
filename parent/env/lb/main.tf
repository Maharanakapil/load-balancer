module "resource_group" {
  source = "../../../source/rg"
  rgs    = var.rgm
}

module "virtual_network" {
  source = "../../../source/vnet"
  vnets  = var.vnetm
}

module "subnet" {
  source  = "../../../source/subnet"
  subnets = var.subnetm
}

module "nic" {
  source = "../../../source/nic"
  nics   = var.nicm
}

module "linux_virtual_machine" {
  source = "../../../source/vm"
  vms    = var.vmm
}

module "network_security_group" {
  source = "../../../source/nsg"
  nsgs   = var.nsgm
}
module "bastion_subnet" {
  source          = "../../../source/bastionsubnet"
  bastion_subnets = var.bastion_subnetm
}

module "bastion_pip" {
  source = "../../../source/bpip"
  bpips  = var.bpipm
}

module "bastion-host" {
  source   = "../../../source/bastion"
  bastions = var.bastionm
}

module "lb" {
  source = "../../../source/lb"
  lbs    = var.lbm
}

module "ass_SNm" {
  source  = "../../../source/ass nic & subnet"
  ass_SNs = var.ass_SNm
}


