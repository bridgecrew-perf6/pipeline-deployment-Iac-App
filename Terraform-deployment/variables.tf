variable "resource_group_name" {
  type        = string
  description = "Azure Resource Group Name. "
  default     = "rg-app"
}

variable "app_plan_name" {
  type        = string
  description = "Azure App Service Plan Name"
}
variable "web_app_name" {
  type        = string
  description = "Azure Web App Name"
}

variable "tag_name" {
  type        = string
  description = "Azure Web App Name"
  default: 'latest'
}

variable "subscription_id" {
  type        = string
  description = "subscription_id"
}
variable "container_registry_name" {
  type        = string
  description = "Azure Container Registry Name"
  default     = "app-acr"
}
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources.  It must be unique on Azure."
  default     = "front-end"
}

variable "app_port" {
  type        = string
  description = "Port used by the web app"
  default     = "8080"
}

variable "docker_image" {
  type        = string
  description = "Docker image name to deploy in the app service"
}

variable "docker_image_tag" {
  type        = string
  description = "Docker image tag to deploy"
  default     = "latest"
}

variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "canadacentral"
}

variable "application" {
  type        = string
  description = "Type of application"
  default     = "Node.JS"
}

variable "owner" {
  type        = string
  description = "Specify the owner of the resource"
  default     = "capegemini"
}
variable "azurerm_application_insights_name" {
  type        = string
  description = "Specify the owner of the resource"
  default     = "app-insights-name"
}
variable "description" {
  type        = string
  description = "Provide a description of the resource"
}

variable "storage_account_name" {
  type        = string
  description = "Specify the owner of the resource"
  default     = "stg01-rg"
}
variable "container_name" {
  type        = string
  description = "Specify the owner of the resource"
  default     = "container01-rg"
}
