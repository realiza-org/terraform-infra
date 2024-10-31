provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./vpc"
}

module "load_balancer" {
  source         = "./load_balancer"
  vpc_id         = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet_id
}

module "ecs" {
  source         = "./ecs"
  vpc_id         = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet_id
  nodejs_service_lb_target_group_arn = module.load_balancer.nodejs_service_lb_target_group_arn
  go_service_lb_target_group_arn     = module.load_balancer.go_service_lb_target_group_arn
}

module "api_gateway" {
  source            = "./api_gateway"
  load_balancer_dns = module.load_balancer.load_balancer_dns
  load_balancer_arn = module.load_balancer.load_balancer_arn
}