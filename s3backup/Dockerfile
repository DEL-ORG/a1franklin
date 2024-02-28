FROM postgres:latest

# Install Python and pip
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI using apt
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        awscli \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /a1franklin-backup

# Copy the backup script
COPY . .

# Make the backup script executable
RUN chmod +x backup.sh

# Set the entry point for the container
ENTRYPOINT ["./backup.sh"]

