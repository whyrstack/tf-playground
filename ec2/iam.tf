data "aws_caller_identity" "current" {}

resource "aws_iam_role" "this" {
  name               = "${var.instance_name}-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
  }]
}
EOF
  tags = {
    Terraform   = "true"
    Environment = "Production"
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.iam_policy_arns)

  policy_arn = each.value
  role       = aws_iam_role.this.name
}

# Create an IAM Instance Profile
resource "aws_iam_instance_profile" "this" {
  name = "${var.instance_name}-ec2_instance_profile"
  role = aws_iam_role.this.name
}