#!/bin/bash


############################################################################
# SQL-backup								   #
# Mocht je vragen hebben over dit script, mail dan naar vincent@mhasmo.nl. #
#									   #
# Het is niet al te spannend:						   #
# Er wordt elke dag een SQL-dump gemaakt door middel van dit backup-script #
# De retentie wordt opgebouwd door de dagelijkse Rsnapshot-sync		   #
############################################################################

# Eerst de backup alle voorgaande back-ups verwijderen:
# find /var/backups/sqlbackups/* -maxdepth 1 -type d -exec rm -rf {} \;

# Een folder aanmaken waarin de backups met datum-notatie worden opgeslagen:
mkdir /var/backups/sqlbackups/sqldump-$(date +%d%m%Y)

# Het verkrijgen van een lijst van database en vervolgens deze te dumpen en gelijk in te pakken met gzip
for db in $(mysql -e 'show databases' -s --skip-column-names); do mysqldump $db | gzip > "/var/backups/sqlbackups/sqldump-$(date +%d%m%Y)/mysqldump-$db-$(date +%Y-%m-%d-%H.%M.%S).sql.gz"
done
