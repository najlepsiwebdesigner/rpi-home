# RPi Home Services

Minimal setup for running **Pi-hole** and **Homebridge** on the same Raspberry Pi with zero configuration hassle. Docker setup makes it easy to upgrade and hard to break. Versions are not pinned - this is designed for minimal setup in closed LAN environments, not production use. Service auto-restarts weekly to pull latest Docker images.

## What it does

- **[Pi-hole](https://pi-hole.net/)**: Network-wide ad blocking DNS server
- **[Homebridge](https://homebridge.io/)**: HomeKit bridge for non-HomeKit devices
- **Systemd service**: Auto-starts on boot, manages containers, auto-restarts weekly for updates

## Quick Start

1. **Clone and install**:
   ```bash
   git clone <your-repo>
   cd rpi-home
   chmod +x install.sh
   ./install.sh
   ```

2. **Access services**:
   - Pi-hole: `http://your-pi-ip:80/admin` (no default password)
   - Homebridge: `http://your-pi-ip:8581`

## Requirements

- Raspberry Pi with Docker and Docker Compose
- Network access

## Management

```bash
# Start/stop service
sudo systemctl start rpi-home
sudo systemctl stop rpi-home

# View logs
sudo systemctl status rpi-home
docker compose logs
```

