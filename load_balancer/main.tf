# Define Internal Load Balancer
resource "aws_lb" "internal" {
  name               = "load-balance-internal"
  internal           = true
  load_balancer_type = "application"
  subnets            = [var.private_subnet]
}

# Define Target Group for Go Service
resource "aws_lb_target_group" "go_service" {
  name     = "go-service-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health-orders"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Define Target Group for NodeJS Service
resource "aws_lb_target_group" "nodejs_service" {
  name     = "nodejs-service-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health-posts"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Define Load Balancer Listener for Go Service
resource "aws_lb_listener" "go_service" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.go_service.arn
  }
}

# Define Load Balancer Listener for NodeJS Service
resource "aws_lb_listener" "nodejs_service" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nodejs_service.arn
  }
}

# Listener Rule for Go Service - Routing `/orders` path to Go Service Target Group
resource "aws_lb_listener_rule" "go_service_rule" {
  listener_arn = aws_lb_listener.go_service.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.go_service.arn
  }

  condition {
    path_pattern {
      values = ["/orders*"]
    }
  }
}

# Listener Rule for NodeJS Service - Routing `/posts` path to NodeJS Service Target Group
resource "aws_lb_listener_rule" "nodejs_service_rule" {
  listener_arn = aws_lb_listener.nodejs_service.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nodejs_service.arn
  }

  condition {
    path_pattern {
      values = ["/posts*"]
    }
  }
}