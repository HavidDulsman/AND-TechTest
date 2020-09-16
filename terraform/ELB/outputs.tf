output "elb_id" {
  value = aws_elb.techTest-ELB.id
}

output "elb_ip" {
  value = aws_elb.techTest-ELB.dns_name
}