#!/bin/bash

# This is a bootstrap script to automate the creation of a k8s cluster on Minikube using the Docker driver

# Setting variables
export CLUSTER_NAME="$1"
export NAMESPACE=""
export ARGOCD_NS='argocd'
export DRIVER='docker'
export ARGO_URL='https://raw.githubusercontent.com/argoproj/argo-cd/v2.5.8/manifests/install.yaml'
export ARGO_SER='svc/argocd-server'

# Check if CLUSTER_NAME variable is set or not
if [ -z "$CLUSTER_NAME" ]; then
  echo "Error: CLUSTER_NAME is not set or empty. Update it and then run the script again."
  exit 1
fi

# Create the cluster
echo -e "\nCreating the Cluster: ${CLUSTER_NAME} Now"
sleep 2
minikube start --driver ${DRIVER} --profile ${CLUSTER_NAME}
echo -e "\nThe ${CLUSTER_NAME} Cluster has been created"
sleep 2

# Verify the cluster is running
echo -e "\n*** Cluster Created ***"
CLUSTER_STATUS=$(minikube status --profile ${CLUSTER_NAME})
echo -e "${CLUSTER_STATUS}"

# Install Argo CD and components
echo -e "\n\nInstalling Argo CD and Components\n"
sleep 2

echo "Creating Argo CD namespace"
kubectl create namespace ${ARGOCD_NS}
echo -e "\n"

sleep 2
echo "Installing ArgoCD Components"
kubectl apply --namespace ${ARGOCD_NS} -f ${ARGO_URL}

sleep 3
echo -e "\nTo get the admin secret, run:"
echo -e "\nkubectl -n ${ARGOCD_NS} get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d; echo"
echo -e "\nTo stop port forwarding, please press Ctrl+C"
echo -e "\nTo delete the cluster when done, run:"
echo -e "\nminikube delete -p ${CLUSTER_NAME}"
sleep 2

# The kubectl wait command is used to block until a specified condition is met on one or more Kubernetes resources. 
# In this case, the command is waiting for the Argo CD server service to become available.
echo -e "\n\nARGO CD Installed and Waiting for service to become available\n\n"
kubectl wait --namespace ${ARGOCD_NS} --for=condition=Available ${ARGO_SER} --timeout=60s

echo -e "\nStarting port forwarding"
kubectl port-forward ${ARGO_SER} -n ${ARGOCD_NS} 8080:443
