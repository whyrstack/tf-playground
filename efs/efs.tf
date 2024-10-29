resource "aws_efs_file_system" "this" {
  creation_token = "my-efs-token"

  encrypted  = true
  kms_key_id = var.kms_key_id

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name        = "my-efs-share"
    Terraform   = "true"
    Environment = "Production"
  }
}

resource "aws_efs_access_point" "this" {
  file_system_id = aws_efs_file_system.this.id

  posix_user {
    uid = 1000
    gid = 1000
  }

  root_directory {
    path = "/root-directory"
    creation_info {
      owner_uid   = 1000
      owner_gid   = 1000
      permissions = "755"
    }
  }

  tags = {
    Name        = "my-efs-ap"
    Terraform   = "true"
    Environment = "Production"
  }
}

resource "aws_efs_mount_target" "this" {
  for_each        = toset(var.subnet_ids)
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  security_groups = [aws_security_group.this.id]
}

# Create an EFS filesystem
resource "aws_efs_file_system" "example" {
  creation_token = "example-efs-token"

  tags = {
    Name = "example-efs"
  }
}

data "aws_caller_identity" "current" {}

# EFS Filesystem Policy
resource "aws_efs_file_system_policy" "this" {
  file_system_id = aws_efs_file_system.this.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "efs-policy-wizard-0e2fe4ea-8533-4afb-be9e-b0b2854d84a7",
    "Statement": [
        {
            "Sid": "efs-statement-64f97de8-7a08-42d1-9b65-977da933e999",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "elasticfilesystem:ClientMount",
            "Resource": "arn:aws:elasticfilesystem:eu-central-1:248189912684:file-system/fs-08380beaa6c7d1ab5",
            "Condition": {
                "Bool": {
                    "elasticfilesystem:AccessedViaMountTarget": "true"
                }
            }
        },
        {
            "Sid": "efs-statement-20dedb97-fb36-4602-8683-d5b697d7de6b",
            "Effect": "Deny",
            "Principal": {
                "AWS": "*"
            },
            "Action": "*",
            "Resource": "arn:aws:elasticfilesystem:eu-central-1:248189912684:file-system/fs-08380beaa6c7d1ab5",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        },
        {
            "Sid": "efs-statement-c0a73e9f-83be-47bf-ae29-7db1635ba1af",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::248189912684:role/mail-ec2-role"
            },
            "Action": [
                "elasticfilesystem:ClientRootAccess",
                "elasticfilesystem:ClientWrite",
                "elasticfilesystem:ClientMount"
            ],
            "Resource": "arn:aws:elasticfilesystem:eu-central-1:248189912684:file-system/fs-08380beaa6c7d1ab5"
        }
    ]
}
EOF
}