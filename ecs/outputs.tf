output "ecs_cluster_id" {
  value       = aws_ecs_cluster.main.id
  description = "ID do cluster ECS"
}

output "go_service_task_definition_arn" {
  value       = aws_ecs_task_definition.go_service.arn
  description = "ARN da definição de tarefa do serviço Go"
}

output "nodejs_service_task_definition_arn" {
  value       = aws_ecs_task_definition.nodejs_service.arn
  description = "ARN da definição de tarefa do serviço NodeJS"
}

output "go_service_id" {
  value       = aws_ecs_service.go_service.id
  description = "ID do serviço ECS para o serviço Go"
}

output "nodejs_service_id" {
  value       = aws_ecs_service.nodejs_service.id
  description = "ID do serviço ECS para o serviço NodeJS"
}

output "ecs_service_security_group_id" {
  value       = aws_security_group.ecs_service.id
  description = "ID do grupo de segurança do serviço ECS"
}