#!/bin/bash
#chmod +x setup_ubuntu.sh ./setup_ubuntu.sh

# Function to install a package if it's not already installed
install_if_not_present() {
    if ! dpkg -l | grep -q "$1"; then
        echo "$1 not found. Installing..."
        sudo apt-get install -y "$1"
    else
        echo "$1 is already installed."
    fi
}

# Update package lists
sudo apt-get update

# Install Zulu OpenJDK 17
if ! java -version 2>&1 | grep -q "17"; then
    echo "Java 17 (Zulu) not found. Installing..."
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
    sudo apt-add-repository 'deb http://repos.azul.com/zulu/deb/ stable main'
    sudo apt-get update
    sudo apt-get install -y zulu-17
else
    echo "Java 17 (Zulu) is already installed."
fi

# Set Java 17 as the default
sudo update-alternatives --set java /usr/lib/jvm/zulu-17-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/zulu-17-amd64/bin/javac

# Install Maven (latest stable version)
if ! mvn -version 2>&1 | grep -q "Apache Maven"; then
    echo "Maven not found. Installing..."
    sudo apt-get install -y maven
else
    echo "Maven is already installed."
fi

# Install Git
install_if_not_present git

# Install Helm
if ! helm version 2>&1 | grep -q "Version"; then
    echo "Helm not found. Installing..."
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
    sudo apt-get install apt-transport-https --yes
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install -y helm
else
    echo "Helm is already installed."
fi

# Install Docker
if ! docker --version 2>&1 | grep -q "Docker version"; then
    echo "Docker not found. Installing..."
    sudo apt-get remove -y docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
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
    sudo usermod -aG docker $USER
else
    echo "Docker is already installed."
fi

# Install Kubernetes and kubectl using snap
if ! kubectl version --client 2>&1 | grep -q "Client Version"; then
    echo "Kubernetes and kubectl not found. Installing..."
    sudo snap install kubectl --classic
    sudo snap install kubelet --classic
    sudo snap install kubeadm --classic
else
    echo "Kubernetes and kubectl are already installed."
fi

# Install IntelliJ IDEA Community Edition
if ! snap list intellij-idea-community 2>&1 | grep -q "intellij-idea-community"; then
    echo "IntelliJ IDEA Community Edition not found. Installing..."
    sudo apt-get install libxrender1 libxtst6 libxi6 libxrandr2 libxcursor1
    sudo snap install intellij-idea-community --classic
else
    echo "IntelliJ IDEA Community Edition is already installed."
fi

# Enable kubectl autocompletion
echo "Enabling kubectl autocompletion..."
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >>~/.bashrc

# Create permanent aliases
echo "Creating aliases..."
echo 'alias k=kubectl' >>~/.bashrc
echo 'alias idea="intellij-idea-community"' >>~/.bashrc

# Apply the changes to the current session
source ~/.bashrc

echo "All tasks completed successfully!"
