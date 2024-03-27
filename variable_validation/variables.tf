/*
This file is used for demonstrating Variable Validation in Terraform. 
Variables are validated for conditions defined; if failed, then error messages defined are raised.
Change directory into this folder and just run terraform apply.
Give the variables manually through command line and understand how the validation is performed.
*/

variable "cloud" {
  description = "The accepted format and values for cloud variable"
  type        = string

  validation {
    condition     = contains(["aws", "azure", "gcp"], lower(var.cloud))
    error_message = "The value must be either aws, azure or gcp"
  }

  validation {
    condition     = (lower(var.cloud) == var.cloud)
    error_message = "The variable value must be specified in lowercase"
  }
}

variable "charater_limit" {
  type        = string
  description = "Enforcing the character length limit"

  validation {
    condition     = length(var.charater_limit) >= 5 && length(var.charater_limit) <= 7
    error_message = "The length of character must be no less than 5 and no more than 7"
  }
}

variable "ip_address" {
  type        = string
  description = "Accepted format of IP address"

  validation {
    condition     = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.ip_address))
    error_message = "Must be an IP address of the form X.X.X.X"
  }
}

variable "phone_number" {
  type = string
  sensitive = true
  default = "867-4390"
}

locals {
  contact_info = {
    cloud = var.cloud
    cost_code = var.charater_limit
    phone_number = var.phone_number
  }

  my_number = nonsensitive(var.phone_number)
}

output "cloud" {
  value = local.contact_info.cloud
}

output "cost_code" {
  value = local.contact_info.cost_code
}

output "phone_number" {
  sensitive = true
  value = local.contact_info.phone_number
}

output "my_number" {
  value = local.my_number
}

