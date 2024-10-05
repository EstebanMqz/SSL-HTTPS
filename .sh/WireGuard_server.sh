#!/bin/bash
# Description: Install WireGuard server on Ubuntu

#Set the setuid bit on the passwd command to allow non root users to change pwd.
sudo chmod u+s /usr/bin/passwd

# Check if the WireGuard PPA is already added to the sources.list 
if [ ! -f /etc/apt/sources.list.d/wireguard-ubuntu-wireguard-bionic.list ]; then
    # Add the WireGuard PPA repository & its tools.
    sudo add-apt-repository ppa:wireguard/wireguard
    sudo apt-get install wireguard wireguard-tools
    sudo apt-get update # Upgrade package list
fi
    
#Set WireGuard server with subdir. created for the keys if it doesn't exist.
Keys_dir="/etc/wireguard/keys"
if [ ! -d "$Keys_dir" ]; then
    sudo mkdir -p "$Keys_dir"
fi

#Create public and private keys for the server and client
wg genkey | tee "$Keys_dir/server_private.key" | wg pubkey > "$Keys_dir/server_public.key"
wg genkey | tee "$Keys_dir/client_private.key" | wg pubkey > "$Keys_dir/client_public.key"

generateResolvConf=true
# 10.255.255.254 Example internal DNS server, 195.46.39.39 SafeDNS, 208.67.222.222 OpenDNS
nameserver="10.255.255.254 195.46.39.39 208.67.222.222"

#IP address, private key, listening port, and any post-up or post-down commands
echo "[Interface]
Address = 10.0.0.1/24
PrivateKey = $(cat $Keys_dir/server_private.key)
ListenPort = 51820
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE 
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ens3 -j MASQUERADE" > /etc/wireguard/wg0.conf

echo "[Peer]
PublicKey = $(cat $Keys_dir/server_public.key)
Endpoint = your_server_ip:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 21" > /etc/wireguard/client.conf

#Wireguard client conf generator
generateResolvConf=true
#FreeDNS, DNSWatch, SafeDNS
nameserver="37.235.1.174 84.200.69.80 195.46.39.39"

#[Interface]: Contains the client's private key, IP address, and DNS server.
echo "[Interface]
PrivateKey = $(cat $Keys_dir/client_private.key)
Address = 10.0.0.2/24
DNS = 192.168.100.1"


#[Peer]: Contains the server's public key, endpoint, allowed IPs, and persistent keepalive setting.
"[Peer]
PublicKey = $(cat $Keys_dir/server_public.key)
Endpoint = 192.168.100.1:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 18" > /etc/wireguard/client.conf

# ----------------------------------------------------------------------------
# generateResolvConf=false
# nameserver="10.255.255.254 1.1.1.1 8.8.8.8"
# # Create the Wireguard server configuration file
# echo "[Interface]
# Address = 10.0.0.1/24
# PrivateKey = $(cat $Keys_dir/server_private.key)
# ListenPort = 51820
# PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE 
# PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ens3 -j MASQUERADE" > /etc/wireguard/wg0.conf

# # Create the Wireguard client
# generateResolvConf=true
# nameserver="37.235.1.174"
# # Use geomview to have the private key copied
# # This script installs the geomview pkg & updates pkg list
# sudo apt-get install geomview && sudo apt-get update && sudo apt-get upgrade
# geomview -clipboard < $Keys_dir/client_private.key | clip
# echo "[Interface]
# PrivateKey = $(cat $Keys_dir/client_private.key)
# DNS = 192.168.100.1
# [Peer]
# PublicKey = $(cat $Keys_dir/server_public.key)
# Endpoint = your_server_ip:51820
# AllowedIPs = 0.0.0.0/0
# PersistentKeepalive = 21" > /etc/wireguard/client.conf
# ----------------------------------------------------------------------------



# #Enable the WireGuard service
# sudo systemctl enable wg-quick@wg0 && sudo systemctl start wg-quick@wg0


# # Set up the certificate authority for WireGuard
# make-cadir ~ ~/WireGuard_CA 
# # Create the server certificate, key, and encryption files
# ./build-key-server server && ./build-dh && openvpn --genkey --secret keys/ta.key

# # Generate a client certificate and key
# cd ~/openvpn-ca && source vars && ./build-key client1

# # Configure the WrireGuard service
# cd ~/openvpn-ca/keys && sudo cp ca.crt server.crt server.key ta.key dh2048.pem /etc/openvpn

# # Open server config. file 
# sudo nano /etc/openvpn/server.conf

# # Enable and start the OpenVPN service
# sudo systemctl start openvpn@server && sudo systemctl enable openvpn@server

# # Adjust the server firewall
# sudo ufw allow 51820/udp && sudo ufw allow OpenSSH && sudo ufw enable

# # Open client configuration file for editing
# nano ~/client.ovpn