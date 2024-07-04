#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Prompt for the username whose password you want to reset
read -p "Enter the username whose password you want to reset: " USERNAME

# Check if the user exists
if id "$USERNAME" &>/dev/null; then
    # Reset the password
    echo "$USERNAME:nekoneko12" | chpasswd
    echo "Password for user $USERNAME has been reset to 'nekoneko12'."
else
    echo "User $USERNAME does not exist."
fi
