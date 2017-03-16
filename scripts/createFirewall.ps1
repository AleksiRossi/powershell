$location = "westeurope"
$resourceGroup = "testGroup"

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