# Terraform Block
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.2"
    }

    # Importing other providers just to showcase the power of Terraform
    random = {
      source  = "hashicorp/random"
      version = ">=3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "=2.1.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "=3.1.0"
    }
  }
  required_version = ">=1.1.0"

  # Setting up a remote Terraform Cloud backend.
  cloud {
    organization = "MyTerraformOrgViswa"
    workspaces {
      name = "learn-terraform-azure"
    }
  }
}

// Provider Block. You can configure any provider specific details here. Never give your provider authentication configuration here. Always go for environmental variables or other prescribed secure ways.
provider "azurerm" {
  features {

  }
}

/* This is a Data block.
This retrieves attributes from the resources that are deployed outside of terraform
*/
data "azurerm_resource_group" "example" {
  name = "manualrg"
}

/*
The locals block in Terraform allows you to define reusable values within a Terraform configuration. It's typically used to simplify complex expressions, avoid repetition, and improve readability.
*/

locals {
  local_variable_rg = var.resource_group_name
}

locals {
  environment_name = "Terraform deployement"
}

# This is where you actually define your resources that are needed. Here, you are using Azure Resource Group provider to create a Resource group.
resource "azurerm_resource_group" "rg" {
  name     = local.local_variable_rg
  location = "eastus2"
  tags = {
    Environment = local.environment_name
    Team        = "DevOps"
  }
}


# Creating a VNET resource
resource "azurerm_virtual_network" "vnet" {
  name                = "my_test_vnet_tf"
  location            = "eastus2"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
}

# Creating a subnet
resource "azurerm_subnet" "example" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_virtual_network" "vnet_another" {
  name                = "my_test_vnet_tf_another"
  location            = data.azurerm_resource_group.example.location
  address_space       = ["10.1.0.0/16"]
  resource_group_name = data.azurerm_resource_group.example.name
}

# The commented blocks are to test other features while learning, feel free to uncomment and play with them.
/*
resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "MyAWSKey.pem"
}
*/

# In Terraform, modules allow you to encapsulate reusable infrastructure configurations. Here I am using a custom local module.
module "vnetmodule" {
  source = "./modules/vnetmodule/"
}

# Here, I am using an existing module defined from Terraform public module registry.
module "network-security-group" {
  source  = "Azure/network-security-group/azurerm"
  version = "3.5.0"
  # insert the 1 required variable here
  resource_group_name = "manualrg"
}

resource "azurerm_virtual_network" "vnet_from_listlocation" {
  #for_each            = var.ip_map
  for_each = var.env_map
  name     = "${each.key}_subnet"
  location = each.value.location
  #location            = var.us_region_list[1]
  address_space       = [each.value.ip]
  resource_group_name = data.azurerm_resource_group.example.name
}

# In Terraform, the output block is used to define values that will be exposed to the user after applying the configuration
output "vnetmodule_output" {
  value = module.vnetmodule.vnet_rg_id
}


/*
For maintaining a backend state file in mystate folder. Create a folder named mystate and define this config.

terraform {
  backend "local" {
    path = "./mystate/terraform.tfstate"
  }
}
*/

# Creating a NSG and defining rules for this resource.
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  lifecycle {
    create_before_destroy = true
  #  prevent_destroy = true
  }

}

# Associate NSG with the virtual network
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}



/*
Dynamic Blocks Demonstration. 
In Terraform, dynamic blocks allow you to generate multiple instances of a configuration block based on dynamic input data. This is particularly useful when you need to create multiple similar configurations, such as multiple AWS security groups or Azure virtual machines, based on a variable number of input elements.
*/

/*
locals {
  security_rules = [{
    name                   = "AllowRDP"
    priority               = 1003
    destination_port_range = "3389"
    },
    {
      name                   = "AllowHTTPS"
      priority               = 1004
      destination_port_range = "443"

  }]
}


resource "azurerm_network_security_group" "example2" {
  name                = "example-nsg2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = local.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

}

# Associate NSG with the virtual network
resource "azurerm_subnet_network_security_group_association" "example2" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example2.id
}
*/