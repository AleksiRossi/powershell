$resourceGroup = "testGroup"
Get-AzureRmVM -ResourceGroupName $resourceGroup | Select Name