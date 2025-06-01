#!/bin/bash

# Usage: ./tmux-window.sh <window_name> <command>

# Grab arguments
window_name="$1"
shift
command="$@"

# Get current tmux session
session=$(tmux display-message -p '#S')

# Check if the window exists
if tmux list-windows -t "$session" | grep -q "^.*: $window_name"; then
  # Switch to existing window
  tmux select-window -t "$session:$window_name"
else
  # Create new window and run the command
  tmux new-window -n "$window_name" "$command"
fi

