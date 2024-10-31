output "api_gateway_id" {
  value = aws_api_gateway_rest_api.main.id
}

output "vpc_link_id" {
  value = aws_api_gateway_vpc_link.main.id
}