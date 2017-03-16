## Global
$rgName = "Roger"
$location = "westeurope"

## Storage
$storageName = "rogerdiag468"

## Network
$nicname = "testnic"
$subnet1Name = "Internal"
$vnetName = "Roger"

## Compute
$vmName = "testvm"
$computerName = "master"
$vmSize = "Standard_A1"
$osDiskName = $vmName + "osDisk"

$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName  
$nic = New-AzureRmNetworkInterface -Name $nicname -ResourceGroupName $rgName -Location $location -SubnetId $vnet.Subnets[0].Id

## Setup local VM object
$cred = Get-Credential
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize

$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

$osDiskUri = "https://rogerdiag468.blob.core.windows.net/vm-images/ipssoaa41.vhd"
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $osDiskName -VhdUri $osDiskUri -CreateOption attach -Linux
New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vm -Verbose -Debug