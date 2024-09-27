#!/bin/bash

# Crear archivo logs para los cronjobs
touch ~/crontab_log.txt

# Añadir un nuevo cron job si no existe ya
(crontab -l 2>/dev/null; echo "0 0 1 */3 * rm -rf ~/Library/Application\\ Support/.ffuserdata; echo \"FCPX CronJob - \$(date +\"%D %T\")\" >> ~/crontab_log.txt") | crontab -
