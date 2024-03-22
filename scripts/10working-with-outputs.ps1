# console output
Get-Command | Out-Host -Paging
Get-Process | Format-List | Out-Host -Paging 
# order is importantq because The Out-Host cmdlet sends the data directly to the console, 
# so the Format-List command never receives anything to format if it is ordered last
# An Out cmdlet should always appear at the end of the pipeline.

# discarding output
Get-Command | Out-Null

# print output
Get-Command Get-Command | Out-Printer -Name 'Microsoft Office Document Image Writer' #name can be omitted and default printer will be used

# saving data
Get-Process | Out-File -FilePath C:\temp\processlist.txt -Width 2147483647

# list PowerShell has a set of cmdlets that allow you to control how properties are displayed for particular objects
Get-Command -Verb Format -Module Microsoft.PowerShell.Utility

# Using Format-Wide for single-item output
Get-Command -Verb Format | Format-Wide
Get-Command -Verb Format | Format-Wide -Property Noun
Get-Command -Verb Format | Format-Wide -Property Noun -Column 3

# Using Format-List for a list view
Get-Process -Name svchost | Format-List
Get-Process -Name svchost | Format-List -Property ProcessName, FileVersion, StartTime, Id
Get-Process -Name explorer | Format-List -Property *

# Using Format-Table for tabular 
Get-Service -Name win* | Format-Table
Get-Service -Name win* | Format-Table -AutoSize
Get-Service -Name win* | Format-Table -Property Name, Status, StartType, DisplayName, DependentServices -AutoSize
Get-Service -Name win* | Format-Table -Property Name, Status, StartType, DisplayName, DependentServices -Wrap
Get-Service -Name win* | Sort-Object StartType | Format-Table -GroupBy StartType