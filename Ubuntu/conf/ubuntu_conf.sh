#!/bin/bash
# chmod +x setup_ubuntu.sh
# ./setup_ubuntu.sh

# Function to log progress
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Function to ensure previous command succeeded
check_command() {
    if [ $? -ne 0 ]; then
        log "Error: $1 failed."
        exit 1
    fi
}

# Update package lists
log "Updating package lists..."
sudo apt update
check_command "Package list update"

# Check and install zip and unzip
if ! command -v zip &> /dev/null; then
    log "Installing zip..."
    sudo apt install -y zip
    check_command "zip installation"
fi

if ! command -v unzip &> /dev/null; then
    log "Installing unzip..."
    sudo apt install -y unzip
    check_command "unzip installation"
fi

# Install SDKMAN
if ! command -v sdk &> /dev/null; then
    log "Installing SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    check_command "SDKMAN installation"
fi

# Ensure SDKMAN is sourced
if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Install Java 17 (Zulu version) via SDKMAN if not already installed
if ! command -v java &> /dev/null; then
    log "Installing Java 17 (Zulu)..."
    sdk install java 17.0.6-zulu
    sdk default java 17.0.6-zulu
    check_command "Java 17 (Zulu) installation"
fi

# Check and install Maven via SDKMAN
if ! command -v mvn &> /dev/null; then
    log "Installing Maven via SDKMAN..."
    sdk install maven
    check_command "Maven installation via SDKMAN"
fi

# Check and install Git
if ! command -v git &> /dev/null; then
    log "Installing Git..."
    sudo apt install -y git
    check_command "Git installation"
fi

# Check and install Helm
if ! command -v helm &> /dev/null; then
    log "Installing Helm..."
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
    sudo apt-get install apt-transport-https --yes
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install -y helm
    check_command "Helm installation"
fi

# Check and install Docker
if ! command -v docker &> /dev/null; then
    log "Installing Docker..."
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    check_command "Docker installation"
fi

# Install kubectl using snap
if ! command -v kubectl &> /dev/null; then
    log "Installing kubectl..."
    sudo snap install microk8s --classic
#    sudo snap install kubectl --classic

    check_command "kubectl installation"
fi

# Install IntelliJ IDEA Community Edition
if ! command -v intellij-idea-community &> /dev/null; then
    log "Installing IntelliJ IDEA Community Edition..."
    sudo snap install intellij-idea-community --classic
    check_command "IntelliJ IDEA installation"
fi

# Install graphical libraries necessary for IntelliJ IDEA
log "Installing graphical libraries for IntelliJ IDEA..."
sudo apt-get install -y libgtk-3-dev libcanberra-gtk-module
check_command "Graphical libraries installation"

# Set up kubectl autocompletion and alias
#if ! grep -q "alias k=kubectl" ~/.bashrc; then
#    log "Setting up kubectl autocompletion and alias..."
#    echo "source <(kubectl completion bash)" >> ~/.bashrc
#    echo "alias k=kubectl" >> ~/.bashrc
#    echo "complete -F __start_kubectl k" >> ~/.bashrc
#    check_command "kubectl alias setup"
#fi

# Set up microk8s kubectl alias
if ! grep -q "alias k8=microk8s kubectl" ~/.bashrc; then
    log "Setting up microk8s kubectl alias..."
    echo "alias k8='microk8s kubectl'" >> ~/.bashrc
    check_command "microk8s kubectl alias setup"
fi

# Set up IntelliJ IDEA alias
if ! grep -q "alias idea='intellij-idea-community'" ~/.bashrc; then
    log "Setting up IntelliJ IDEA alias..."
    echo "alias idea='intellij-idea-community'" >> ~/.bashrc
    check_command "IntelliJ IDEA alias setup"
fi

# Apply bashrc changes
log "Applying bashrc changes..."
source ~/.bashrc

log "Installing microk8s addons."
microk8s start
microk8s enable dns
microk8s enable ingress
microk8s enable storage
microk8s enable dashboard
log "Addons installed."

log "Setting up microk8s env."
sudo usermod -aG microk8s $USER
#newgrp microk8s

log "Installing locate..."
sudo sudo apt install plocate
log "All specified components are installed and configured."

#sudo apt-get update
#sudo apt-get install -y apt-transport-https ca-certificates curl

#sudo curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
#sudo chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin/kubectl

#curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
#sudo install minikube-linux-amd64 /usr/local/bin/minikube
