variable "ssh-port" {
  default = "22"
}
variable "internet" {
  default = ["0.0.0.0/0"]
}
variable "outbound-port" {
  default     = "0"
}
variable "vpc_id" {
  description = "VPC ID"
}
variable "ingress_ports" {
  type        = list(number)
  default     = [80, 9966, 4200]
} 