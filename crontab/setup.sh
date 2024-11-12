#!/bin/bash

# Crear archivo log para los cronjobs
touch ~/crontab.log

# Añadir un nuevo cron job si no existe ya
(crontab -l 2>/dev/null; echo "0 0 1 */3 * rm -rf ~/Library/Application\\ Support/.ffuserdata; echo \"FCPX CronJob - \$(date +\"%D %T\")\" >> ~/crontab.log") | crontab -
