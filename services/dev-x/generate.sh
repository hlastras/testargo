#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start_number> <end_number>"
    exit 1
fi

start=$1
end=$2

# Iterate over the specified range
for ((i=start; i<=end; i++)); do
    # Define directory path
    dir_path="helloworld${i}/testing"

    # Create the directory hierarchy
    mkdir -p "${dir_path}"

    # Create the deployment.yaml file with the desired content
    cat <<EOF >"${dir_path}/deployment.yaml"
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: helloworld${i}
spec:
  replicas: 0
  selector:
    matchLabels:
      app: helloworld${i}
  template:
    metadata:
      labels:
        app: helloworld${i}
        owner: hector
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["/bin/sh", "-c"]
        args: ["echo Hello && sleep 600"]
EOF

done

echo "Directories and files created successfully."
