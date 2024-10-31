# Define ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
  tags = {
    Name = var.ecs_cluster_name
  }
}

# Define ECS Task Definition for Go Service
resource "aws_ecs_task_definition" "go_service" {
  family                   = "go-service-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "go-service-container"
      image = var.go_service_image
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

# Define ECS Task Definition for NodeJS Service
resource "aws_ecs_task_definition" "nodejs_service" {
  family                   = "nodejs-service-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "nodejs-service-container"
      image = var.nodejs_service_image
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

# Define ECS Service for Go Service
resource "aws_ecs_service" "go_service" {
  name            = "go-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.go_service.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.private_subnet]
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.go_service.arn
    container_name   = "go-service-container"
    container_port   = 8080
  }
  
  tags = {
    Name = "go-service"
  }
}

# Define ECS Service for NodeJS Service
resource "aws_ecs_service" "nodejs_service" {
  name            = "nodejs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nodejs_service.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.private_subnet]
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nodejs_service.arn
    container_name   = "nodejs-service-container"
    container_port   = 3000
  }
  tags = {
    Name = "nodejs-service"
  }
}

# Define Security Group for ECS Service
resource "aws_security_group" "ecs_service" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ecs-service-sg"
  }
}