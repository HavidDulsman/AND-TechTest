output "vpc_id" {
  value = aws_vpc.techTest-VPC.id
}
output "subnet1" {
  value = aws_subnet.techTest-subnet1.id
}
output "subnet2" {
  value = aws_subnet.techTest-subnet2.id
}