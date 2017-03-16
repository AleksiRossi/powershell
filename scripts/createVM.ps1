# Variables used

$location = "westeurope"
$resourceGroup = "testGroup"
$subnetConf_name = "test_subnet"
$vnet_name = "test_vnet"
$ip_name = "test_ip"
$nsg_name = "test_nsg"
$nic_name = "test_nic"
$username = "pikkukarhu"
$password = ConvertTo-SecureString 'h4aukiOnKala' -AsPlainText -Force
$vm_name = "testVM"
$vm_size = "Basic_A1"
$ubuntuVersion = "16.04.0-LTS"


# Create resource group
New-AzureRmResourceGroup -Name $resourceGroup -Location $location

# Create VNET
$subnetConf = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetConf_name -AddressPrefix 10.50.100.0/24

$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroup -Location $location `
-Name $vnet_name -AddressPrefix 10.50.0.0/16 -Subnet $subnetConf

# Create static ip
$ip = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup -Location $location `
-AllocationMethod Static -IdleTimeoutInMinutes 4 -Name $ip_name

# Get your own public ip
$ipinfo = Invoke-RestMethod http://ipinfo.io/json

# Firewall rules
$SSH_rule = New-AzureRmNetworkSecurityRuleConfig -Name AllowSSH  -Protocol Tcp `
-Direction Inbound -Priority 1000 -SourceAddressPrefix $ipinfo.ip -SourcePortRange * -DestinationAddressPrefix * `
-DestinationPortRange 22 -Access Allow

$HTTP_rule = New-AzureRmNetworkSecurityRuleConfig -Name AllowHTTP  -Protocol Tcp `
-Direction Inbound -Priority 1010 -SourceAddressPrefix $ipinfo.ip -SourcePortRange * -DestinationAddressPrefix * `
-DestinationPortRange 80 -Access Allow

# Create Firewall (Network security group)
$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location `
-Name $nsg_name -SecurityRules $SSH_rule,$HTTP_rule

# Create network adapter
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name test_subnet
$nic = New-AzureRmNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nic_name `
-Subnet $subnet -NetworkSecurityGroup $nsg -PublicIpAddress $ip

# Create user credentials for the VM
$cred = New-Object System.Management.Automation.PSCredential ($username, $password)

# VM configuration
$vmConfig = New-AzureRmVMConfig -VMName $VM_name -VMSize $vm_size | `
Set-AzureRmVMOperatingSystem -Linux -ComputerName myVM -Credential $cred | `
Set-AzureRmVMSourceImage -PublisherName Canonical -Offer UbuntuServer -Skus $ubuntuVersion -Version latest | `
Add-AzureRmVMNetworkInterface -Id $nic.Id

# Finally start the creation of the VM
New-AzureRmVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig

# Install Apache
$PublicSettings = '{"commandToExecute":"apt-get -y update && apt-get -y install apache2"}'

Set-AzureRmVMExtension -ExtensionName "Apache" -ResourceGroupName $resourceGroup -VMName $vm_name `
  -Publisher "Microsoft.Azure.Extensions" -ExtensionType "CustomScript" -TypeHandlerVersion 2.0 `
  -SettingString $PublicSettings -Location $location

