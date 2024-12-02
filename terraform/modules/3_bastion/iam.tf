# 1. IAM Role
resource "aws_iam_role" "ec2_instance_connect_role" {
  name               = var.bastion_iam_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# 2. IAM Policy
resource "aws_iam_policy" "ec2_instance_connect_policy" {
  name        = var.bastion_iam_role_policy
  description = "Policy for EC2 Instance Connect"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "ec2-instance-connect:SendSSHPublicKey",
        Resource = "arn:aws:ec2:*:*:instance/*"
      }
    ]
  })
}

# 3. Attach the Policy to the Role

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_instance_connect_role.name
  policy_arn = aws_iam_policy.ec2_instance_connect_policy.arn
}

# The instance profile links the IAM role to an EC2 instance.
# 4. IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_connect_profile" {
  # name = "ec2-instance-connect-profile"
  name = var.bastion_iam_instance_profile
  role = aws_iam_role.ec2_instance_connect_role.name
}
