# Scripts

All scripts are made with variables to are quick to edit for your needs. They've been made modular so you can use only those you need.

createRG.ps1 = Creates resource group

createVNET.ps1 = Creates Azure VNET

createIP.ps1 = Creates a public IP address

createNIC.ps1 = Creates a network adapter for VM

createFirewall.ps1 = Creates a network security group with 2 rules to allow your public IP to port 22 and 80

createVM.ps1 = Creates a VM with specifications and customizes it with custom extension

getIP.ps1 = List all public IP addresses in resource group

nginx.sh = Custom extension script to install Nginx webserver

ipinfo.ps1 = Fetches your own public IP address

cleanup.ps1 = Removes everything from Azure instance - USE WITH CARE

convert_to_managed_disk.ps1 = Converts VM to use new managed disk instead of old unmanaged disk

reversedns.ps1 = Sets a reverse DNS name for VM

ImportVM.ps1 = Imports a VM based on existing VHD
