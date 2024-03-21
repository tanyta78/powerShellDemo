# get powershell version
$PSVersionTable.PSVersion
pwsh -ver

# get module
Get-Module

# install azure power shell
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery # fails with error Install-Package: The following commands are already available on this system:'Login-AzAccount,Logout-AzAccount,Resolve-Error,Send-Feedback'. This module 'Az.Accounts' may override the existing commands. If you
# still want to install this module 'Az.Accounts', use -AllowClobber parameter.

# update az powershell module
Update-Module -Name Az

# !!!! IMPORTANT NEEDS AZURE ACCOUNT
# connect account 
Connect-AzAccount
# with subscription
Set-AzContext -Subscription '00000000-0000-0000-0000-000000000000'

# get list of all resourse groups in active subscription
Get-AzResourceGroup | Format-Table

# create new resource group
# New-AzResourceGroup -Name <name> -Location <location>

# verify resources
Get-AzResource | Format-Table
Get-AzResource -ResourceGroupName ExerciseResources #filtered specific group

#create azure virtual machine
# New-AzVm
#        -ResourceGroupName <resource group name>
#        -Name <machine name>
#        -Credential <credentials object>
#        -Location <location>
#        -Image <image name>

# list vms
Get-AzVM -Status
# get and update specific machine
$ResourceGroupName = "ExerciseResources"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"

Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm


####### EXERCISE #########
# Create a Linux VM with Azure PowerShell
New-AzVm -ResourceGroupName learn-f773b641-352f-4adf-b0a2-c4e1e50693da -Name "testvm-eus-01" -Credential (Get-Credential) -Location "eastus" -Image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest -OpenPorts 22 -PublicIpAddressName "testvm-eus-01" # will be prompted for user name and password

# when completed we can assign this machine to a value
$vm = (Get-AzVM -Name "testvm-eus-01" -ResourceGroupName learn-f773b641-352f-4adf-b0a2-c4e1e50693da)
$vm.HardwareProfile
$vm.StorageProfile.OsDisk
$vm | Get-AzVMSize
Get-AzPublicIpAddress -ResourceGroupName learn-f773b641-352f-4adf-b0a2-c4e1e50693da -Name "testvm-eus-01"

# stop and delete vm
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName

# list all resources
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table

# The Remove-AzVM command just deletes the VM. It doesn't clean up any of the other resources.
# manually delete the network interface 
$vm | Remove-AzNetworkInterface –Force
# remove managed os disks
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
# delete vitual network
Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
# Delete the network security group:
Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
# delete the public ip
Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force

# $adminCredential = Get-Credential
# $loc = "East US"
# New-AzResourceGroup -Name "MyResourceGroup" -Location $loc

# When you execute a script, you can pass arguments on the command line. You can provide names for each parameter to help the script extract the values. For example:
.\setupEnvironment.ps1 -size 5 -location "East US"
# Inside the script, you'll capture the values into variables. In this example, the parameters are matched by name:
param([string]$location, [int]$size)

####### EXERCISE #########
# Write a script to create virtual machines

param([string]$resourceGroup)
$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."
For ($i = 1; $i -le 3; $i++) {
  $vmName = "ConferenceDemo" + $i
  Write-Host "Creating VM: " $vmName
  New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest
}
# Run the script
# ./ConferenceDailyReset.ps1 learn-f773b641-352f-4adf-b0a2-c4e1e50693da
# check if script created the required vms
Get-AzResource -ResourceType Microsoft.Compute/virtualMachines

# The sandbox automatically cleans up your resources when you're finished with this module.

# When you're working in your own subscription, it's a good idea at the end of a project to identify whether you still need the resources you created. Resources that you leave running can cost you money. You can delete resources individually or delete the resource group to delete the entire set of resources.

# When you're running in your own subscription, you can use the following PowerShell cmdlet to delete the resource group and all related resources (replacing MyResourceGroupName with the resource group you created).
Remove-AzResourceGroup -Name MyResourceGroupName
