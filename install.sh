#!/bin/bash
set -e

# Quick install for Raspberry Pi Home Services
echo "Installing Raspberry Pi Home Services..."

# Check dependencies
echo "Checking dependencies..."

if ! command -v docker &> /dev/null; then
    echo "Missing: docker"
fi

if ! docker compose version &> /dev/null; then
    echo "Missing: docker compose"
fi


# Setup environment (only if .env doesn't exist)
if [[ ! -f .env ]]; then
    cp env.example .env
fi

# Create directories
mkdir -p data/{pihole/{etc-pihole,etc-dnsmasq.d},homebridge}

# Get script directory and update service file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sed -i "s|WorkingDirectory=.*|WorkingDirectory=$SCRIPT_DIR|" rpi-home.service

# Install service
sudo cp rpi-home.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable rpi-home.service
sudo systemctl start rpi-home.service

echo "Installation complete!"
