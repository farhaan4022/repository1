FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    openssl \
    socat \
    && rm -rf /var/lib/apt/lists/*

# Copy the script and certificates into the container
COPY wisecow.sh /wisecow.sh
COPY wisecow.sh /usr/local/bin/wisecow.sh
COPY wisecow.crt /etc/ssl/certs/wisecow.crt
COPY wisecow.key /etc/ssl/private/wisecow.key

# Make the script executable
RUN chmod +x /usr/local/bin/wisecow.sh

# Run the script
CMD ["/usr/local/bin/wisecow.sh"]
