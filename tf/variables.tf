
variable "resource_group_name" {
  type        = string
  description = "Name of resource group"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
/*
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "acr_name" {
  type        = string
  description = "ACR name"
}*/