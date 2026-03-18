#!/bin/bash

# ==========================================================================
# Script Name: setup.sh
# Purpose: Prepare Ubuntu environment for Product API (Node.js + MongoDB + SSL)
# Author: [Tên nhóm của bạn]
# ==========================================================================

# 1. Cập nhật hệ thống
echo "--- 1. Updating system packages ---"
sudo apt-get update -y && sudo apt-get upgrade -y

# 2. Cài đặt các công cụ hỗ trợ
echo "--- 2. Installing essential tools (Git, Curl, Build-essential, Snapd) ---"
sudo apt-get install -y git curl build-essential snapd

# 3. Cài đặt Node.js 20 (LTS) và NPM
echo "--- 3. Installing Node.js 20 & NPM ---"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 4. Cài đặt MongoDB 7.0
echo "--- 4. Installing MongoDB Server ---"
sudo apt-get install -y gnupg
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
    sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# 5. Cài đặt Nginx và PM2
echo "--- 5. Installing Nginx and PM2 ---"
sudo apt-get install -y nginx
sudo npm install pm2@latest -g

# 6. Cài đặt Certbot (Cho SSL/HTTPS)
echo "--- 6. Installing Certbot via Snap ---"
sudo snap install core; sudo snap refresh core
sudo apt-get remove certbot -y # Gỡ bản cũ nếu có
sudo snap install --classic certbot
sudo ln -sf /snap/bin/certbot /usr/bin/certbot

# 7. Tạo cấu trúc thư mục ứng dụng
echo "--- 7. Creating application directory structures ---"
sudo mkdir -p /var/www/app/logs
sudo mkdir -p /var/www/app/public/uploads
sudo chown -R $USER:$USER /var/www/app

# 8. Kiểm tra và xuất phiên bản (Verification)
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