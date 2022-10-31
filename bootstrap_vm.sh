#!/bin/bash

# Install podman & podman-compose
sudo dnf -y -q update
sudo dnf -y -q install podman podman-compose buildah containers-storage containernetworking-plugins dnsmasq

# Start podman service
sudo systemctl start podman
sudo systemctl enable podman

# Open firewall ports
sudo firewall-cmd --zone=public --add-port=9000/tcp --permanent
sudo firewall-cmd --zone=public --add-port=9001/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23800/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23801/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23802/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23790/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23791/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23792/tcp --permanent
sudo firewall-cmd --reload
