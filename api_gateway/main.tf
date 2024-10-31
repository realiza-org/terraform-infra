# Define API Gateway
resource "aws_api_gateway_rest_api" "main" {
  name        = "main-api"
  description = "Main API Gateway for Go and Node.js services"
}

# Define VPC Link for Load Balancer
resource "aws_api_gateway_vpc_link" "main" {
  name        = "main-vpc-link"
  target_arns = [var.load_balancer_arn]
}

# Define API Gateway Resource for Go Service
resource "aws_api_gateway_resource" "go_service" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "go-service"
}

# Define API Gateway Resource for NodeJS Service
resource "aws_api_gateway_resource" "nodejs_service" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "nodejs-service"
}

# Define API Gateway Method for Go Service
resource "aws_api_gateway_method" "go_service_method" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.go_service.id
  http_method   = "GET"
  authorization = "NONE"
}

# Define API Gateway Method for NodeJS Service
resource "aws_api_gateway_method" "nodejs_service_method" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.nodejs_service.id
  http_method   = "GET"
  authorization = "NONE"
}

# Define API Gateway Integration with VPC Link for Go Service
resource "aws_api_gateway_integration" "go_service_integration" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.go_service.id
  http_method             = aws_api_gateway_method.go_service_method.http_method
  type                    = "HTTP_PROXY"
  uri                     = var.load_balancer_dns
  integration_http_method = "GET"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.main.id
}

# Define API Gateway Integration with VPC Link for NodeJS Service
resource "aws_api_gateway_integration" "nodejs_service_integration" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.nodejs_service.id
  http_method             = aws_api_gateway_method.nodejs_service_method.http_method
  type                    = "HTTP_PROXY"
  uri                     = var.load_balancer_dns
  integration_http_method = "GET"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.main.id
}

# Deploy API Gateway
resource "aws_api_gateway_deployment" "main" {
  depends_on = [
    aws_api_gateway_integration.go_service_integration,
    aws_api_gateway_integration.nodejs_service_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = "prod"
}