output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

# resource "local_file" "kubeconfig" {
#   depends_on   = [azurerm_kubernetes_cluster.argocd]
#   filename     = "kubeconfig"
#   content      = azurerm_kubernetes_cluster.argocd.kube_config_raw
# }

#output "argocd_server_url" {
#  value = "http://${data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].ip}:80"
#}

#output "argocd_admin_password" {
#  value     = data.kubernetes_secret.argocd_admin.data["password"]
#  sensitive = true
#}

# Output the LoadBalancer IP
output "argocd_loadbalancer_ip" {
  value = kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].ip
}

# Output the ArgoCD admin password
output "argocd_admin_password" {
  value = kubernetes_secret.argocd_initial_admin_secret.data.password
  sensitive = true
}