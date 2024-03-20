# Set-StrictMode -Version latest
# Set-StrictMode -off

# $myHashTable = @{
#   key1  = 100
#   apple = 2.34
#   name  = 'John'
#   key2  = 2
#   key3  = $true
# }

# $myHashTable.GetType()

# $myHashTable.Keys
# $myHashTable.Values
# $myHashTable.key3 = 3
# $myHashTable.key3
# $myHashTable.key4
# $myHashTable.ContainsKey('key4')

# $myHashTable.Count
# $myHashTable.Add('key4', 'testing add func')
# $myHashTable.Add('4', 'testing add func')
# $myHashTable['key5'] = 'added with square brackets'
# $myHashTable.key6 = 'added with dot notation'

# $myHashTable.Remove('4')
# $myHashTable

#############################################

$employee = New-Object -TypeName PSCustomObject

$employee.GetType()

# Add-Member -InputObject $employee -MemberType NoteProperty -Name 'EmployeeID' -Value '1001'
# Add-Member -InputObject $employee -MemberType NoteProperty -Name 'FirstName' -Value 'Petar'
# Add-Member -InputObject $employee -MemberType NoteProperty -Name 'Title' -Value 'CEO'

$employee2 = [PSCustomObject]@{
  EmployeeID = 1001
  FirstName  = "Petar"
  Title      = "CEO"
}

$employee2

Get-Member -InputObject $employee

##########SELECTING PARTS OF OBJECT##################

Get-Process | Get-Member -MemberType Properties #list only members that are properties.

#  create a new object that includes only the Name and FreeSpace properties of the Win32_LogicalDisk WMI class
Get-CimInstance -Class Win32_LogicalDisk |
Select-Object -Property Name, FreeSpace

# in gb
Get-CimInstance -Class Win32_LogicalDisk |
Select-Object -Property Name, @{
  label      = 'FreeSpace'
  expression = { ($_.FreeSpace / 1GB).ToString('F2') }
}

##########REMOVING OBJECTS FROM PIPELINE##################
# Filter the system drivers, selecting only the running ones 
Get-CimInstance -Class Win32_SystemDriver |
Where-Object { $_.State -eq 'Running' }
    
# filter to only select the drivers set to start automatically by testing the StartMode value as well
Get-CimInstance -Class Win32_SystemDriver |
Where-Object { $_.State -eq "Running" } |
Where-Object { $_.StartMode -eq "Auto" }

Get-CimInstance -Class Win32_SystemDriver |
Where-Object { $_.State -eq "Running" } |
Where-Object { $_.StartMode -eq "Manual" } |
Format-Table -Property Name, DisplayName
    
# same as above but using -and logical operator
Get-CimInstance -Class Win32_SystemDriver |
Where-Object { ($_.State -eq 'Running') -and ($_.StartMode -eq 'Manual') } |
Format-Table -Property Name, DisplayName

########## SORTING OBJECTS - BASIC ##################
# listing subdirectories and files in the current directory. If we want to sort by LastWriteTime and then by Name
Get-ChildItem |
Sort-Object -Property LastWriteTime, Name |
Format-Table -Property LastWriteTime, Name

# in reverse order
Get-ChildItem |
Sort-Object -Property LastWriteTime, Name -Descending |
Format-Table -Property LastWriteTime, Name

########## SORTING OBJECTS - USING HASH TABLES ##################
Get-ChildItem |
Sort-Object -Property @{ Expression = 'LastWriteTime'; Descending = $true },
@{ Expression = 'Name'; Ascending = $true } |
Format-Table -Property LastWriteTime, Name

Get-ChildItem |
Sort-Object -Property @{ Exp = { $_.LastWriteTime - $_.CreationTime }; Desc = $true } |
Format-Table -Property LastWriteTime, CreationTime

# same as above but with less code
$order = @(
  @{ Expression = 'LastWriteTime'; Descending = $true }
  @{ Expression = 'Name'; Ascending = $true }
)

Get-ChildItem |
Sort-Object $order |
Format-Table LastWriteTime, Name

