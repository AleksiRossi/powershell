# Convert Virtual Machine disks to newer "Managed Disk" type

# Install-Module AzureRM
$resourceGroup = "Roger"
$vmName = "RogerTest"
Stop-AzureRmVM -ResourceGroupName $resourceGroup -Name $vmName -Force

ConvertTo-AzureRmVMManagedDisk -ResourceGroupName $resourceGroup -VMName $vmName