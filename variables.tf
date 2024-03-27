variable "resource_group_name" {
  default     = "my_test_rg"
  type        = string
  description = "This is for variable resource group name"
  sensitive   = true
}

variable "us_region_list" {
  type    = list(string)
  default = ["eastus2", "westus2"]
}

variable "ip_map" {
  type = map(string)
  default = {
    dev  = "10.0.150.0/24"
    prod = "10.0.250.0/24"
  }
}

variable "env_map" {
  type = map(any)
  default = {
    prod = {
      ip       = "10.0.250.0/24"
      location = "eastus2"
    }

    dev = {
      ip       = "10.0.150.0/24"
      location = "westus2"
    }
  }
}

variable "num1" {
  default = 20
}

variable "num2" {
  default = 50
}

variable "num3" {
  default = 70
}