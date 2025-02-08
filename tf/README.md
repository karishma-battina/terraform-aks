## AKS setup with ArgoCD using terraform

# Pre-requisities

1. Azure subscription

# Steps

1. Add azure credentials(client id, client secret, tenant id, subscription id) in project secrets
2. Create Azure Storage container in Azure portal for terraform backend
3. Configure github actions file to run terraform commands
  - Az cli install
  - Az login
  - create resource group
  - create AKS
  - Install ArgoCD using helm
     
# Improvements
- Improve outputs to print loadbalancer IP and argocd creds?
- Improve documentation
