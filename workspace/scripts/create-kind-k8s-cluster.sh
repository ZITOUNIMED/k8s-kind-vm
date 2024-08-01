#!/bin/bash

# Function to check flag file and execute commands
check_and_execute() {
  FLAG_FILE="/var/log/create_kind_k8s_cluster_script"
  FORCE_EXECUTION=$1

  if [ "$FORCE_EXECUTION" == "true" ]; then
    echo "Force execution enabled. Running script regardless of flag file..."
  else
    if [ -f "$FLAG_FILE" ]; then
      echo "Script create kind k8s cluster already executed. Exiting."
      exit 0
    fi
  fi

  # Execute your provisioning commands
  echo "Running script create kind k8s cluster..."
  
echo '
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: k8s-c1
nodes:
- role: control-plane
- role: worker
' > workspace/k8s-c1/config.yaml

  sudo kind delete clusters --all
  sudo kind create cluster --config=workspace/k8s-c1/config.yaml

  # Mark script as executed
  sudo touch $FLAG_FILE
}

# Main script execution
check_and_execute "$1"