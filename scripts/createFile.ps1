
# $date = get-date
# $date
# $name = Read-Host -Prompt 'Input your name'
# write-output "Today's date is $date."
# Write-Output "Today is the day $name began a PowerShell programming journey."
# CreateFile.ps1
# Param (
#   $Path
# )
# New-Item $Path # Creates a new file at $Path.
# Write-Host "File $Path was created"

# Param(
#   $Path
# )
# If (-Not $Path -eq '') {
#   New-Item $Path
#   Write-Host "File created at path $Path"
# }
# Else {
#   Write-Error "Path cannot be empty"
# }

# Param(
#   [Parameter(Mandatory, HelpMessage = "Please provide a valid path")]
#   [string]$Path
# )
# New-Item $Path
# Write-Host "File created at path $Path"

# Param(
#   [string]$Path = './app',
#   [string]$DestinationPath = './'
# )
# $date = Get-Date -format "yyyy-MM-dd"
# Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
# Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"

# $Value = 3
# If ($Value -le 0) {
#   Write-Host "Is negative"
# }
# Else {
#   Write-Host "Is Positive"
# }

# # _FullyTax.ps1_
# # Possible values: 'Minor', 'Adult', 'Senior Citizen'
# $Status = 'Minor'
# If ($Status -eq 'Minor') 
# {
#   Write-Host $False
# } ElseIf ($Status -eq 'Adult') {
#   Write-Host $True
# } Else {
#   Write-Host $False
# }

# Param(
#   [string]$Path = './app',
#   [string]$DestinationPath = './'
# )
# If (-Not (Test-Path $Path)) {
#   Throw "The source directory $Path does not exist, please specify an existing directory"
# }
# $date = Get-Date -format "yyyy-MM-dd"
# $DestinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"
# If (-Not (Test-Path $DestinationFile)) {
#   Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
#   Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"
# }
# Else {
#   Write-Error "Today's backup already exists"
# }

Param(
  [string]$Path = './app',
  [string]$DestinationPath = './',
  [switch]$PathIsWebApp
)
If ($PathIsWebApp -eq $True) {
  Try {
    $ContainsApplicationFiles = "$((Get-ChildItem $Path).Extension | Sort-Object -Unique)" -match '\.js|\.html|\.css'

    If ( -Not $ContainsApplicationFiles) {
      Throw "Not a web app"
    }
    Else {
      Write-Host "Source files look good, continuing"
    }
  }
  Catch {
    Throw "No backup created due to: $($_.Exception.Message)"
  }
}
If (-Not (Test-Path $Path)) {
  Throw "The source directory $Path does not exist, please specify an existing directory"
}
$date = Get-Date -format "yyyy-MM-dd"
$DestinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"
If (-Not (Test-Path $DestinationFile)) {
  Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
  Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"
}
Else {
  Write-Error "Today's backup already exists"
}
