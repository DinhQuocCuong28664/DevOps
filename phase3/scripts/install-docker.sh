#!/bin/bash

# ==========================================================================
# Script Name: install-docker.sh
# Purpose: Install Docker Engine and Docker Compose for Phase 3
# Project: Cloud Migration & Containerization
# ==========================================================================

# Thoát script nếu có lỗi xảy ra
set -e

echo "--- 1. Cập nhật chỉ mục gói hệ thống ---"
sudo apt-get update

echo "--- 2. Cài đặt các gói phụ trợ cần thiết ---"
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "--- 3. Thêm khóa GPG chính thức của Docker ---"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "--- 4. Thiết lập Docker Repository ---"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "--- 5. Cài đặt Docker Engine, CLI và Docker Compose ---"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. Cấu hình Docker tự động khởi động cùng hệ thống 
echo "--- 6. Cấu hình Docker tự động khởi động ---"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# 7. Thêm user hiện tại vào nhóm docker để chạy lệnh không cần sudo (tùy chọn nhưng khuyến nghị)
echo "--- 7. Cấu hình quyền truy cập User ---"
sudo usermod -aG docker $USER

# 8. Kiểm tra và xuất phiên bản (Dùng làm minh chứng báo cáo)
echo "--- 8. Kiểm tra phiên bản (Verification) ---"
echo "Docker version:         $(docker --version)"
echo "Docker Compose version: $(docker compose version)"

echo "--- Cài đặt hoàn tất! Vui lòng đăng xuất và đăng nhập lại để áp dụng quyền nhóm docker ---"
