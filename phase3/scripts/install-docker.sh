#!/bin/bash

# ==========================================================================
# Script Name: install-docker.sh
# Purpose: Install Docker Engine and Docker Compose for Phase 3
# Project: Cloud Migration & Containerization
# ==========================================================================

# Exit script if any error occurs
set -e

echo "--- 1. Updating system package index ---"
sudo apt-get update

echo "--- 2. Installing requisite prerequisite packages ---"
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "--- 3. Adding Docker's official GPG key ---"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "--- 4. Setting up Docker Repository ---"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "--- 5. Installing Docker Engine, CLI, and Docker Compose plugin ---"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. Configure Docker to start on boot
echo "--- 6. Configuring Docker auto-start ---"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# 7. Add current user to docker group to run commands without sudo (optional but recommended)
echo "--- 7. Configuring User access rights ---"
sudo usermod -aG docker $USER

# 8. Verification for reporting evidence
echo "--- 8. Verification ---"
echo "Docker version:         $(docker --version)"
echo "Docker Compose version: $(docker compose version)"

echo "--- Installation Complete! Please log out and log back in to apply docker group permissions ---"
