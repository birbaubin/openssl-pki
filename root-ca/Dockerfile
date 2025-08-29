FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    openssl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set environment and working dir
ENV CA_HOME=/etc/pki
WORKDIR $CA_HOME

# Copy config and scripts
COPY openssl.cnf .
COPY scripts/ ./scripts/

# Make directories and files
RUN mkdir -p certs crl newcerts private csr && \
    chmod 700 private && \
    touch index.txt && \
    echo 1000 > serial

RUN chmod +x /etc/pki/scripts/entrypoint.sh
ENTRYPOINT ["/etc/pki/scripts/entrypoint.sh"]


