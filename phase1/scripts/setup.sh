#!/bin/bash

# 1. Update system packages
echo "--- 1. Updating system packages ---"
sudo apt-get update -y && sudo apt-get upgrade -y

# 2. Install essential tools
echo "--- 2. Installing essential tools (Git, Curl, Build-essential, Snapd) ---"
sudo apt-get install -y git curl build-essential snapd

# 3. Install Node.js 20 (LTS) and NPM
echo "--- 3. Installing Node.js 20 & NPM ---"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 4. Install MongoDB 7.0
echo "--- 4. Installing MongoDB Server ---"
sudo apt-get install -y gnupg
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
    sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# 5. Install Nginx and PM2
echo "--- 5. Installing Nginx and PM2 ---"
sudo apt-get install -y nginx
sudo npm install pm2@latest -g

# 6. Install Certbot (For SSL/HTTPS)
echo "--- 6. Installing Certbot via Snap ---"
sudo snap install core; sudo snap refresh core
sudo apt-get remove certbot -y # Remove old version if any
sudo snap install --classic certbot
sudo ln -sf /snap/bin/certbot /usr/bin/certbot

# 7. Create application directory structures
echo "--- 7. Creating application directory structures ---"
sudo mkdir -p /var/www/app/logs
sudo mkdir -p /var/www/app/public/uploads
sudo chown -R $USER:$USER /var/www/app

# 8. Check and output versions (Verification)
echo "-----------------------------------------------"
echo "--- 8. Verification of Installed Components ---"
echo "Node version:    $(node -v)"
echo "NPM version:     $(npm -v)"
echo "PM2 version:     $(pm2 -v)"
echo "Nginx version:   $(nginx -v 2>&1)"
echo "MongoDB:         $(mongod --version | head -n 1)"
echo "Certbot version: $(certbot --version)"
echo "-----------------------------------------------"

echo "--- Setup Completed Successfully! ---"
echo "To enable SSL, run: sudo certbot --nginx -d yourdomain.com"
