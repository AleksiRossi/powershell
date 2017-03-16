# NEVER USE IN PRODUCTION INSTANCE
# Will remove all resources

#Run Login first if you aren't already logged in
#Login-AzureRmAccount

$rgName = Get-AzureRmResourceGroup 

Foreach($name in $rgName)
{
Write-Host $name.ResourceGroupName
Remove-AzureRmResourceGroup -Name $name.ResourceGroupName -Verbose -Force
}