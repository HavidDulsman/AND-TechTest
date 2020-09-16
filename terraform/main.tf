provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  version                 = "~> 2.0"
}

module "vpc_deployment" {
  source = "./VPC"
}

module "security_group_deployment" {
  source = "./SecurityGroup"
  vpc_id = module.vpc_deployment.vpc_id
}

module "launch_configuration" {
  source = "./LaunchConfiguration"
  SegGrp_id = module.security_group_deployment.SegGrp_id
}

module "elastic_load_balancer" {
  source = "./ELB"
  vpc_id = module.vpc_deployment.vpc_id
  SegGrp_elb_id = module.security_group_deployment.SegGrp_elb_id
  subnet1 = module.vpc_deployment.subnet1
  subnet2 = module.vpc_deployment.subnet2
}

module "autoscaling_group" {
  source = "./Autoscaling"
  elb_id = module.elastic_load_balancer.elb_id
  subnet1 = module.vpc_deployment.subnet1
  subnet2 = module.vpc_deployment.subnet2
  launch_configuration_name = module.launch_configuration.launch_configuration_name
}