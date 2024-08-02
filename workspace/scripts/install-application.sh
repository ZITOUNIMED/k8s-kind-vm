#!/bin/bash

# Function to check flag file and execute commands
check_and_execute() {
  FLAG_FILE="/var/log/install_application_script"
  FORCE_EXECUTION=$1

  if [ "$FORCE_EXECUTION" == "true" ]; then
    echo "Force execution enabled. Running script regardless of flag file..."
  else
    if [ -f "$FLAG_FILE" ]; then
      echo "Script install application already executed. Exiting."
      exit 0
    fi
  fi

  # Execute your provisioning commands
  echo "Running script install application ....."
  
  kubect create -f workspace/examples/nginx.yaml

  kubectl create -f workspace/examples/nginx-svc.yaml

  # Mark script as executed
  sudo touch $FLAG_FILE
}

# Main script execution
check_and_execute "$1"