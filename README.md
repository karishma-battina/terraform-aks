# Terraform Azure Kubernetes Service (AKS) and Azure Container Registry (ACR) Setup

This repository contains Terraform configurations to set up an Azure Kubernetes Service (AKS) cluster and an Azure Container Registry (ACR).

## Prerequisites
- An Azure subscription

## Using GitHub Codespaces

This repository is configured to work with GitHub Codespaces. To get started:

Open the repository in GitHub.
Click the Code button and select Open with Codespaces.
Create a new Codespace or select an existing one.
Once the Codespace is ready, you can run Terraform commands directly in the integrated terminal.

## Folder Structure

tf Folder:
The tf folder contains the Terraform configuration files:
providers.tf: Specifies the Azure provider and its version.
main.tf: Defines the resources for the Azure Resource Group, ACR, AKS cluster, and role assignments.
output.tf: Defines the outputs for the AKS and ACR resources.
variables.tf: Define input variables for the Terraform configuration.

.devcontainer Folder:
The .devcontainer folder contains configuration files for setting up a development container in Visual Studio Code:

devcontainer.json: Defines the configuration for the development container, including the Docker image, extensions, and settings.
