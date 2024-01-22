# Description: Generate private key for CA, server and client and their self signed certificate.
 
# Generate a CA, server and client private key using the RSA algorithm: 4096 bits (for ht)
openssl genpkey -algorithm RSA -out .key/CA.key -pkeyopt rsa_keygen_bits:4096
# Choose a CA to apply for the SSL certificate and encrypt a domain name with HTTPS.



# Generate a new private key using RSA algorithm with 4096 bits and save it to 'private.key'
openssl genpkey -algorithm RSA -out .key/server.key  -pkeyopt rsa_keygen_bits:4096
# Generate a new private key using RSA algorithm with 4096 bits and save it to 'private.key'
openssl genpkey -algorithm RSA -out .key/client.key  -pkeyopt rsa_keygen_bits:4096
# Create a new self-signed X.509 certificate for the CA, server and client using its key.
openssl req -x509 -new -nodes -key .key/CA.key -sha256 -days 1024 -out .crt/CA.crt
openssl req -x509 -new -nodes -key .key/server.key -sha256 -days 1024 -out .crt/server.crt
openssl req -x509 -new -nodes -key .key/client.key -sha256 -days 1024 -out .crt/client.crt
# CSR (Certificate Signing Request) for the server and client using their keys.
openssl req -new -key .key/server.key -out .csr/server.csr
openssl req -new -key .key/client.key -out .csr/client.csr
# Run: chmod +x ./CA_server_client-keys_CSR.sh

# Author: Eng. Esteban Márquez Delgado
# Repository: https://github.com/EstebanMqz/Registries
# Date: 2024-01-21

