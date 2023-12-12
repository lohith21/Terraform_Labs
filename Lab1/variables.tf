variable "usernumber" {
  type = number
  default = "21"
}

variable "elb_name" {
  type = string
}

variable "az" {
  type = list
}

variable "timeout" {
  type = number
}

variable "lb_port" {
  type = number
}

variable "lb_protocol" {
  type = string
}

variable "health_threshold" {
  type = number
}
