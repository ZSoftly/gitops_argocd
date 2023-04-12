[![Test The Bootstrap Script](https://github.com/ZSoftly/gitops_argocd/actions/workflows/test_bashscript.yml/badge.svg)](https://github.com/ZSoftly/gitops_argocd/actions/workflows/test_bashscript.yml)

# Kubernetes Cluster Automation with Minikube
  - This repository contains a bash script and a GitHub Actions workflow to automate the creation and testing of a Kubernetes cluster on Minikube using the Docker driver. The script installs Argo CD and its components, and sets up port-forwarding to access the Argo CD server via a local browser.

## What is GitOps
  - GitOps is a modern approach to managing infrastructure and application configurations using Git as the source of truth. It is a set of practices that combines Git repositories, version control, and CI/CD tools to enable developers to manage and deploy applications and infrastructure declaratively. GitOps principles help to increase development velocity, improve traceability, and enhance the overall reliability of the deployment process.

## What is ArgoCD
  - Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes. It follows the GitOps principles to manage and deploy applications on a Kubernetes cluster. Argo CD automates the synchronization of the desired application state defined in a Git repository with the actual state running in the cluster. With Argo CD, you can enable automated deployment and rollback, ensure consistency and reliability, and provide a clear audit trail of changes to your applications.

## The Bash Script Provisions a local k8s cluster on Minikube
The bash script, `minikube.sh`, automates the creation and testing of a Kubernetes cluster on Minikube using the Docker driver. It requires the following prerequisites:
  - Docker installed and the service started
  - Kubectl installed

The script performs the following tasks:
1. Creates a Minikube cluster with a specified cluster name.
2. Verifies the cluster status.
3. Installs Argo CD and its components.
4. Waits for the Argo CD server service to become available.
5. Sets up port-forwarding for the Argo CD server service.

To use the script, simply run:
```
./minikube.sh "your_cluster_name"
```

## GitHub Actions Workflow
The GitHub Actions workflow, located in .github/workflows/minikube.sh, tests the bash script in a CI/CD environment. It is triggered on push and pull requests to the main branch.

To test the script with the GitHub Actions workflow, simply push the changes to the main branch or create a pull request.

## Contributing
Please feel free to submit issues or pull requests if you find any problems with the script or the GitHub Actions workflow. Contributions are welcome!






