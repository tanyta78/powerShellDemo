$filePath = "C:\Users\tatyana.milanova\scripts\test.txt"

$Data = Get-Content -Path $filePath
# $fruit = $Data[0]
# $fruit = Read-Host "Enter a fruit name"

# switch ($fruit) {
#   "Apple" {
#     Write-Host "The fruit is Apple"
#   }
#   "Banana" {
#     Write-Host "The fruit is Banana"
#   }
#   "Orange" {
#     Write-Host "The fruit is Orange"
#   }
#   "Grape" {
#     Write-Host "The fruit is Grape"
#   }
#   "Strawberry" {
#     Write-Host "The fruit is Strawberry"
#   }
#   "Pineapple" {
#     Write-Host "The fruit is Pineapple"
#   }
#   "Mango" {
#     Write-Host "The fruit is Mango"
#   }
#   "Kiwi" {
#     Write-Host "The fruit is Kiwi"
#   }
#   "Watermelon" {
#     Write-Host "The fruit is Watermelon"
#   }
#   "Blueberry" {
#     Write-Host "The fruit is Blueberry"
#   }
#   Default {
#     Write-Host "Fruit not recognized"
#   }
# }

switch ($Data.Count) {
  { $_ -lt 2 } { 
    Write-Output "This file has less than 2 lines"
  }
  { $_ -eq 10 } { 
    Write-Output "This file has 10 lines"
  }
  # { $_ -lt 15 } { - needs to use break so only one statement will excecute
  { $_ -in (11..14) } { 
    Write-Output "This file has less than 15 lines, at least 11 lines"
  }
  Default {
    Write-Output "This file has 15 or more lines"
  }
}