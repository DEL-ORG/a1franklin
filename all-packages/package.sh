#!/bin/bash

# Function to check if the user is root
check_root() {
    if [[ $(id -u) -ne 0 ]]; then
        echo "Sorry, you need to be root"
        exit 1
    fi
}

# Function to check OS type
check_os() {
    if [[ -e /etc/os-release ]]; then
        . /etc/os-release
        OS=$ID
    else
        echo "Cannot determine the OS type."
        exit 1
    fi

    if [[ $OS != "ubuntu" ]]; then
        echo "Sorry, this script can only work on Ubuntu"
        exit 1
    fi
}

# Function to install common packages
install_common_packages() {
    apt update -y
    apt install -y tree curl vim wget ansible default-jre default-jdk ansible-lint maven git unzip openssl sshpass gnupg
    apt-get update -y
    export DEBIAN_FRONTEND=noninteractive
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
    apt-get install -y tzdata
    dpkg-reconfigure --frontend noninteractive tzdata
}

# Function to install Docker
install_docker() {
    sudo apt-get remove -y docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo chmod 666 /var/run/docker.sock
    usermod jenkins -aG docker
    usermod ansible -aG docker
    usermod ubuntu -aG docker
}

# Function to install additional tools
install_additional_tools() {
    apt install -y apt-transport-https dnsutils htop iftop iotop iperf iputils-ping jq less locales ltrace man-db manpages mosh mtr netcat nethogs nfs-common pass psmisc python3-apt python3-docker rkhunter rsync screen ssl-cert strace tcpdump time traceroute unhide unzip uuid-runtime
    sudo chmod 666 /var/run/docker.sock
}

# Function to install Jenkins
install_jenkins() {
    echo "Installing Jenkins.......... please wait"
    install_common_packages
    install_docker
    install_additional_tools
    useradd jenkins -m -d /home/jenkins -s /bin/bash
    useradd ansible -m -d /home/ansible -s /bin/bash
    echo -e 'jenkins  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/jenkins
    echo -e 'ansible  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/ansible
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    mkdir -p /usr/local/lib/docker/cli-plugins
    curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
    sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install -y terraform
}

# Function to install Gitlab-runner
install_gitlab_runner() {
    echo "Installing Gitlab-runner .......... please wait"
    install_common_packages
    install_docker
    install_additional_tools
    useradd ansible -m -d /home/ansible -s /bin/bash
    echo -e 'ansible  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/ansible
    curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash 
    sudo apt-get install gitlab-runner
    sudo gitlab-runner status
    echo -e 'gitlab-runner  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/gitlab-runner
    usermod gitlab-runner -aG docker
}

# Main script execution
check_root
check_os

echo "1. Jenkins"
echo "2. Gitlab-runner"
read -p "Please enter the number that corresponds to your need: " NUM

case $NUM in
    1) install_jenkins ;;
    2) install_gitlab_runner ;;
    *) echo "Please select either 1 or 2" ;;
esac

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

