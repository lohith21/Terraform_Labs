variable "vnet_cidr_block" {
  type        = list(string)
  description = "CIDR Block for vNet"
  default     = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
}

variable "vnet_cidr_subnet_dev" {
  type        = list(string)
  description = "CIDR subnet block for vNet dev"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vnet_cidr_subnet_uat" {
  type        = list(string)
  description = "CIDR subnet block for vNet dev"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vnet_cidr_subnet_prod" {
  type        = list(string)
  description = "CIDR subnet block for vNet dev"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "vnet_cidr_range_count" {
  type        = number
  description = "Number of Address Space to create."
  default     = 3
}

variable "vnet_subnet_count" {
  type        = number
  description = "Number of subnets to create."
  default     = 2
}

variable "subnet_names" {
  type        = list(string)
  description = "Name of subnets"
  default     = ["sales", "accounts"]
}

variable "vnet_environment" {
  type        = list(string)
  description = "Name of subnets"
  default     = ["vnet-dev", "vnet-uat", "vnet-prod"]
}


