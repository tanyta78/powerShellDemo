########## CHANGING PC STATE ##################
# lock the pc
# rundll32.exe user32.dll,LockWorkStation

# logging off the currenty session
# shutdown.exe -l
# Get-CimInstance -ClassName Win32_OperatingSystem | Invoke-CimMethod -MethodName Shutdown - for more info

# stop restart
# Stop-Computer
# Restart-Computer
# Restart-Computer -Force

########## COLLECTING INFO FOR PC ##################
# CIM - Common Information Model
# list desktop settings
Get-CimInstance -ClassName Win32_Desktop

# list BIOS info
Get-CimInstance -ClassName Win32_Processor | Select-Object -ExcludeProperty "CIM*"
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType

# list pc manufacturer and model
Get-CimInstance -ClassName Win32_ComputerSystem

# list installed hotfixes
Get-CimInstance -ClassName Win32_QuickFixEngineering
Get-CimInstance -ClassName Win32_QuickFixEngineering -Property HotFixId | Select-Object -Property HotFixId

# Listing operating system version information
Get-CimInstance -ClassName Win32_OperatingSystem |  Select-Object -Property BuildNumber, BuildType, OSType, ServicePackMajorVersion, ServicePackMinorVersion

# Listing local users and owner
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property NumberOfLicensedUsers, NumberOfUsers, RegisteredUser

# Getting available disk space
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" |    Measure-Object -Property FreeSpace, Size -Sum |    Select-Object -Property Property, Sum

# Getting logon session information
Get-CimInstance -ClassName Win32_LogonSession

# Getting the user logged on to a computer
Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName

# Getting local time from a compute
Get-CimInstance -ClassName Win32_LocalTime

# display servise status
Get-CimInstance -ClassName Win32_Service |    Select-Object -Property Status, Name, DisplayName
Get-CimInstance -ClassName Win32_Service |    Format-Table -Property Status, Name, DisplayName -AutoSize -Wrap

Get-Help Get-CimInstance

# Creating Get-WinEvent queries with FilterHashtable - The following command uses a hash table that improves the performance.The old unefficient way was to use 
# Get-EventLog -LogName Application | Where-Object Source -Match defrag
Get-WinEvent -FilterHashtable @{
  LogName      = 'Application'
  ProviderName = '*defrag'
}

Get-WinEvent -FilterHashtable @{
  LogName      = 'Application'
  ProviderName = '.NET Runtime'
}

# Use the following command to display the StandardEventKeywords property names.
[System.Diagnostics.Eventing.Reader.StandardEventKeywords] |    Get-Member -Static -MemberType Property

# filtering by event id
Get-WinEvent -FilterHashtable @{
  LogName      = 'Application'
  ProviderName = '.NET Runtime'
  Keywords     = 36028797018963968
  ID           = 1026
}