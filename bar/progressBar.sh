#!/bin/bash

# Function to display a dynamically sized progress bar
display_dynamic_progress_bar() {
    local total_steps=$1
    local progress=0
    local terminal_width=$(tput cols)  # Get the width of the terminal
    (( bar_width=terminal_width-10 ))  # Deduct space for percentage display and brackets

    while (( progress <= total_steps )); do
        # Use ((...)) for arithmetic evaluation
        (( filled_slots = progress * bar_width / total_steps ))
        bar=""

        # Generate the filled portion of the bar
        for ((i=0; i<filled_slots; i++)); do
            bar="${bar}#"
        done

        # Generate the unfilled portion of the bar
        for ((i=filled_slots; i<bar_width; i++)); do
            bar="${bar}-"
        done

        # Calculate the percentage of completion
        (( percentage = progress * 100 / total_steps ))

        # Display the bar and percentage
        echo -ne "\r[${bar}] ${percentage}% "

        # Simulate some work
        sleep 0.1

        # Increment the progress
        (( progress++ ))
    done

    echo # Move to the next line after completion
}

# display_dynamic_progress_bar 20