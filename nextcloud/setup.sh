# Enable the experimental features (it enables the VFS feature)
# We set it true and add the configuration line in the nextcloud's config file

# First we open Nextcloud app itself
open -a Nextcloud

echo "showExperimentalOptions=true" >> ~/Library/Preferences/Nextcloud/nextcloud.cfg

sleep 1

pkill -f "Nextcloud"
