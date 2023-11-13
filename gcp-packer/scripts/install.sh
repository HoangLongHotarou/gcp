#!/bin/bash
echo "***** install nginx *****"

sudo apt-get update
sudo apt install -y nginx
sudo apt install -y stress-ng
sudo apt install -y unzip
sudo systemctl enable nginx
sudo systemctl restart nginx

echo "*****   Installation Completed!!   *****"