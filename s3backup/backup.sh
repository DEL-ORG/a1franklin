#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# AWS Credentials
AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"

# PostgreSQL Credentials
PGHOST="$PG_HOST"
PGPORT="$PG_PORT"
PGUSER="$PG_USER"
PGPASSWORD="$PG_PASSWORD"
PGDATABASE="$PG_NAME"

# S3 Bucket
BUCKET_NAME="$BUCKET_NAME"
BACKUP_DIR="/a1franklin-backup"

# Timestamp for backup file
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Backup PostgreSQL database to a file
BACKUP_FILE="$BACKUP_DIR/${PGDATABASE}_${TIMESTAMP}.sql"
PGPASSWORD="$PGPASSWORD" pg_dump -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" > "$BACKUP_FILE"

# Authenticate AWS CLI
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set default.region "$AWS_DEFAULT_REGION"

# Upload backup file to S3
aws s3 cp "$BACKUP_FILE" "s3://$BUCKET_NAME/"

# Clean up temporary backup file
rm "$BACKUP_FILE"

# Check the exit status and print a message indicating success or failure
if [ $? -eq 0 ]; then
    echo "Script completed successfully"
else
    echo "Script failed"
fi


