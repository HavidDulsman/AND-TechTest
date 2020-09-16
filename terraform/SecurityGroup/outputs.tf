output "SegGrp_id" {
  value = aws_security_group.techTest-SG.id
}

output "SegGrp_elb_id" {
  value = aws_security_group.techTest-SG-elb.id
}