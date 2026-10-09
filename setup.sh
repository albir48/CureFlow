#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install required services on Ubuntu Server
sudo apt update
sudo apt install -y openssh-server apache2 php libapache2-mod-php ufw tmux openssl apache2-utils

# Enable and start services
sudo systemctl enable --now ssh
sudo systemctl enable --now apache2

# Enable Apache features
sudo a2enmod rewrite ssl headers

# Deploy the portal content to the Apache document roots
sudo mkdir -p /var/www/portal.local/public /var/www/admin.portal.local/public /var/www/portal_uploads
sudo rm -rf /var/www/portal.local/public/*
sudo rm -rf /var/www/admin.portal.local/public/*
sudo cp -r "$SCRIPT_DIR/public/." /var/www/portal.local/public/
sudo cp -r "$SCRIPT_DIR/admin/public/." /var/www/admin.portal.local/public/

# Copy Apache site definitions into place
sudo cp "$SCRIPT_DIR/portal.local.conf" /etc/apache2/sites-available/portal.local.conf
sudo cp "$SCRIPT_DIR/admin.portal.local.conf" /etc/apache2/sites-available/admin.portal.local.conf

# Create an upload directory outside the web root
sudo chown -R www-data:www-data /var/www/portal_uploads
sudo chmod 750 /var/www/portal_uploads

# Create an admin authentication file for the protected admin site
if [ ! -f /etc/apache2/.htpasswd ]; then
  sudo htpasswd -bc /etc/apache2/.htpasswd projectadmin 'ProjectAdmin2026'
fi

# Example self-signed certificate for local lab
CERT_DIR=/etc/ssl/local-certificates
sudo mkdir -p "$CERT_DIR"
if [ ! -f "$CERT_DIR/portal.local.key" ] || [ ! -f "$CERT_DIR/portal.local.crt" ]; then
  sudo openssl req -x509 -nodes -days 365 \
    -subj "/CN=portal.local/O=SecurePortal" \
    -newkey rsa:2048 \
    -keyout "$CERT_DIR/portal.local.key" \
    -out "$CERT_DIR/portal.local.crt"
fi

# Enable the sites and configure UFW
sudo a2ensite portal.local.conf admin.portal.local.conf >/dev/null || true
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

sudo apache2ctl configtest
sudo systemctl restart apache2

echo "Setup complete. Login to the admin area with user projectadmin and password ProjectAdmin2026."
echo "Verify with: sudo systemctl status ssh apache2 && sudo ufw status verbose"
