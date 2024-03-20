########## CREATING .NET OBJECTS ##################
# creating a new instance of .net framework class named System.Diagnostics.EventLog
New-Object -TypeName System.Diagnostics.EventLog
# using constructors
New-Object -TypeName System.Diagnostics.EventLog -ArgumentList Application
# storing in variable
$AppLog = New-Object -TypeName System.Diagnostics.EventLog -ArgumentList Application
$AppLog
# # Accessing a remote event log with New-Object
# $RemoteAppLog = New-Object -TypeName System.Diagnostics.EventLog Application, 192.168.1.81
# $RemoteAppLog
# # Clearing an event log with object methods
# $RemoteAppLog | Get-Member -MemberType Method
# $RemoteAppLog.Clear()
# $RemoteAppLog

# for COM objects read on the powershell docs