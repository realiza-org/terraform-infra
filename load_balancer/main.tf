# Define Internal Load Balancer
resource "aws_lb" "internal" {
  name               = "internal-lb"
  internal           = true
  load_balancer_type = "application"
  subnets            = [aws_subnet.private.id]

  tags = {
    Name        = "internal-lb"
    Environment = var.environment
  }
}

# Define Target Group for Go Service
resource "aws_lb_target_group" "go_service" {
  name     = "go-service-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "go-service-tg"
    Environment = var.environment
  }
}

# Define Target Group for NodeJS Service
resource "aws_lb_target_group" "nodejs_service" {
  name     = "nodejs-service-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "nodejs-service-tg"
    Environment = var.environment
  }
}

# Define Load Balancer Listener for Go Service
resource "aws_lb_listener" "go_service_listener" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 8080
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.go_service.arn
  }

  tags = {
    Name        = "go-service-listener"
    Environment = var.environment
  }
}

# Define Load Balancer Listener for NodeJS Service
resource "aws_lb_listener" "nodejs_service_listener" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 3000
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nodejs_service.arn
  }

  tags = {
    Name        = "nodejs-service-listener"
    Environment = var.environment
  }
}