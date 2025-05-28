########################################
# Set the default browser to LibreWolf #
########################################
open -a "LibreWolf" --new --args -silent -nosplash -setDefaultBrowser
# Chromium-based browsers: open -a "Google Chrome" --new --args --make-default-browser

sleep 1 # wait for the popup to be shown

# Run the following osascript script to accept the default browser prompt:
# osascript <<EOF
# tell application "System Events"
#     tell application process "CoreServicesUIAgent"
#         tell window 1
#             tell (first button whose name starts with "Us")
#                 perform action "AXPress"
#             end tell
#         end tell
#     end tell
# end tell
# EOF

pkill -f "LibreWolf" # close librewolf instance


##############################################################
# Symlink chrome directory in the LibreWolf Profile directoy #
##############################################################
BROWSER_PATH="$HOME/Library/Application Support/librewolf"

PROFILE="$(sed -n '2s/.*=//p' "$BROWSER_PATH/installs.ini")" # we get the active profile, from the second line inside installs.ini

PROFILE_PATH="$BROWSER_PATH/$PROFILE" # we set the literal path for the active librewolf profile 

ln -s $PWD/chrome/ $PROFILE_PATH # we symlink the directory with the .css config inside the profile directory 


###################################################################  
# Set toolkit.legacyUserProfileCustomizations.stylesheets to true #
###################################################################
# Check if prefs.js exists
if [[ -f "$PROFILE_PATH/prefs.js" ]]; then
    # Check if the setting already exists in the prefs.js
    if grep -q 'toolkit.legacyUserProfileCustomizations.stylesheets' "$PROFILE_PATH/prefs.js"; then

        echo "Setting found in prefs.js. Checking its current value..."
        
        # Check if it's set to false
        if grep -q 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", false);' "$PROFILE_PATH/prefs.js"; then
            echo "Setting is currently false. Changing it to true..."
            sed -i 's/user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", false);/user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);/' "$PROFILE_PATH/prefs.js"
        else
            echo "Setting is already true or has a different value. No changes needed."
        fi
    else
        echo "Setting not found. Appending it to prefs.js..."
        echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$PROFILE_PATH/prefs.js"
    fi
    
    echo "Done!"
else
    echo "Error: prefs.js file not found at $PROFILE_PATH/prefs.js"
fi


######################
# Install extensions #
######################
# Method used: https://askubuntu.com/questions/73474/how-to-install-firefox-addon-from-command-line-in-scripts
EXTENSIONS=(
    "https://addons.mozilla.org/firefox/downloads/file/4442132/sidebery-5.3.3.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4488139/darkreader-4.9.106.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4492375/ublock_origin-1.64.0.xpi"
)

NAMES=(
    "{3c078156-979c-498b-8990-85f7987dd929}"
    "addon@darkreader.org"
    "uBlock0@raymondhill.net"
)

# Ensure the extensions directory exists
mkdir -p "$PROFILE_PATH/extensions" 

# Loop through the extension URLs and download them
for ((i=1; i<=${#EXTENSIONS[@]}; i++)); do

  EXT_URL="${EXTENSIONS[$i]}"
  EXT_NAME="${NAMES[$i]}.xpi"

  # Check if the extension already exists to avoid re-downloading
  if [[ -f "$PROFILE_PATH/extensions/$EXT_NAME" ]]; then
    echo "Extension $EXT_NAME already installed. Skipping."
    continue
  fi

  # Download the extension using curl
  echo "Downloading extension: $EXT_NAME"
  curl -L "$EXT_URL" -o "$PROFILE_PATH/extensions/$EXT_NAME" # Save the extension inside the extensions dir
  
  # Check if the curl command was successful
  if [[ $? -ne 0 ]]; then
    echo "Error downloading $EXT_NAME. Exiting script."
    exit 1
  fi

  echo "Installed extension: $EXT_NAME"
done

echo "Extensions installed successfully!"


#####################
# Enable extensions #
#####################
# Method used: https://superuser.com/questions/373276/how-to-enable-extension-when-running-firefox-for-the-first-time 

open -a "LibreWolf" 
sleep 5 # ensure the extensions.json file is updated with the new installed extensions
pkill -f "LibreWolf" # close librewolf instance

EXTENSIONS_JSON="$PROFILE_PATH/extensions.json"

cp $EXTENSIONS_JSON "$EXTENSIONS_JSON.bak"

# Update the extensions.json file to enable the extensions
echo "Enabling installed extensions..."

# Loop through the NAMES array and call jq for each extension ID
for ext_id in "${NAMES[@]}"; do
    # Run jq for each extension, enabling it by modifying active and userDisabled fields
    jq --arg ext_id "$ext_id" '
        .addons |= map(
            if .id == $ext_id then
                .active = true | .userDisabled = false
            else .
            end
        )
    ' "$EXTENSIONS_JSON" > "$EXTENSIONS_JSON.tmp" && mv "$EXTENSIONS_JSON.tmp" "$EXTENSIONS_JSON"
    
    # Check if jq succeeded
    if [[ $? -ne 0 ]]; then
        echo "Error updating $EXTENSIONS_JSON for extension $ext_id. Restoring from backup."
        mv "$EXTENSIONS_JSON.bak" "$EXTENSIONS_JSON"
        exit 1
    fi

    echo "Extension $ext_id enabled successfully."
done

echo "All extensions enabled successfully!"

