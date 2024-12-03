variable "vpc_id" {
    type        = string
    description = "VPC ID"
}

# # IAM
variable "bastion_iam_role" {
    type        = string
    description = "Bastion Host IAM Instance Profile"
}

variable "bastion_iam_role_policy" {
    type        = string
    description = "Bastion Host IAM Role"
}

variable "bastion_iam_instance_profile" {
    type        = string
    description = "Bastion Host IAM Instance Profile"
}

