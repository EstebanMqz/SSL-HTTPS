#!/bin/bash
# Description: Generate private key for CA, server client and their self-signed certificate.

#Variables
KEY_DIR=".key"
CRT_DIR=".crt"
CSR_DIR=".csr" 
DAYS="1024"
ALGORITHM="RSA"
BITS="4096"

# Set the dirs for cert & keys.
mkdir -p $KEY_DIR $CRT_DIR $CSR_DIR

# Function to generate a key
generate_key() {
    local name=$1
    # Use OpenSSL to generate the key.
    openssl genpkey -algorithm $ALGORITHM -out $KEY_DIR/$name.key -pkeyopt rsa_keygen_bits:$BITS
}

Create_CRT() {
    #Use OpenSSL to create the .crt certificate with its private key
    local name=$1
    openssl req -x509 -new -nodes -key $KEY_DIR/$name.key -sha256 -days $DAYS -out $CRT_DIR/$name.crt
}

# Function to generate a CSR
generate_csr() {
    local name=$1
    openssl req -new -key $KEY_DIR/$name.key -out $CSR_DIR/$name.csr
}

# Function to sign a CSR
sign_csr() {
    #Use OpenSSL to create the .crt certificate with its private key.
    local name=$1
    openssl x509 -req -in $CSR_DIR/$name.csr -CA $CRT_DIR/CA.crt -CAkey $KEY_DIR/CA.key -CAcreateserial -out $CRT_DIR/$name.crt -days $DAYS -sha256
}

# Generate keys for the CA, server, and client
generate_key "CA"
generate_key "server"
generate_key "client"

# Create certificates for the CA, server, and client
create_certificate "CA"
create_certificate "server"
create_certificate "client"

# Generate CSRs for the client and server
generate_csr "client"
generate_csr "server"

# Sign the CSRs for the client and server
sign_csr "client"
sign_csr "server"

# Author: Eng. Esteban Márquez Delgado
# Repository: https://github.com/EstebanMqz/
