#!/bin/bash

# ==========================================================================
# Script Name: setup.sh
# Purpose: Prepare Ubuntu environment for Product API (Node.js + MongoDB)
# Author: [Tên nhóm của bạn]
# ==========================================================================

# 1. Cập nhật hệ thống
echo "--- 1. Updating system packages ---"
sudo apt-get update -y && sudo apt-get upgrade -y

# 2. Cài đặt các công cụ hỗ trợ
echo "--- 2. Installing essential tools (Git, Curl, Build-essential) ---"
sudo apt-get install -y git curl build-essential

# 3. Cài đặt Node.js 20 (LTS) và NPM
# Theo README của thầy, cần ít nhất Node.js 16+
echo "--- 3. Installing Node.js 20 & NPM ---"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 4. Cài đặt MongoDB 7.0 (Bắt buộc cho điểm tối đa Phase 2)
echo "--- 4. Installing MongoDB Server ---"
sudo apt-get install -y gnupg
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# 5. Cài đặt Nginx (Reverse Proxy) và PM2 (Process Manager)
echo "--- 5. Installing Nginx and PM2 ---"
sudo apt-get install -y nginx
sudo npm install pm2@latest -g

# 6. Tạo cấu trúc thư mục (Dựa theo README của dự án)
# Ứng dụng yêu cầu thư mục public/uploads để lưu ảnh sản phẩm
echo "--- 6. Creating application directory structures ---"
sudo mkdir -p /var/www/app/logs
sudo mkdir -p /var/www/app/public/uploads

# Thiết lập quyền sở hữu để tránh lỗi Permission Denied khi upload file
sudo chown -R $USER:$USER /var/www/app

# 7. Kiểm tra và xuất phiên bản (Verification for Evidence)
echo "--- 7. Verification of Installed Components ---"
echo "Node version: $(node -v)"
echo "NPM version:  $(npm -v)"
echo "PM2 version:  $(pm2 -v)"
echo "Nginx version: $(nginx -v)"
echo "MongoDB:      $(mongod --version | head -n 1)"

echo "--- Setup Completed Successfully! ---"