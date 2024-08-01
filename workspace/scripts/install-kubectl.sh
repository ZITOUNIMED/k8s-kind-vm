#!/bin/bash

# Function to check flag file and execute commands
check_and_execute() {
  FLAG_FILE="/var/log/install_kubectl_script"
  FORCE_EXECUTION=$1

  if [ "$FORCE_EXECUTION" == "true" ]; then
    echo "Force execution enabled. Running script regardless of flag file..."
  else
    if [ -f "$FLAG_FILE" ]; then
      echo "Script install kubectl already executed. Exiting."
      exit 0
    fi
  fi

  # Execute your provisioning commands
  echo "Running script install kubectl ..."
  
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  kubectl version

  # Mark script as executed
  sudo touch $FLAG_FILE
}

# Main script execution
check_and_execute "$1"