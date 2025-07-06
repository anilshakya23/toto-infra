variable "resource_group_name" {
    description = "The name of the resource group where the VM will be created."
    type        = string    
}

variable "vm_name" {
    description = "The name of the virtual machine."
    type        = string
}

variable "vm_location" {
    description = "The location of the virtual machine."
    type        = string
    default     = ""
}
variable "vm_size" {
    description = "The size of the virtual machine."
    type        = string
    default     = "Standard_DS1_v2"
}
variable "admin_username" {
    description = "The administrator username for the virtual machine."
    type        = string
}
variable "admin_password" {
    description = "The administrator password for the virtual machine."
    type        = string
    sensitive   = true
}
variable "image_publisher" {
    description = "The publisher of the image to use for the virtual machine."
    type        = string
    default     = "Canonical"
}
variable "image_offer" {
    description = "The offer of the image to use for the virtual machine."
    type        = string
    default     = "0001-com-ubuntu-server-jammy"
}
variable "image_sku" {
    description = "The SKU of the image to use for the virtual machine."
    type        = string
    default     = "22_04-lts"
}
variable "image_version" {
    description = "The version of the image to use for the virtual machine."
    type        = string
    default     = "latest"
}
variable "nic_name" {
    description = "The name of the network interface."
    type        = string
}
variable "nic_location" {
    description = "The location of the network interface."
    type        = string
    default     = ""
}
variable "ip_configuration_name" {
    description = "The name of the IP configuration for the network interface."
    type        = string
    default     = "ipconfig1"
}
variable "private_ip_address_allocation" {
    description = "The private IP address allocation method (Static or Dynamic)."
    type        = string
    default     = "Dynamic"
}
variable "data_subnet_name" {
    description = "The name of the data subnet."
    type        = string
    default     = "default"
}
variable "vnet_name" {
    description = "The name of the virtual network."
    type        = string
    default     = ""
  
}

variable "public_ip_name" {
    description = "The name of the public IP address."
    type        = string
    default     = ""
  
}
