#!/bin/bash

apt update -y
apt upgrade -y

hostnamectl set-hostname ${instance_name}.${instance_domain_name}
sudo sed -i "s/127\.0\.0\.1 localhost/127\.0\.0\.1 ${instance_name}.${instance_domain_name} ${instance_name}/g" /etc/hosts
systemctl restart systemd-hostnamed

echo "DONE<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

exit 0