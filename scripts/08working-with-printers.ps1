# listin print collection
Get-CimInstance -Class Win32_Printer
# or this
(New-Object -ComObject WScript.Network).EnumPrinterConnections()

# adding a network printer
# (New-Object -ComObject WScript.Network).AddWindowsPrinterConnection("\\Printserver01\Xerox5")

# setting a default printer
$printer = Get-CimInstance -Class Win32_Printer -Filter "Name='HP LaserJet 5Si'"
Invoke-CimMethod -InputObject $printer -MethodName SetDefaultPrinter
# or
(New-Object -ComObject WScript.Network).SetDefaultPrinter('HP LaserJet 5Si')

# removing printer connection
(New-Object -ComObject WScript.Network).RemovePrinterConnection("\\Printserver01\Xerox5")