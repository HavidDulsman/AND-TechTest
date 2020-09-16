resource "aws_launch_configuration" "techTest-lc" {

  image_id = var.AMI
  instance_type = "t2.micro"

  security_groups = [var.SegGrp_id]
  associate_public_ip_address = true

  user_data = <<USER_DATA
#!/bin/bash
sudo apt-get update
sudo apt-get -y install nginx 
service nginx start
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}