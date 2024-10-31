variable "ecs_cluster_name" {
  description = "Nome do cluster ECS"
  type        = string
  default     = "main-cluster"
}

variable "ecs_desired_count" {
  description = "Número desejado de instâncias ECS"
  type        = number
  default     = 2
}

variable "go_service_image" {
  description = "Imagem Docker para o serviço Go"
  type        = string
  default     = "joaowillamy/go-service:latest"
}

variable "nodejs_service_image" {
  description = "Imagem Docker para o serviço NodeJS"
  type        = string
  default     = "nodejs-service-image"
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnet" {
  description = "ID do subnet privado"
  type        = string
}
