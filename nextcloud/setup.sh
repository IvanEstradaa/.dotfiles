# Enable the experimental features (it enables the VFS feature): https://docs.nextcloud.com/desktop/3.3/architecture.html?highlight=virtual%20files#virtual-files
# We set it true and add the configuration line in the nextcloud's config file

# First we open Nextcloud app itself
open -a Nextcloud

sleep 1

# We write the configuration line in the nextcloud's config file: https://docs.nextcloud.com/desktop/3.2/advancedusage.html
sed -i '' '2i\
showExperimentalOptions=true
' ~/Library/Preferences/Nextcloud/nextcloud.cfg

pkill -f "Nextcloud"

echo "Experimental features for Nextcloud enabled"
