#!/bin/bash

# Function to check flag file and execute commands
check_and_execute() {
  FLAG_FILE="/var/log/pull_prometheus_script"
  FORCE_EXECUTION=$1

  if [ "$FORCE_EXECUTION" == "true" ]; then
    echo "Force execution enabled. Running script regardless of flag file..."
  else
    if [ -f "$FLAG_FILE" ]; then
      echo "Script pull prometheus already executed. Exiting."
      exit 0
    fi
  fi

  # Execute your provisioning commands
  echo "Running script pull prometheus..."
  
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo update
  helm pull prometheus-community/kube-prometheus-stack --untar
  mv kube-prometheus-stack workspace/kube-prometheus-stack

  # Mark script as executed
  sudo touch $FLAG_FILE
}

# Main script execution
check_and_execute "$1"