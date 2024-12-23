#!/bin/bash

NUMBER=$1
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"/Users/$USER/.dotfiles/wallpaper/Wallpaper${NUMBER}.jpg\""