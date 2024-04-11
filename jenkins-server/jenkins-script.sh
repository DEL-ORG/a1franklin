#!/bin/bash

# Update package index
sudo apt update

# Install dependencies (fontconfig and OpenJDK 17)
sudo apt install -y fontconfig openjdk-17-jre

# Check Java version
java -version

# Download Jenkins GPG key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository to sources list
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index after adding repository
sudo apt-get update

# Install Jenkins
sudo apt-get install -y jenkins

# Optionally, you may start Jenkins service
# sudo systemctl start jenkins
