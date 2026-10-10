#!/bin/sh
# WeatherStar 3000+ installer for Raspberry Pi OS (works on a Pi Zero/1/2/3).
# Serves pre-built static files with Python's built-in web server (no Node, no build).
# Run from the repo: sudo sh pi/install.sh   (then reboot)
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
USER_NAME="${SUDO_USER:-pi}"
HOME_DIR="$(getent passwd "$USER_NAME" | cut -d: -f6)"

cat > /etc/systemd/system/ws3kp.service <<EOF
[Unit]
Description=WeatherStar 3000+ static server
After=network.target

[Service]
User=$USER_NAME
WorkingDirectory=$DIR/www
ExecStart=/usr/bin/python3 -m http.server 8083 --bind 127.0.0.1
Restart=always
Nice=10

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now ws3kp.service

# Kiosk autostart (labwc/Wayfire/LXDE desktop sessions)
mkdir -p "$HOME_DIR/.config/autostart"
cat > "$HOME_DIR/.config/autostart/ws3kp.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=WeatherStar
Exec=sh $DIR/kiosk.sh
EOF
chown -R "$USER_NAME": "$HOME_DIR/.config/autostart"
echo "Installed. Reboot, or run: sh $DIR/kiosk.sh"
