#!/bin/bash

exec >/var/log/user-data.log 2>&1
set -x

# Update the system
sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Git
sudo yum install -y git

# Clone your FastAPI project
cd /home/ec2-user
git clone https://github.com/ArJSarmiento/fastapi-workshop fastapi-app
cd fastapi-app

# Example fetching from Parameter Store
DB_HOST=$(
    aws ssm get-parameter --name "/${PROJECT_NAME}/${ENVIRONMENT}/database/url" \
        --with-decryption --query "Parameter.Value" --output text
)
DB_USER=$(
    aws ssm get-parameter --name "/${PROJECT_NAME}/${ENVIRONMENT}/database/user" \
        --with-decryption --query "Parameter.Value" --output text
)
DB_PASSWORD=$(
    aws ssm get-parameter --name "/${PROJECT_NAME}/${ENVIRONMENT}/database/password" \
        --with-decryption --query "Parameter.Value" --output text
)
DB_NAME=$(aws ssm get-parameter --name "/${PROJECT_NAME}/${ENVIRONMENT}/database/name" --with-decryption --query "Parameter.Value" --output text)

# Write to .env
cat <<EOF >/home/ec2-user/fastapi-app/.env
DATABASE_URL=postgresql+psycopg2://$DB_USER:$DB_PASSWORD@$DB_HOST:5432/$DB_NAME
EOF

# Authenticate Docker with ECR
aws ecr get-login-password --region ap-southeast-1 |
    docker login --username AWS --password-stdin ${ECR_REPOSITORY_URL}

# Start the application using Docker Compose
docker-compose -f docker-compose.prod.yml up -d

# Install CodeDeploy Agent
sudo yum install ruby wget -y
cd /home/ec2-user
wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
