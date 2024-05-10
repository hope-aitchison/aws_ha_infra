#!/bin/bash

echo "Installing python3 and AWS SSM agent"
sudo dnf install python3
    
# Install Amazon SSM agent
cd /tmp
sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
    
# Start and enable the Amazon SSM agent service
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Check if Amazon SSM agent is running
if sudo systemctl is-active --quiet amazon-ssm-agent; then
    echo "Amazon SSM agent is running!"
else
    echo "Amazon SSM agent is not running...."
fi