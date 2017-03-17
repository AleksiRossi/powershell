# Azure powershell

# Getting started

First you need to set up an Azure instance. This can be done here:
https://azure.microsoft.com/en-us/get-started/

Next you need to setup Powershell for Azure

Install Azure Powershell module for new Azure portal

    Install-Module AzureRM
  
Import all modules

    Import-Module AzureRM

You may run into issues depending on security settings. Following lets you run unknown modules and scripts

    Set-ExecutionPolicy Unrestricted
  
Now you should be able to login to your Azure instance

    Login-AzureRmAccount
    
Microsoft is constantly updating their cmdlets so you should get into the habit of upgrading your powershell

    Install-Module -Force AzureRM
