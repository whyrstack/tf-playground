output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "subnet_public_1" {
  value = aws_subnet.public-1.id
}

output "subnet_public_2" {
  value = aws_subnet.public-2.id
}

output "subnet_private_1" {
  value = aws_subnet.private-1.id
}

output "subnet_private_2" {
  value = aws_subnet.private-2.id
}

