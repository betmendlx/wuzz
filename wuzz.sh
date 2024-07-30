#!/bin/bash

# Color codes for colored output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Function to print messages in color
print_msg() {
    color=$1
    message=$2
    echo -e "${color}${message}${RESET}"
}

# Update and upgrade system packages
print_msg "${GREEN}" "Updating and upgrading system packages..."
sudo apt-get -y update
sudo apt-get -y upgrade
print_msg "${BLUE}" "System packages updated and upgraded."

# Add the apt-fast repository and set debconf selections
print_msg "${GREEN}" "Adding apt-fast repository and setting debconf selections..."
sudo add-apt-repository -y ppa:apt-fast/stable
echo debconf apt-fast/maxdownloads string 16 | sudo debconf-set-selections
echo debconf apt-fast/dlflag boolean true | sudo debconf-set-selections
echo debconf apt-fast/aptmanager string apt-get | sudo debconf-set-selections
print_msg "${BLUE}" "apt-fast repository added and debconf selections set."

# Install apt-fast
print_msg "${GREEN}" "Installing apt-fast..."
sudo apt-get install -y apt-fast
print_msg "${BLUE}" "apt-fast installed."

# List of required packages
packages=(
    "apt-transport-https"
    "libcurl4-openssl-dev"
    "libssl-dev"
    "jq"
    "ruby-full"
    "libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev"
    "build-essential libffi-dev python-dev"
    "python-setuptools"
    "libldns-dev"
    "python3-pip"
    "python-dnspython"
    "git"
    "npm"
    "nmap"
    "phantomjs"
    "gem"
    "perl"
    "parallel"
)

# Install required packages using apt-fast
print_msg "${GREEN}" "Installing required packages..."
for package in "${packages[@]}"; do
    print_msg "${YELLOW}" "Installing ${package}..."
    sudo apt-fast install -y $package
    print_msg "${BLUE}" "${package} installed."
done

# Install Python packages using pip3
print_msg "${GREEN}" "Installing Python packages using pip3..."
pip3 install jsbeautifier
print_msg "${BLUE}" "Python packages installed."

# Additional commands
print_msg "${GREEN}" "Running sar command..."
sar 1 1 > /dev/null

# Tools installation
print_msg "${GREEN}" "Installing fuzzing tools..."
#install gobuster
print_msg "${YELLOW}" "Installing gobuster..."
sudo go get -u github.com/OJ/gobuster
print_msg "${BLUE}" "Gobuster installed."

#install ffuf
print_msg "${YELLOW}" "Installing ffuf..."
go get -u github.com/ffuf/ffuf
print_msg "${BLUE}" "ffuf installed."

#install dirsearch
print_msg "${YELLOW}" "Installing dirsearch..."
git clone https://github.com/maurosoria/dirsearch.git ~/tools/dirsearch
print_msg "${BLUE}" "dirsearch installed."

#install wfuzz
print_msg "${YELLOW}" "Installing wfuzz..."
sudo apt-fast install -y wfuzz
print_msg "${BLUE}" "wfuzz installed."

print_msg "${GREEN}" "All packages and tools installed successfully."

# Final instructions
echo -e "${GREEN}#### Please use the command 'source ~/.bash_profile' for the shell functions to work ####${RESET}"
echo -e "${GREEN}#### ALL THE TOOLS ARE MADE BY THE BEST PEOPLE OF THE INFOSEC COMMUNITY ####${RESET}"
echo -e "${GREEN}#### I AM JUST A SCRIPT-KIDDIE ;) ####${RESET}"
