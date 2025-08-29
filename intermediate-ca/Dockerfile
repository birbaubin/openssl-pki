FROM debian:stable-slim

# Install OpenSSL + minimal tools
RUN apt-get update && apt-get install -y \
    openssl \
    ca-certificates \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
RUN mkdir -p /etc/pki
ENV CA_HOME=/etc/pki
WORKDIR $CA_HOME

# Copy OpenSSL config and scripts
COPY openssl.cnf .
COPY scripts/ ./scripts/

# Prepare PKI directory structure
RUN mkdir -p certs crl newcerts private csr && \
    chmod 700 private && \
    touch index.txt && \
    echo 1000 > serial && \
    echo 1000 > crlnumber

# Expose CRL/OCSP port
EXPOSE 8080

# ENTRYPOINT ["./scripts/entrypoint.sh"]
