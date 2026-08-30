#!/bin/bash
set -e
# install.sh - install Docker, docker-compose and start wg-easy
# Tested on Ubuntu/Debian
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root: sudo ./install.sh"
  exit 1
fi
apt update && apt upgrade -y
apt install -y ca-certificates curl gnupg lsb-release
# Install Docker
if ! command -v docker >/dev/null 2>&1; then
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt update
  apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi
# Create directory and default docker-compose if not exists
if [ ! -f docker-compose.yml ]; then
  echo "docker-compose.yml not found in $(pwd). Please place the provided docker-compose.yml in this folder." && exit 1
fi
# Start compose
docker compose up -d
echo "wg-easy should be running. Visit http://<SERVER_IP>:51821 and login with ADMIN password specified in README."