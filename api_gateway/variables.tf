variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "main-api"
}

variable "vpc_link_name" {
  description = "The name of the VPC Link"
  type        = string
  default     = "main-vpc-link"
}

variable "go_service_path" {
  description = "The path for the Go service"
  type        = string
  default     = "go-service"
}

variable "nodejs_service_path" {
  description = "The path for the NodeJS service"
  type        = string
  default     = "nodejs-service"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Environment = "production"
    Project     = "main-api"
  }
}

variable "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  type        = string
}

variable "load_balancer_arn" {
  description = "The ARN of the load balancer"
  type        = string
}