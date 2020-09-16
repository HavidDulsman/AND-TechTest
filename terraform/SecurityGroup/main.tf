resource "aws_security_group" "techTest-SG" {
  name        = "techTest-SG"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      protocol    = "tcp"
      to_port     = port.value
      cidr_blocks = var.internet
    }
  }
  egress {
    from_port   = var.outbound-port
    protocol    = "-1"
    to_port     = var.outbound-port
    cidr_blocks = var.internet
  }
}

resource "aws_security_group" "techTest-SG-elb" {
  name        = "elb_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}