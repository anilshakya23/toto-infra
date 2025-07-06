module "todo-infra" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "todo-infra-rg"
  resource_group_location = "East US"
}
module "todo-infra-vnet" {
  depends_on          = [module.todo-infra]
  source              = "../modules/azurerm_vnet"
  resource_group_name = "todo-infra-rg"
  vnet_name           = "todo-infra-vnet"
  vnet_location       = "East US"
  address_space       = ["10.0.0.0/16"]
}
module "todo-infra-subnet" {
  depends_on          = [module.todo-infra-vnet]
  source              = "../modules/azurerm_subnet"
  resource_group_name = "todo-infra-rg"
  vnet_name           = "todo-infra-vnet"
  subnet_name         = "todo-infra-subnet"
  address_prefixes    = ["10.0.1.0/24"]
}

module "todo-infra-pip" {
  depends_on          = [module.todo-infra]
  source              = "../modules/azurerm_pip_ip"
  resource_group_name = "todo-infra-rg"
  pip_name            = "todo-infra-pip"
  pip_location        = "East US"
  allocation_method   = "Static"
  sku                 = "Standard"
}

data "azurerm_key_vault" "todo-kw" {
  name                = "keyvaultyami"
  resource_group_name = "keyvaultrg"
}

data "azurerm_key_vault_secret" "secret_username" {
name = "vmusername"
key_vault_id = data.azurerm_key_vault.todo-kw.id
}

data "azurerm_key_vault_secret" "secret_password" {
name = "vmpassword"
key_vault_id = data.azurerm_key_vault.todo-kw.id
}

module "todo-infra-azurerm_linux_virtual_machine" {
  depends_on                    = [module.todo-infra, module.todo-infra-vnet, module.todo-infra-subnet, module.todo-infra-pip]
  source                        = "../modules/azurerm_vm"
  resource_group_name           = "todo-infra-rg"
  vm_name                       = "todo-infra-vm"
  vm_location                   = "East US"
  vnet_name                     = "todo-infra-vnet"
  nic_name                      = "todo-infra-nic"
  nic_location                  = "East US"
  ip_configuration_name         = "todo-infra-ipconfig"
  data_subnet_name              = "todo-infra-subnet"
  private_ip_address_allocation = "Dynamic"
  public_ip_name                = "todo-infra-pip"
  vm_size                       = "Standard_B1s"
  admin_username                = data.azurerm_key_vault_secret.secret_username.value
  admin_password                = data.azurerm_key_vault_secret.secret_password.value
  image_publisher               = "Canonical"
  image_offer                   = "0001-com-ubuntu-server-jammy"
  image_sku                     = "22_04-lts-gen2"
  image_version                 = "latest"
}