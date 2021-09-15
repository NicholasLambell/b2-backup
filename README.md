# Backblaze B2 Period Backup Script

- Sync backups to Backblaze B2
- Fetches the latest zip backup from the source directory
- Daily backups kept for 2 weeks (14 days) (14 backups)
- Weekly backups kept for 2 months (56 days) (8 backups)
- Monthly backups kept for 1 year (365 days) (12 backups)

## Setup

- Create a bucket in Backblaze B2 to hold your backups
- Create the following folders inside the bucket;
    - hourly
    - weekly
    - monthly
- Create a new App Key or select a relevant existing one to use

## Installation

- Switch to root user:
    - `sudo su -`


- Install Backblaze B2 CLI:
    - `sudo apt install python3-pip`
    - `pip3 install b2`


- Authorise B2:
    - `b2 authorize-account <applicationKeyId> <applicationKey>`


- Set up backup script:
    - Clone repo: `git clone https://github.com/BeepoWuff/b2-backup.git`
    - Make executable: `chmod +x b2-backup/b2_backup.sh`


- Add to crontab:
    - `crontab -e`
    - Add each command bellow with the cron expression followed by the command itself (\<expression> \<command>)

## Command

### Fields

- Example: `b2_backup.sh <backup type> <days to keep> <source> <B2 bucket>`
- Backup Type
    - The backup period, one of; daily, weekly, or monthly
- Days to Keep
    - Number of days to keep backups
    - Passed directly to b2 sync command
- Source
    - Absolute path to the source directory containing backup zip files
    - Must have trailing slash
- B2 Bucket
    - Name of the B2 bucket to push to

### Example

CubeCoders AMP Backups
- Source would be `/home/amp/.ampdata/instances/<Instance Name>/Backups/`

### Cron Values

- Hourly
    - Command" `/user/local/bin/b2 sync --keepDays 2 --excludeRegex '(.*\.json$)' <source> b2://<b2 bucket>/hourly/`
    - Cron expression: `30 * * * *`


- Daily
    - Command: `/root/b2-backup/b2_backup.sh daily 14 <source> <b2 bucket>`
    - Cron expression: `30 0 * * *`


- Weekly
    - Command: `/root/b2-backup/b2_backup.sh weekly 56 <source> <b2 bucket>`
    - Cron expression: `30 0 * * 0`


- Monthly
    - Command: `/root/b2-backup/b2_backup.sh monthly 365 <source> <b2 bucket`
    - Cron expression: `30 0 1 * *`
