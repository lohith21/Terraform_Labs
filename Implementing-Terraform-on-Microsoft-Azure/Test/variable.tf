variable "location" {
  type    = string
  default = "centralindia"
}

variable "rg_name" {
  type    = string
  default = "vNet_test"
}

variable "vnet_cidr_range" {
  type    = list(string)
  default = ["10.0.0.0/16", "192.168.0.0/16"]
}

variable "vnet_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR Block for Public Subnets in VPC"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "counts" {
  type        = number
  description = "Number of instances to create"
  default     = 2
}