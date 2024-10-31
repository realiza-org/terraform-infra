output "load_balancer_arn" {
  value = aws_lb.internal.arn
}

output "load_balancer_dns" {
  value = aws_lb.internal.dns_name
}

output "go_service_lb_target_group_arn" {
  value       = aws_lb_target_group.go_service.arn
  description = "ARN do grupo de destino do balanceador de carga para o serviço Go"
}

output "nodejs_service_lb_target_group_arn" {
  value       = aws_lb_target_group.nodejs_service.arn
  description = "ARN do grupo de destino do balanceador de carga para o serviço NodeJS"
}
