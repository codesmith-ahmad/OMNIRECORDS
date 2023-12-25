<#
BACKUP:
    Copy "C:\OMNIRECORDS\omnirecords.db"
    to   "C:\OMNIRECORDS\tmp\omnirecords" + timestamp
    and  "C:\OMNIRECORDS\tmp\last-checkpoint"
RESTORE:
    Copy "C:\OMNIRECORDS\omnirecords.db"
    to   "C:\OMNIRECORDS\tmp\omnirecords" + timestamp
    Delete "C:\OMNIRECORDS\omnirecords.db"
    Copy   "C:\OMNIRECORDS\tmp\last-checkpoint" to "C:\OMNIRECORDS\"
    Rename it omnirecords.db
#>

function backup {
    $timestamp = Get-Date -Format "MMdd-HHmmss"
    $backupPath = "C:\OMNIRECORDS\tmp\omnirecords_$timestamp"
    $checkpointPath = "C:\OMNIRECORDS\tmp\last-checkpoint"

    # Copy omnirecords.db to backup path
    Copy-Item "C:\OMNIRECORDS\omnirecords.db" -Destination "$backupPath.db"
    Copy-Item "C:\OMNIRECORDS\omnirecords.db" -Destination "$checkpointPath"

    Write-Host "Backup complete"
}

function restore {
    $timestamp = Get-Date -Format "MMdd-HHmmss"
    $backupPath = "C:\OMNIRECORDS\tmp\omnirecords_$timestamp"
    $checkpointPath = "C:\OMNIRECORDS\tmp\last-checkpoint"

    # Copy omnirecords.db to backup path
    Copy-Item "C:\OMNIRECORDS\omnirecords.db" -Destination "$backupPath.db"

    # Delete omnirecords.db
    Remove-Item "C:\OMNIRECORDS\omnirecords.db" -Force

    # Copy the checkpoint file back to the original location
    Copy-Item -Path $checkpointPath -Destination "C:\OMNIRECORDS\omnirecords.db" -Force

    # # Rename the checkpoint file to omnirecords.db
    # Rename-Item -Path "C:\OMNIRECORDS\omnirecords.db" -NewName "omnirecords.db" -Force

    Write-Host "Restore complete"
}