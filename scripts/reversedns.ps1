$resourceGroup
$ipName

$ip = Get-AzureRmPublicIpAddress -Name $ipName -ResourceGroupName $resourceGroup
$ip.DnsSettings = New-Object -TypeName "Microsoft.Azure.Commands.Network.Models.PSPublicIpAddressDnsSettings"
$ip.DnsSettings.DomainNameLabel = "domain"
$ip.DnsSettings.ReverseFqdn = "domain.example.fi"
Set-AzureRmPublicIpAddress -PublicIpAddress $ip
