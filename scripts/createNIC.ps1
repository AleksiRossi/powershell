$location = "westeurope"
$resourceGroup = "testGroup"
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroup -Location $location `
-Name $vnet_name
$nic_name = "test_nic"

# Create network adapter
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name test_subnet
$nic = New-AzureRmNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nic_name `
-Subnet $subnet