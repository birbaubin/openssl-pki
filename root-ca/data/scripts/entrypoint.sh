#!/bin/bash
set -e

CA_HOME=/etc/pki
KEY_FILE=$CA_HOME/private/root.key.pem
CERT_FILE=$CA_HOME/certs/root.cert.pem
CONFIG_FILE=$CA_HOME/openssl.cnf

# Initialize PKI directories if empty
if [ ! -f "$CA_HOME/index.txt" ]; then
    echo "[*] Initializing Root CA directory..."
    mkdir -p $CA_HOME/{certs,crl,newcerts,private,csr}
    chmod 700 $CA_HOME/private
    touch $CA_HOME/index.txt
    echo 1000 > $CA_HOME/serial
    echo 1000 > $CA_HOME/crlnumber
fi

# Generate Root CA private key if not present
if [ ! -f "$KEY_FILE" ]; then
    echo "[*] Generating Root CA private key..."
    openssl genrsa -aes256 -out $KEY_FILE 4096
    chmod 400 $KEY_FILE
fi

# Generate Root CA certificate if not present
if [ ! -f "$CERT_FILE" ]; then
    echo "[*] Generating Root CA self-signed certificate..."
    openssl req -config $CONFIG_FILE \
        -key $KEY_FILE \
        -new -x509 -days 7300 -sha256 -extensions v3_ca \
        -out $CERT_FILE
    chmod 444 $CERT_FILE
fi

echo "[*] Root CA is ready."
echo "------------------------------------------"
echo "Key:   $KEY_FILE"
echo "Cert:  $CERT_FILE"
echo "Use this container to sign Intermediate CA CSRs."
echo "------------------------------------------"

# Drop into a shell for manual commands (signing, revocation, etc.)
exec bash
