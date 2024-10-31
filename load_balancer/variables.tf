variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnet" {
  description = "ID do subnet privado"
  type        = string
}

variable "lb_internal_name" {
  default = "internal-lb"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "development"
}