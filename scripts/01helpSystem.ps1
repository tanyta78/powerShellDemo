Get-Command -Name *service*

Get-Command -Noun Process

Get-Command -Name *service* -CommandType Cmdlet, Function, Alias

# My challenge to you is to learn a PowerShell command a day.
Get-Command | Get-Random | Get-Help -Full

Get-Help Stop-Service -Full

Update-Help
Get-Module -ListAvailable | Where-Object -Property 

Get-Service -Name w32time | Get-Member
Get-Command -ParameterType ServiceController
Get-Service -Name w32time | Select-Object -Property *
Get-Service -Name w32time | Get-Member -MemberType Method

Get-Command -Module ActiveDirectory

$Users = Get-ADUser -Identity mike -Properties *
$Users | Select-Object -Property Name, LastLogonDate, LastBadPasswordAttempt

Get-Process | Get-Member | Out-Host -Paging
Get-Process | Get-Member -MemberType Properties