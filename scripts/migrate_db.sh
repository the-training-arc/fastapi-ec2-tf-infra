#!/bin/bash

set -e

USER=ec2-user

BASTION_HOST_IP=$(
    aws ec2 describe-instances \
        --region ap-southeast-1 \
        --filters "Name=tag:Role,Values=bastion" "Name=instance-state-name,Values=running" \
        --query "Reservations[0].Instances[0].PublicIpAddress" \
        --output text
)

PRIVATE_IP=$(
    aws ec2 describe-instances \
        --region ap-southeast-1 \
        --filters "Name=tag:Role,Values=application" "Name=instance-state-name,Values=running" \
        --query "sort_by(Reservations[*].Instances[*][], &LaunchTime)[-1].PrivateIpAddress" \
        --output text
)

KEY_PATH=~/.ssh/private_key.pem

echo "Migrating database on $PRIVATE_IP via $BASTION_HOST_IP"

ssh -i $KEY_PATH -o StrictHostKeyChecking=no -o ProxyCommand="ssh -i $KEY_PATH -o StrictHostKeyChecking=no -W %h:%p $USER@$BASTION_HOST_IP" $USER@$PRIVATE_IP \
  "cd fastapi-app && docker-compose --env-file .env -f docker-compose.prod.yml exec fastapi alembic upgrade head && echo Done Migration"

echo "Done Migration"
