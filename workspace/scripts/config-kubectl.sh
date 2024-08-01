#!/bin/bash

# Function to check flag file and execute commands
check_and_execute() {
  FLAG_FILE="/var/log/config_kubectl_script"
  FORCE_EXECUTION=$1

  if [ "$FORCE_EXECUTION" == "true" ]; then
    echo "Force execution enabled. Running script regardless of flag file..."
  else
    if [ -f "$FLAG_FILE" ]; then
      echo "Script config kubectl already executed. Exiting."
      exit 0
    fi
  fi

  # Execute your provisioning commands
  echo "Running script config kubectl..."
  
  mkdir -p /home/vagrant/.kube
  sudo cp /root/.kube/config /home/vagrant/.kube/
  sudo chown vagrant:vagrant /home/vagrant/.kube/config
  chmod 600 /home/vagrant/.kube/config
  kubectl get nodes

  # Mark script as executed
  sudo touch $FLAG_FILE
}

# Main script execution
check_and_execute "$1"