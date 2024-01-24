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
    $timestamp = Get-Date -Format "MMMdd-HHmmss"
    # $backupPath = "C:\OMNIRECORDS\tmp\omnirecords_$timestamp"
    # $checkpointPath = "C:\OMNIRECORDS\tmp\last-checkpoint"
    $BackupPath = $config.db_backup.backupPath + $timestamp
    $checkpointPath = $config.db_backup.checkpointPath
    "checkpoint is ", $checkpointPath

    # Copy omnirecords.db to backup path
    Copy-Item $config.database -Destination "$backupPath.db"
    Copy-Item $config.database -Destination "$checkpointPath"

    Write-Host "Backup complete"
}

function restore {
    $timestamp = Get-Date -Format "MMdd-HHmmss"
    $backupPath = "C:\OMNIRECORDS\tmp\omnirecords_$timestamp"
    $checkpointPath = "C:\OMNIRECORDS\tmp\last-checkpoint"

    # Copy omnirecords.db to backup path
    Copy-Item $config.database -Destination "$backupPath.db"

    # Delete omnirecords.db
    Remove-Item $config.database -Force

    # Copy the checkpoint file back to the original location
    Copy-Item -Path $checkpointPath -Destination $config.database -Force

    # # Rename the checkpoint file to omnirecords.db
    # Rename-Item -Path "C:\OMNIRECORDS\omnirecords.db" -NewName "omnirecords.db" -Force

    Write-Host "Restore complete"
}