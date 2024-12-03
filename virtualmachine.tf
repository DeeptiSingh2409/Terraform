provider "azurerm" {
  features {}
  subscription_id = "3a72be92-287b-4f1e-840a-5e3e71100139"  # Replace with your actual subscription ID
  resource_provider_registrations = "none"
}
resource "azurerm_network_interface" "deeptinic" {
  name                = "deeptinic"
  location            = "UK South"
  resource_group_name = "rg-aztraining-cat-uk"

  ip_configuration {
    name                          = "deeptiip"
    subnet_id                     = "/subscriptions/3a72be92-287b-4f1e-840a-5e3e71100139/resourceGroups/rg-aztraining-cat-uk/providers/Microsoft.Network/virtualNetworks/deeptivnet/subnets/deeptisubnet1"
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_windows_virtual_machine" "deeptivm" {
  name                = "deeptivm"
  resource_group_name = "rg-aztraining-cat-uk"
  location            = "UK South"
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.deeptinic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
 
