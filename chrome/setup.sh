########################################
# Set the default browser to LibreWolf #
########################################
open -a "LibreWolf" --new --args -silent -nosplash -setDefaultBrowser
# Chromium-based browsers: open -a "Google Chrome" --new --args --make-default-browser

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
LIBREWOLF_PATH="$HOME/Library/Application Support/librewolf"

PROFILE="$(sed -n '2s/.*=//p' "$LIBREWOLF_PATH/installs.ini")" # we get the active profile, from the second line inside installs.ini

PROFILE_PATH="$LIBREWOLF_PATH/$PROFILE" # we set the literal path for the active librewolf profile 

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
EXTENSIONS=(
    "https://addons.mozilla.org/firefox/downloads/file/4442132/sidebery-5.3.3.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4488139/darkreader-4.9.106.xpi"
)

# Ensure the extensions directory exists
mkdir -p "$PROFILE_PATH/extensions" 

# Loop through the extension URLs and download them
for EXT_URL in "${EXTENSIONS[@]}"; do
    EXT_NAME=$(basename "$EXT_URL")
    
    # Download the extension using curl
    echo "Downloading extension: $EXT_NAME"
    curl -L "$EXT_URL" -o "$PROFILE_PATH/extensions/$EXT_NAME" # Save the extension inside the extensions dir
    
    echo "Installed extension: $EXT_NAME"
done

echo "Extensions installed successfully!"


