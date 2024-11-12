# Enable the experimental features (it enables the VFS feature)
# We set it true and add the configuration line in the nextcloud's config file
sed -i '' '17i\
showExperimentalOptions=true\
' ~/Library/Preferences/Nextcloud/nextcloud.cfg
