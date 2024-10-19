#!/bin/bash
# chmod +x cleanup_ubuntu.sh
# ./cleanup_ubuntu.sh

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

# Uninstall SDKMAN and Java
if [ -d "$HOME/.sdkman" ]; then
    log "Removing SDKMAN..."
    rm -rf "$HOME/.sdkman"
    sed -i '/sdkman-init.sh/d' ~/.bashrc
    check_command "SDKMAN removal"
fi

log "Removing Java 17 (Zulu)..."
sdk uninstall java 17.0.6-zulu || log "Java 17 (Zulu) not installed"
check_command "Java 17 (Zulu) removal"

log "Removing Maven..."
sdk uninstall maven || log "Maven not installed"
check_command "Maven removal"

# Uninstall zip and unzip
if command -v zip &> /dev/null; then
    log "Removing zip..."
    sudo apt remove -y zip
    check_command "zip removal"
fi

if command -v unzip &> /dev/null; then
    log "Removing unzip..."
    sudo apt remove -y unzip
    check_command "unzip removal"
fi

# Uninstall Git
if command -v git &> /dev/null; then
    log "Removing Git..."
    sudo apt remove -y git
    check_command "Git removal"
fi

# Uninstall Helm
if command -v helm &> /dev/null; then
    log "Removing Helm..."
    sudo apt remove -y helm
    sudo rm /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    check_command "Helm removal"
fi

# Uninstall Docker
if command -v docker &> /dev/null; then
    log "Removing Docker..."
    sudo apt-get purge -y docker-ce docker-ce-cli containerd.io
    sudo rm /usr/share/keyrings/docker-archive-keyring.gpg
    sudo rm /etc/apt/sources.list.d/docker.list
    sudo apt-get update
    check_command "Docker removal"
fi

# Uninstall kubectl (MicroK8s)
if command -v microk8s &> /dev/null; then
    log "Removing MicroK8s (kubectl)..."
    sudo snap remove microk8s
    check_command "MicroK8s removal"
fi

# Uninstall IntelliJ IDEA Community Edition
if command -v intellij-idea-community &> /dev/null; then
    log "Removing IntelliJ IDEA Community Edition..."
    sudo snap remove intellij-idea-community
    check_command "IntelliJ IDEA removal"
fi

# Uninstall graphical libraries for IntelliJ IDEA
log "Removing graphical libraries for IntelliJ IDEA..."
sudo apt-get remove -y libgtk-3-dev libcanberra-gtk-module
check_command "Graphical libraries removal"

# Uninstall plocate
if command -v plocate &> /dev/null; then
    log "Removing plocate..."
    sudo apt remove -y plocate
    check_command "plocate removal"
fi

# Remove aliases from bashrc
log "Removing aliases from bashrc..."
sed -i '/alias k8=/d' ~/.bashrc
sed -i '/alias idea=/d' ~/.bashrc
source ~/.bashrc
check_command "Alias removal"

sudo apt autoremove

log "All specified components have been removed."
