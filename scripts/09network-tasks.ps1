# get all ip adresses in use on the local pc
Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true | 
Select-Object -ExpandProperty IPAddress

Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true | 
Get-Member -Name IPAddress

# list ip configuration data
Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true
Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true |
Select-Object -ExcludeProperty IPX*, WINS*

# pinging computers
Get-CimInstance -Class Win32_PingStatus -Filter "Address='127.0.0.1'"
Get-CimInstance -Class Win32_PingStatus -Filter "Address='127.0.0.1'" |
Format-Table -Property Address, ResponseTime, StatusCode -Autosize
    
# ping multiple
'127.0.0.1', 'localhost', 'bing.com' |
ForEach-Object -Process {
  Get-CimInstance -Class Win32_PingStatus -Filter ("Address='$_'") |
  Select-Object -Property Address, ResponseTime, StatusCode
}

1..254 | ForEach-Object -Process {
  Get-CimInstance -Class Win32_PingStatus -Filter ("Address='192.168.1.$_'") } |
Select-Object -Property Address, ResponseTime, StatusCode

# get network adapter props
# Get-CimInstance -Class Win32_NetworkAdapter -ComputerName . #fails
# Assigning the DNS domain for a network adapter
# $wql = 'SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled=True'
# $args = @{ DnsDomain = 'fabrikam.com'}
# Invoke-CimMethod -MethodName SetDNSDomain -Arguments $args -Query $wql


# Finding DHCP-enabled adapter
Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true"
Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true and DHCPEnabled=$true"
# retrieve dhcp props
Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter  "IPEnabled=$true and DHCPEnabled=$true" |
Format-Table -Property DHCP*

# creating a network share
Invoke-CimMethod -ClassName Win32_Share -MethodName Create -Arguments @{
  Path           = 'C:\temp'
  Name           = 'TempShare'
  Type           = [uint32]0 #Disk Drive
  MaximumAllowed = [uint32]25
  Description    = 'test share of the temp folder'
}
# or
net share tempshare=c:\temp /users:25 /remark:"test share of the temp folder"

#  list the methods of the Win32_Class
(Get-CimClass -ClassName Win32_Share).CimClassMethods
# list the parameters of the Create method.
(Get-CimClass -ClassName Win32_Share).CimClassMethods['Create'].Parameters

# remove a network share
$wql = 'SELECT * from Win32_Share WHERE Name="TempShare"'
Invoke-CimMethod -MethodName Delete -Query $wql