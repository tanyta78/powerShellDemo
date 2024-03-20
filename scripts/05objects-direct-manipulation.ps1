# The elements that you see in PowerShell drives, such as the files and folders or registry keys, are called Items 

# all commands working with items
Get-Command -Noun Item

# creating new directory
New-Item -Path c:\temp\New.Directory -ItemType Directory
# creating new file
New-Item -Path C:\temp\New.Directory\file1.txt -ItemType file

# renaming existing items - can only rename the file ; moving is not allowed with this command
Rename-Item -Path C:\temp\New.Directory\file1.txt fileOne.txt

# Rename-Item -Path C:\temp\New.Directory\fileOne.txt c:\temp\fileOne.txt - this one fails because it attempts to move the file

# moving items - passthru is used to display a result
Move-Item -Path C:\temp\New.Directory -Destination C:\ -PassThru

# copy items 
# The Copy-Item cmdlet was designed to be generic; it isn't just for copying files and folders. Also, even when copying files and folders, you might want to copy only the container and not the items within it. The Copy-Item cmdlet was designed to be generic; it isn't just for copying files and folders. Also, even when copying files and folders, you might want to copy only the container and not the items within it.

Copy-Item -Path C:\New.Directory -Destination C:\temp -Recurse -Force -Passthru

# deleting items - often prompt for confirmation ; for example, if you try to remove the New.Directory folder, you will be prompted to confirm the command, because the folder contains files:
Remove-Item C:\temp\New.Directory
# to remove without confirming use -Recursive
Remove-Item C:\temp\New.Directory -Recurse