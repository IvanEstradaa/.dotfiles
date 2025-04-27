echo "
--------------------------------------------------------------------------------------
| To make librewolf customizations take effect, set the following in 'about:config': |
| toolkit.legacyUserProfileCustomizations.stylesheets = true                         |
--------------------------------------------------------------------------------------
"

PROFILE_PATH="$HOME/Library/Application Support/librewolf/Profiles/u0qnsa0l.default-default"

# Symlink
ln -s $PWD/chrome/ $PROFILE_PATH

# Set the default browser to LibreWolf 
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