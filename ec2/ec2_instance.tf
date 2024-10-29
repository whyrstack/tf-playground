
resource "aws_eip" "this" {
  count = var.instance_public ? 1 : 0

  domain = "vpc"
}

resource "aws_eip_association" "this" {
  count = var.instance_public ? 1 : 0

  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this[0].id
}

resource "aws_instance" "this" {
  user_data = templatefile("${path.module}/init/user_data.sh", {
    instance_name = var.instance_name
  })

  ami           = var.ami
  instance_type = var.instance_type

  iam_instance_profile = aws_iam_instance_profile.this.name
  key_name             = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp2"
    volume_size           = 100
    encrypted             = true
    kms_key_id            = var.kms_key_id
    # device_name           = "/dev/sda1"
  }

  metadata_options {
    http_tokens   = "required" # IMDSv2
    http_endpoint = "enabled"  # Enable the metadata service
  }

  monitoring = true

  lifecycle {
    ignore_changes = [
      user_data
    ]
  }

  tags = {
    Name        = var.instance_name
    Terraform   = "true"
    Environment = "Production"
  }
}