########## GETTING PROCESSES ##################
Get-Process
Get-Process -id 0 # fails if no process with such id
Get-Process -Name ex* # gets process whose names begin with "ex"
Get-Process -Name exp*, power* #accepts multiple values for name parameters

Get-Process | Get-Member
Get-Process | Sort-Object -Descending -Property Name
Get-Process | Sort-Object -Descending -Property Name, CPU
Get-Process | Where-Object CPU -gt 2 | Sort-Object CPU -Descending | Select-Object -First 3

# Get-Process -Name PowerShell -ComputerName localhost, Server01, Server01 |    Format-Table -Property ID, ProcessName, MachineName

########## STOPPING PROCESSES ##################
Stop-Process -Name Idle
Stop-Process -Name t*, e* -Confirm # force prompting with the confirm param
Invoke-Command -ComputerName Server01 { Stop-Process Powershell } # for stop the process on the remote computer

# see also
# Start-Process
# Wait-Process
# Debug-Process

########## MANAGING SERVICES ##################

$serviceName = 'Spooler'
Get-Service -Name $serviceName
Get-Service -Name se*
Get-Service -ComputerName Server01 # getting remote services on Server1 -Starting in PowerShell 6.0, the *-Service cmdlets don't have the ComputerName parameter.
Invoke-Command -ComputerName Server02 -ScriptBlock { Get-Service }

Get-Help Stop-Service -Full

# Stop-Service [-InputObject] <ServiceController[]> [-Force] [-NoWait] [-PassThru] [-Include <string[]>] [-Exclude <string[]>] [-WhatIf] [-Confirm] [<CommonParameters>]

# (Get-Service -Name $serviceName).GetType()
Get-Service -Name $serviceName | Stop-Service
Get-Service -Name $serviceName

Get-Help Get-Service -Full

$serviceName | Get-Service | Start-Service

$services = New-Object -TypeName System.Collections.ArrayList
$services.AddRange(@('spooler', 'w32time'))

$services | Get-Service 
$services | Get-Service | ForEach-Object { Write-Output "Service: $($_.DisplayName) is currently $($_.Status)" }

# Getting required and dependent services
Get-Service -Name LanmanWorkstation -RequiredServices
Get-Service -Name LanmanWorkstation -DependentServices

Get-Service -Name * | Where-Object { $_.RequiredServices -or $_.DependentServices } |
Format-Table -Property Status, Name, RequiredServices, DependentServices -auto

# see also Set-Service for setting service properties - need run as administrator