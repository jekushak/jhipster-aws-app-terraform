#!/bin/bash
sudo yum -y update
sudo yum install -y ruby
cd /home/ec2-user
curl -O https://aws-codedeploy-eu-north-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
