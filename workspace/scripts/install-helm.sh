#!/bin/bash

# Function to check flag file and execute commands
check_and_execute() {
  FLAG_FILE="/var/log/install_helm_script"
  FORCE_EXECUTION=$1

  if [ "$FORCE_EXECUTION" == "true" ]; then
    echo "Force execution enabled. Running script regardless of flag file..."
  else
    if [ -f "$FLAG_FILE" ]; then
      echo "Script install helm already executed. Exiting."
      exit 0
    fi
  fi

  # Execute your provisioning commands
  echo "Running script install helm ..."
  
  curl -LO "https://get.helm.sh/helm-v3.15.3-linux-amd64.tar.gz"
  tar -zxvf helm-v3.15.3-linux-amd64.tar.gz
  sudo mv linux-amd64/helm /usr/local/bin/helm
  helm version
  rm helm-v3.15.3-linux-amd64.tar.gz
  rm -rf linux-amd64

  # Mark script as executed
  sudo touch $FLAG_FILE
}

# Main script execution
check_and_execute "$1"