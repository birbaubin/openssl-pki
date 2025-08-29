#!/bin/bash
set -e

# Initialize PKI if not already done
if [ ! -f certs/intermediate.cert.pem ]; then
  echo "[*] No intermediate cert found, please generate CSR and sign with Root CA."
else
  echo "[*] Intermediate CA ready."
fi

# Start a simple HTTP server to publish CRL and certs
echo "[*] Publishing CRL and CA chain on port 8080..."
python3 -m http.server 8080
