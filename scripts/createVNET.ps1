$location = "westeurope"
$resourceGroup = "testGroup"
$subnetConf_name = "test_subnet"
$vnet_name = "test_vnet"

# Create VNET
$subnetConf = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetConf_name -AddressPrefix 10.50.100.0/24

$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroup -Location $location `
-Name $vnet_name -AddressPrefix 10.50.0.0/16 -Subnet $subnetConf