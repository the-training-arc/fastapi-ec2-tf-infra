#!/bin/bash

# Update the system
sudo yum update -y

# Install Nginx
sudo yum install nginx -y

# Create a health check endpoint
sudo mkdir -p /usr/share/nginx/html
echo "OK" | sudo tee /usr/share/nginx/html/health
sudo chmod 644 /usr/share/nginx/html/health

# Set proper permissions
sudo chown -R nginx:nginx /usr/share/nginx/html

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

sudo systemctl status amazon-ssm-agent
