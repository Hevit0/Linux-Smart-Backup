#!/bin/bash
GREEN='\e[32m'
RED='\e[31m'
NC='\e[0m'

if [ $# -ne 2 ]; then
    echo -e "${RED}Usage: $0 <source_directory> <backup_directory>${NC}"
    echo "Error: Specify source and destination directories for backup."
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$2"

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error: Source directory '$SOURCE_DIR' does not exist.${NC}"
    exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${RED}Error: Backup directory '$BACKUP_DIR' does not exist.${NC}"
    echo -e "${RED}Creating backup directory...${NC}"
    mkdir -p "$BACKUP_DIR";
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
FULL_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo -e "${GREEN}Starting backup...${NC}"
tar -czf "$FULL_PATH" -C "$SOURCE_DIR" .


if [ $? -eq 0 ]; then

    FILESIZE=$(du -h "$FULL_PATH" | cut -f1)
    echo -e "${GREEN}[SUCCESS] Backup of '$SOURCE_DIR' completed successfully!${NC}"
    echo -e "${GREEN}Backup file created at: $BACKUP_DIR/$BACKUP_NAME${NC}"
    echo -e "${GREEN}Backup file size = $FILESIZE${NC}"

    rm -f "backup_errors.log"
else
    echo -e "${RED}[FAIL] Backup process encountered an error.${NC}"
    echo -e "${RED}Please check the source and destination directories and try again.${NC}"
    echo -e "${RED} $TIMESTAMP Backup process encountered an error.${NC}" >> backup_errors.log
    exit 1
fi
echo "Checking for old backups to delete..."
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;
echo -e "${GREEN}Cleanup complete, system secured.${NC}"
exit 0