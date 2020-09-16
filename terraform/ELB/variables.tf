variable "vpc_id" {
}
variable "SegGrp_elb_id" {
  description = "security group ID"
}
variable "subnet1" {
}
variable "subnet2" {
}
variable "internet" {
  default = ["0.0.0.0/0"]
}