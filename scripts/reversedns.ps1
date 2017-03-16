$pip = Get-AzureRmPublicIpAddress -Name "KeskSuomDialog-pip-3dd79ffac86440839b18900a59478832" -ResourceGroupName "Dialog"
$pip.DnsSettings = New-Object -TypeName "Microsoft.Azure.Commands.Network.Models.PSPublicIpAddressDnsSettings"
$pip.DnsSettings.DomainNameLabel = "keskisuomalainen"
$pip.DnsSettings.ReverseFqdn = "keskisuomalainen.isteer.net."
Set-AzureRmPublicIpAddress -PublicIpAddress $pip
