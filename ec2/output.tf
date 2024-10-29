output "instance_public_ip" {
  value = aws_eip.this[0].public_ip
}