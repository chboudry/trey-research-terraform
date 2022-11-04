#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.company_prefix}keyvault"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg-platform-identity.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = data.azurerm_client_config.current.object_id

  #   key_permissions = [
  #     "Get",
  #   ]

  #   secret_permissions = [
  #     "Get",
  #   ]

  #   storage_permissions = [
  #     "Get",
  #   ]
  # }
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = "${var.company_prefix}vault"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-platform-identity.name
  sku                 = "Standard"

  soft_delete_enabled = true
}

resource "azurerm_network_interface" "dc1nic" {
  name                = "${var.company_prefix}dc1nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-platform-identity.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.identity.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "dc1" {
  name                = "dc1"
  resource_group_name = azurerm_resource_group.rg-platform-identity.name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [azurerm_network_interface.dc1nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}