#!/bin/bash

# Update the system
sudo yum update -y

# Install Apache
sudo yum install httpd -y

# Create a health check endpoint
sudo mkdir -p /var/www/html
echo "OK" | sudo tee /var/www/html/health
sudo chmod 644 /var/www/html/health

# Set proper permissions
sudo chown -R apache:apache /var/www/html

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

sudo systemctl status amazon-ssm-agent
