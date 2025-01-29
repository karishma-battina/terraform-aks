#Azure Resource Group
resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}

#Azure Role Assignment
resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.argocd.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks-rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "argocd" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name
  default_node_pool {
    name       = "system"
    node_count = var.system_node_count
    vm_size    = "Standard_DS2_v2"

    type = "VirtualMachineScaleSets"
  }
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }
}
terraform {
  backend "azurerm" {
    resource_group_name  = "storage-rg"
    storage_account_name = "tfbackend23"
    container_name       = "default"
    key                  = "terraform.tfstate"
  }
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.argocd.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.argocd.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.argocd.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.argocd.kube_config.0.cluster_ca_certificate)
}

# Configure Helm Provider
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.argocd.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.argocd.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.argocd.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.argocd.kube_config.0.cluster_ca_certificate)
  }
}

# Install Argo CD using Helm
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.46.8" # Check for the latest version
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}

#data "kubernetes_secret" "argocd_admin" {
#  metadata {
#    name      = "argocd-initial-admin-secret"
#    namespace = "argocd"
#  }
#  depends_on = [helm_release.argocd]
#}

#data "kubernetes_service" "argocd_server" {
#  metadata {
#    name      = "argocd-server" # Name of the service created by the Helm chart
#    namespace = "argocd"
#  }
#  depends_on = [helm_release.argocd]
#}