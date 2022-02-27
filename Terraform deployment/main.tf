
terraform {

  backend "azurerm" {



    }

}
terraform {
 backend "azurerm" {
    resource_group_name = "azurerm_resource_group.acr-rg.name"
    storage_account_name = "var.storage_account_name"
    container_name = "var.container_name"
    key = "terraform.state"
 }
}
provider "azurerm" {
 # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
 version         = "=2.18.0"
 subscription_id = var.subscription_id
 features {}
 skip_provider_registration = "true"

}
provider "azuread" {
 version = "=0.7.0"
}
 
# Create a Resource Group
resource "azurerm_resource_group" "appservice-rg" {
  name = "${var.app_name}-${var.environment}_AppService-rg"
  location = var.location
 
  tags = {
    owner = var.owner
    environment = var.environment
  }
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                     = var.container_registry_name
  resource_group_name      = azurerm_resource_group.acr-rg.name
  location                 = azurerm_resource_group.acr-rg.location
  sku                      = "Standard"
  admin_enabled            = true
}


# Create app service plan
resource "azurerm_app_service_plan" "service-plan" {
  name = "${var.app_name}-${var.environment}_AppService-plan"
  location = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  kind = "Linux"
  reserved = true
 
  sku {
    tier = "Basic"
    size = "B1"
  }
 
  tags = {
    owner = var.owner
    environment = var.environment
  }
}


# web App
resource "azurerm_app_service" "app-service" {
  name = var.web_app_name
  location = azurerm_resource_group.acr-rg.location
  resource_group_name = azurerm_resource_group.acr-rg.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.acr.admin_password
  
  }
  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|${var.registry_name}:${var.tag_name}"
    always_on        = "true"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    owner = var.owner
    environment = var.environment
  }
}

data "azurerm_user_assigned_identity" "assigned_identity_acr_pull" {
 provider            = azurerm.acr_sub
 name                = "User_ACR_pull"
 resource_group_name = azurerm_resource_group.acr-rg.name
}

#Monitoring using app insights
resource "azurerm_application_insights" "my_app_insight" {
 name                = var.my_app_insight_name
 location            = var.location
 resource_group_name = azurerm_resource_group.acr-rg.name
 application_type    = var.application # Depends on your application
 disable_ip_masking  = true
 retention_in_days   = 730
}

## Outputs
output "app_service_name" {
  value = "${azurerm_app_service.app-service.name}"
}
output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.app-service.default_site_hostname}"
}