#!/usr/bin/bash

# Install CodeDeploy agent on Amazon Linux with IMDSv2 Required

yum update
yum -y install ruby
yum install wget
cd /home/ec2-user
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
AWS_REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone/ | sed 's/[a-z]$//')
wget https://aws-codedeploy-${AWS_REGION}.s3.${AWS_REGION}.amazonaws.com/latest/install
chmod +x ./install
./install auto
# Start CodeDeploy agent
sudo service codedeploy-agent status
sudo service codedeploy-agent start
