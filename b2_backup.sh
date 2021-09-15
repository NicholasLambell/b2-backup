#!/bin/bash

# Params
# $1: Backup type (daily, weekly, monthly)
# $2: Days to keep backups for
# $3: Source directory (containing backup zip files)
# $4: B2 bucket (b2://<bucketName>/$1)

BACKUP_DIR="/root/backup-tmp/$1/"

# Create backup directory path if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy latest backup to temp directory
echo "Copying latest backup to temp directory"
cp -p "$(ls -dtr1 "$3"*.zip | tail -1)" "$BACKUP_DIR"
echo ""

# Sync to B2
echo "Syncing to B2"
/usr/local/bin/b2 sync --keepDays "$2" --excludeRegex '(.*\.json$)' "$BACKUP_DIR" "b2://$4/$1"
echo ""

# Remove backup directory content to clear it for next time
rm "$BACKUP_DIR"/*
echo "Deleted backup file from temp directory"
