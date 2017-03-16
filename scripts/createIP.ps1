$location = "westeurope"
$resourceGroup = "testGroup"
$ip_name = "test_ip"

# Create static ip
$ip = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup -Location $location `
-AllocationMethod Static -IdleTimeoutInMinutes 4 -Name $ip_name