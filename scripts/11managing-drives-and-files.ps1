####### MANAGING CURRENT LOCATION #########

# Getting your current location (Get-Location)
Get-Location
# Setting your current location (Set-Location) similar to cd;
#  You can type Set-Location or use any of the built-in PowerShell aliases for Set-Location (cd, chdir, sl).
Set-Location -Path C:\Windows 
Set-Location -Path .. -PassThru
# cd -Path C:\Windows
# chdir -Path .. -PassThru
# sl -Path HKLM:\SOFTWARE -PassThru

Push-Location -Path "Local Settings"
Push-Location -Path Temp
Pop-Location -PassThru
Get-Location
# Set-Location \\FS01\Public - example with network paths

####### MANAGING POWER SHELL DRIVES #########

Get-PSDrive
Get-PSDrive -PSProvider 
Get-PSDrive -PSProvider Registry

# adding new powershell drives
Get-Command -Name New-PSDrive -Syntax #get info for cmdlet syntax
# New-PSDrive -Name Office -PSProvider FileSystem -Root "C:\Program Files\Microsoft Office\OFFICE11"
# delete powershell drives
# Remove-PSDrive -Name Office


####### WORKING WITH FILES AND FOLDERS #########
Get-ChildItem -Path C:\ 
Get-ChildItem -Path C:\ -Force -Recurse
Get-ChildItem -Path $env:ProgramFiles -Recurse -Include *.exe |
Where-Object -FilterScript {
        ($_.LastWriteTime -gt '2005-10-01') -and ($_.Length -ge 1mb) -and ($_.Length -le 10mb)
}

# Coping files and folders - If the destination file already exists, the copy attempt fails. To overwrite a pre-existing destination, use the Force parameter:
if (Test-Path -Path $PROFILE) {
  Copy-Item -Path $PROFILE -Destination $($PROFILE -replace 'ps1$', 'bak') -Force
}

Copy-Item C:\temp\test1 -Recurse C:\temp\DeleteMe
Copy-Item -Filter *.txt -Path c:\data -Recurse -Destination C:\temp\text

# creating files and folders
New-Item -Path 'C:\temp\New Folder' -ItemType Directory
New-Item -Path 'C:\temp\New Folder\file.txt' -ItemType File

# removing all files and folders within a folder
Remove-Item -Path C:\temp\DeleteMe

# mapping a local folder as a drive
New-PSDrive -Name P -Root $env:ProgramFiles -PSProvider FileSystem

# Reading a text file into an array
Get-Content -Path $PROFILE
# Load modules and change to the PowerShell-Docs repository folder
# Import-Module posh-git
# Set-Location C:\Git\PowerShell-Docs
# $Computers = Get-Content -Path C:\temp\DomainMembers.txt

# Listing all contained items
# Get-Command -Name Get-ChildItem -Syntax
Get-ChildItem -Path C:\WINDOWS -Recurse
# Forcibly listing hidden items
Get-ChildItem -Path C:\Windows -Force

Get-ChildItem -Path C:\Windows\*.dll -Recurse -Exclude [a-y]*.dll

# Listing registry entries
Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion |
Select-Object -ExpandProperty Property
#  or
Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion

# Getting a single registry entry
Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion -Name DevicePath  #exm with DevicePath