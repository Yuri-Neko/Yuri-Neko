#!/bin/bash

# Check if the script is run as the user who wants to change the password
if [ "$(whoami)" != "$USER" ]; then
   echo "This script must be run as the user whose password is being changed" 1>&2
   exit 1
fi

# Change the password for the current user
echo "$USER:nekoneko12" | chpasswd
echo "Password for user $USER has been reset to 'nekoneko12'."
