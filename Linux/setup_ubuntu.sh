#!/bin/bash
# chmod +x setup_ubuntu.sh
# ./setup_ubuntu.sh

# Update package lists
sudo apt update

# Check and install zip and unzip
if ! command -v zip &> /dev/null; then
    sudo apt install -y zip
fi

if ! command -v unzip &> /dev/null; then
    sudo apt install -y unzip
fi

# Install SDKMAN
if ! command -v sdk &> /dev/null; then
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Ensure SDKMAN is sourced
if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Install Java 17 (Zulu version) via SDKMAN if not already installed
if ! command -v java &> /dev/null; then
    sdk install java 17.0.6-zulu
    sdk default java 17.0.6-zulu
fi

# Check and install Maven
if ! command -v mvn &> /dev/null; then
    sudo apt install -y maven
fi

# Check and install Git
if ! command -v git &> /dev/null; then
    sudo apt install -y git
fi

# Check and install Helm
if ! command -v helm &> /dev/null; then
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
    sudo apt-get install apt-transport-https --yes
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install -y helm
fi

# Check and install Docker
if ! command -v docker &> /dev/null; then
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
fi

# Install IntelliJ IDEA Community Edition
if ! command -v intellij-idea-community &> /dev/null; then
    sudo snap install intellij-idea-community --classic
fi

# Install graphical libraries necessary for IntelliJ IDEA
sudo apt-get install -y libgtk-3-dev libcanberra-gtk-module

# Set up IntelliJ IDEA alias
if ! grep -q "alias idea='intellij-idea-community'" ~/.bashrc; then
    echo "alias idea='intellij-idea-community'" >> ~/.bashrc
fi



# Install Kubernetes and kubectl using snap
if ! command -v kubectl &> /dev/null; then
    sudo snap install kubectl --classic
    sudo snap install microk8s --classic
    sudo usermod -a -G microk8s $USER
    sudo chown -f -R $USER ~/.kube
    newgrp microk8s
    microk8s status --wait-ready
    microk8s enable dns storage
fi

# Set up kubectl autocompletion and alias
if ! grep -q "alias k=kubectl" ~/.bashrc; then
    echo "source <(kubectl completion bash)" >> ~/.bashrc
    echo "alias k=kubectl" >> ~/.bashrc
    echo "complete -F __start_kubectl k" >> ~/.bashrc
fi

# Apply bashrc changes
source ~/.bashrc

# Source the aliases in the current shell
if ! alias k &> /dev/null; then
    alias k=kubectl
fi

if ! alias idea &> /dev/null; then
    alias idea='intellij-idea-community'
fi

echo "All specified components are installed and configured."
