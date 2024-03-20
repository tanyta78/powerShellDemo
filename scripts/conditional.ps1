# 1 -eq 2 #equals
# 1 -ne 2 #not equals
# 1 -lt 2 #less than
# 2 -le 2 #less or equals
# 2 -gt 1 # greater than
# 2 -ge 1 # greater or equal

# @(1, 2, 3) -contains 4
# @('Test', 'test') -contains 'TEST'
# @('Test', 'test') -ccontains 'TEST' #case sensitive

$filePath = "C:\Users\tatyana.milanova\scripts\test.txt"
# Test-Path -Path $filePath

if (Test-Path -Path $filePath) {
  $Data = Get-Content -Path $filePath
  if ($Data.Count -lt 2) {
    Write-Output "This file has less than 2 lines"
  }
  elseif ($Data.Count -lt 4) {
    Write-Output "This file has less than 4 lines but at least 2"
  }
  else {
    Write-Output "This file has 4 or more lines"
  }
  
}
else {
  # Write-Output "File '$filePath' does not exists!"
  Write-Output "File `"$filePath`" does not exists!" # backtick is escape symbol
}