# Load Balancer ARN
output "load_balancer_arn" {
  description = "The ARN of the internal load balancer"
  value       = aws_lb.internal.arn
}

# DNS Name for Load Balancer
output "load_balancer_dns_name" {
  description = "The DNS name of the internal load balancer"
  value       = aws_lb.internal.dns_name
}

# Target Group ARNs
output "go_service_target_group_arn" {
  description = "The ARN of the target group for the Go service"
  value       = aws_lb_target_group.go_service.arn
}

output "nodejs_service_target_group_arn" {
  description = "The ARN of the target group for the NodeJS service"
  value       = aws_lb_target_group.nodejs_service.arn
}

# Listener ARNs
output "go_service_listener_arn" {
  description = "The ARN of the listener for the Go service"
  value       = aws_lb_listener.go_service.arn
}

output "nodejs_service_listener_arn" {
  description = "The ARN of the listener for the NodeJS service"
  value       = aws_lb_listener.nodejs_service.arn
}