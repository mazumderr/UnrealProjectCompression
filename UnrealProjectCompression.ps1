

if ($Env:UnrealPath -eq $null) { 
    # Setting an enviroment variable for
    # storing the path to your Unreal Projects
    $Env:UnrealPath = Read-Host -Prompt "Enter the path to your Unreal Projects"

     
    Write-Host "Setting path to $Env:UnrealPath"
      
} 

# Assigning arguments to variables
$arg0 = $args[0]
$LabPath = "$Env:UnrealPath\$arg0"
$CompressName = $args[1]
$DestinationPath = "$LabPath" + " Copy"
New-Item -Path $DestinationPath -ItemType Directory

# Make a backup of the lab files 
Write-Host "Making a backup of your files..."
Copy-Item -Path "$LabPath\*" -Destination "$DestinationPath" -Recurse

# Delete unneeded folders from backup
Write-Host "Compressing..."
Remove-Item "$DestinationPath\Content\StarterContent"
Remove-Item "$DestinationPath\Intermediate"
Remove-Item "$DestinationPath\Saved"
Remove-Item "$DestinationPath\Binaries"
Remove-Item "$DestinationPath\DerivedDataCache"
Remove-Item "$DestinationPath\.vs"
Remove-Item "$DestinationPath\.idea"



# Compress it all 
Compress-Archive -LiteralPath "$DestinationPath" -DestinationPath "$Env:UnrealPath\$CompressName.zip"

# Delete backup
Write-Host "Cleaning up files..."
Remove-Item "$DestinationPath" -Recurse

Write-Host "Done!"