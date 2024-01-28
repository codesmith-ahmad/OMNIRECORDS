# function archive ($path) {
#     if (-not $path){Write-Host "`e[31mSPECIFY FILEPATH TO ARCHIVE`e[0m"}
#     else {
#         $nameOfFile = Read-Host "Name of file"
#         Write-Host "path is" $path
#         Write-Host "name of file is" $nameOfFile

#         $newDirectory = "C:\OMNIRECORDS\OmniRecords-Database\OmniRecords-Library\Archives\" + $nameOfFile
#         New-Item  -ItemType Directory -Path $newDirectory
#         Copy-Item -Path $path  -Destination $newDirectory
        
#         $query = "INSERT INTO Archives (Name) VALUES ('" + $nameOfFile + "')"
#         sql $query
#         sql 'SELECT * FROM Archives' | Format-Table

#         Write-Host "File saved at:"
#         $output = "" + $config.database + "\..\OmniRecords-Library\Archives\$nameOfFile"
#         Write-Host $output
#     }
# }