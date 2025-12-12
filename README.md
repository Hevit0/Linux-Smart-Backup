# 💾 Linux Smart Backup

A robust Bash script designed for automated backup operations. It handles compression, validates paths, manages error codes, and automatically rotates old backups to save disk space.

## Features
* **Smart Compression:** Uses `tar` with gzip to minimize storage usage.
* **Intelligent Naming:** Includes the source folder name in the backup file (e.g., `backup_Documents_2025...`).
* **Error Handling:** Distinguishes between success (0), warnings (1 - file changed during read), and fatal errors (2).
* **Auto-Rotation:** Automatically deletes backup files older than 7 days to prevent disk overflow.

## Usage

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/Hevit0/Linux-Smart-Backup.git](https://github.com/Hevit0/Linux-Smart-Backup.git)
   
2. **Make it executable:**
   ```bash
   chmod +x smart_backup.sh
   
3. **Run a backup:**
   ```bash
   ./smart_backup.sh /home/user/documents /home/user/backups

(Optional)->Automate with Cron :
1.Open crontab: ```text crontab -e ```

2.Add line: ```text 0 3 * * * /path/to/smart_backup.sh /source /destination >> /var/log/backup.log 2>&1 ```

Requirements:
-Linux/Unix/macOS

-tar utility

Develiped by a CS Student
