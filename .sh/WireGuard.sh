#!/bin/bash

sudo chmod u+s /usr/bin/passwd

# Check if OpenVPN and easy-rsa are installed, if not, install them
dpkg -s openvpn easy-rsa >/dev/null 2>&1 || {
    sudo apt-get update
    sudo apt-get install openvpn easy-rsa
}

# Set up the certificate authority
make-cadir ~/openvpn-ca && cd ~/openvpn-ca && source vars && ./clean-all && ./build-ca

# Create the server certificate, key, and encryption files
./build-key-server server && ./build-dh && openvpn --genkey --secret keys/ta.key

# Generate a client certificate and key
cd ~/openvpn-ca && source vars && ./build-key client1

# Configure the OpenVPN service
cd ~/openvpn-ca/keys && sudo cp ca.crt server.crt server.key ta.key dh2048.pem /etc/openvpn

# Open server configuration file for editing
sudo nano /etc/openvpn/server.conf

# Enable and start the OpenVPN service
sudo systemctl start openvpn@server && sudo systemctl enable openvpn@server

# Adjust the server firewall
sudo ufw allow 51820/udp && sudo ufw allow OpenSSH && sudo ufw enable

# Open client configuration file for editing
nano ~/client.ovpn