#!/usr/bin/env bash
set -euo pipefail

# 1) Prihlásenie (ak už si prihlásený, nič sa nedeje)
sudo tailscale up

# 2) Zapni IP forwarding
sudo tee /etc/sysctl.d/99-tailscale.conf >/dev/null <<'EOF'
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
EOF
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

# 3) UDP GRO optimalizácia na aktívnom rozhraní
NETDEV=$(ip -o route get 8.8.8.8 | awk '{print $5; exit}')
sudo ethtool -K "$NETDEV" rx-udp-gro-forwarding on rx-gro-list off || true

# 4) Exit node + subnet routing
sudo tailscale up --advertise-exit-node --advertise-routes=192.168.1.0/24