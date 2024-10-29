resource "aws_security_group" "this" {
  name        = "${var.instance_name}-sg"
  description = "Security group for mail server allowing SMTP, IMAP, POP3 inbound and all egress traffic"
  vpc_id      = var.vpc_id

  # Allow all outbound traffic (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow the following inbound (ingress)
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name        = "${var.instance_name}-sg"
    Terraform   = "true"
    Environment = "Production"
  }
}