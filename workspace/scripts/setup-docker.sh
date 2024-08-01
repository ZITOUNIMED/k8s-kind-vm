#!/bin/bash

# Function to check flag file and execute commands
check_and_execute() {
  FLAG_FILE="/var/log/setup_docker_script"
  FORCE_EXECUTION=$1

  if [ "$FORCE_EXECUTION" == "true" ]; then
    echo "Force execution enabled. Running script regardless of flag file..."
  else
    if [ -f "$FLAG_FILE" ]; then
      echo "Script setup-docker.sh already executed. Exiting."
      exit 0
    fi
  fi

  # Execute your provisioning commands
  echo "Running script setup-docker.sh"
  
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
		
  # Post install docker
  sudo usermod -aG docker $USER
  
  newgrp docker
  
  docker version

  # Mark script as executed
  sudo touch $FLAG_FILE
}

# Main script execution
check_and_execute "$1"