# Collection of most common and usefull commands

## Login and Subscription info

LoginAzureRmAccount = Logs you into your Azure instance

Get-AzureRmSubscription = Get subscription info

Set-AzureRmSubscription = Set subscription if you have several

## Get info on Azure and your environment

Get-AzureRmVM = List your VMs

Get-AzureRmLocation | sort Location | Select Location = List of available locations

Get-AzureRmVMImageSku -Location $location -PublisherName Canonical -Offer UbuntuServer = List of available Ubuntu distros

Get-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup | Select IpAddress = List public IP addresses

Get-Command *AzureRm* = List all available Azure Resource Manager cmdlets

## Management

New-AzureRmResourceGroup = Create resource group

New-AzureRmVM = Create new VM

Start-AzureRmVM -ResourceGroupName $myResourceGroup -Name $myVM = Start VM

Stop-AzureRmVM -ResourceGroupName $myResourceGroup -Name $myVM = Stop VM

Stop-AzureRmVM -ResourceGroupName $myResourceGroup -Name $myVM -Force = Stop and deallocate VM

Remove-AzureRmVM -ResourceGroupName $myResourceGroup -Name $myVM = Delete VM
