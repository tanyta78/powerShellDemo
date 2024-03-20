# Get-Process | Get-Member
# Get-Process | Sort-Object -Descending -Property Name
# Get-Process | Sort-Object -Descending -Property Name, CPU
# Get-Process | Where-Object CPU -gt 2 | Sort-Object CPU -Descending | Select-Object -First 3

$serviceName = 'Spooler'
Get-Service -Name $serviceName

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