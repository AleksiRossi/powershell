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

$NumberOfVM = 2

# Create resource group
New-AzureRmResourceGroup -Name $resourceGroup -Location $location


# Create VNET
$subnetConf = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetConf_name -AddressPrefix 10.50.100.0/24
$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroup -Location $location `
-Name $vnet_name -AddressPrefix 10.50.0.0/16 -Subnet $subnetConf

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

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name test_subnet


$i = 1;

Do 
{ 
    $i; 
    $vm_name+=$i
    $ip_name+=$i
    $nic_name+=$i

    $ip = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup -Location $location `
    -AllocationMethod Static -IdleTimeoutInMinutes 4 -Name $ip_name

    $nic = New-AzureRmNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nic_name `
    -Subnet $subnet -NetworkSecurityGroup $nsg -PublicIpAddress $ip
    
    $vmConfig = New-AzureRmVMConfig -VMName $vm_name -VMSize $vm_size | `
    Set-AzureRmVMOperatingSystem -Linux -ComputerName myVM -Credential $cred | `
    Set-AzureRmVMSourceImage -PublisherName Canonical -Offer UbuntuServer -Skus $ubuntuVersion -Version latest | `
    Add-AzureRmVMNetworkInterface -Id $nic.Id

    New-AzureRmVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig

    # Customization script
    $extensionName = 'NGINX'
    $Publisher = 'Microsoft.Azure.Extensions'
    $extensionType = "CustomScript"
    $Version = '2.0'

    $PublicConfiguration = '{"fileUris":["https://raw.githubusercontent.com/AleksiRossi/powershell/master/scripts/nginx.sh"], "commandToExecute": "sh nginx.sh" }' 

    Set-AzureRmVMExtension -ResourceGroupName $resourceGroup -VMName $vm_name -Location $location `
    -Name eExtensionName -Publisher $Publisher -TypeHandlerVersion $Version `
    -ExtensionType $extensionType -Settingstring $PublicConfiguration

     $i +=1
} 
Until ($i -gt $NumberOfVM)