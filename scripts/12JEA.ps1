# Define role capabilities for a JEA endpoint
New-PSRoleCapabilityFile
# Create a session configuration file to register a JEA endpoint
New-PSSessionConfigurationFile
# find existing JEA endpoints:
Get-PSSessionConfiguration | Select-Object Name
# register the endpoint DNSOps using the DNSOps.pssc session configuration file
Register-PSSessionConfiguration -Name DNSOps -Path .\DNSOps.pssc
# interactive JEA connection
Enter-PSSession -<ComputerName> localhost -ConfigurationName DNSOps #start
Exit-PSSession #stop
Invoke-Command -ComputerName Server01, Server02 -ScriptBlock { Get-UICulture } #run a remote command
Invoke-Command -ComputerName Server01, Server02 -FilePath c:\Scripts\DiskCollect.ps1 # run a script on multiple pcs
# establish a persistent connection
$s = New-PSSession -ComputerName Server01, Server02
Invoke-Command -Session $s { $h = Get-HotFix }
Invoke-Command -Session $s { $h | where { $_.InstalledBy -ne "NT AUTHORITY\SYSTEM" } }
# Implicit remoting and JEA
$DNSOpssession = New-PSSession -ComputerName 'MyServer' -ConfigurationName 'DNSOps'
Import-PSSession -Session $DNSOpssession -Prefix 'DNSOps' Get-DNSOpsCommand