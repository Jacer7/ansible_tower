##########################################
# Root Module Variables
##########################################
# -------------------
# From Environment
# -------------------

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "env_type" {
  type        = string
  description = "Environment type"
}

# -------------------
# From Shared Only
# -------------------
variable "components" {
  type        = map(string)
  description = "Components from Shared"
}

##########################################
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
##########################################
variable "bastion_ami" {
  type        = string
  description = "Bastion Host AMI"
}

variable "instacne_type" {
  type        = string
  description = "Type of the instance"
  default     = "t2.micro"

}