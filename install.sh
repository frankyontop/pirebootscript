#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./install.sh)"
  exit
fi

echo "Installing systemd service and timer..."

# Copy files to systemd directory
cp reboot-pi.service /etc/systemd/system/
cp reboot-pi.timer /etc/systemd/system/

# Set correct permissions
chmod 644 /etc/systemd/system/reboot-pi.service
chmod 644 /etc/systemd/system/reboot-pi.timer

# Reload systemd to recognize new files
systemctl daemon-reload

# Enable and start the timer
systemctl enable --now reboot-pi.timer

echo "Success! The system is scheduled to reboot every 12 hours."
echo "You can check the schedule with: systemctl list-timers --all"
