data "azurerm_subnet" "data_subnet" {
  name                 = var.data_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "data_public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}
