########## Windows Management Instrumentation ##################
Get-CimClass -Namespace root/CIMV2 | 
Where-Object CimClassName -like Win32* | 
Select-Object CimClassName

# If you already know the name of a WMI class, you can use it to get information immediately
Get-CimInstance -Class Win32_OperatingSystem

# You can use Get-Member to see all the properties
Get-CimInstance -Class Win32_OperatingSystem | Get-Member -MemberType Property
# If you want the information contained in the Win32_OperatingSystem class that isn't displayed by default, you can display it by using the Format cmdlets. For example, if you want to display available memory data, type:
Get-CimInstance -Class Win32_OperatingSystem | Format-Table -Property TotalVirtualMemorySize, TotalVisibleMemorySize, FreePhysicalMemory, FreeVirtualMemory, FreeSpaceInPagingFiles
Get-CimInstance -Class Win32_OperatingSystem | Format-List Total*Memory*, Free*

