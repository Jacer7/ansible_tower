# #################################
# # Bastion Instance Variables
# #################################
variable "bastion_ami" {
    type        = string
    description = "Ansible Master Host AMI"
}

variable "instacne_type" {
    type        = string
    description = "Type of the instance"
    default = "t2.micro"
}

variable "key_name" {
    type        = string
    description = "Ansible Master ssh Key Name"
}

variable "tags" {
    description = "Tags to apply to resources"
    type        = map(string)
    default     = {}
  
}

variable "public_subnet" {
    type        = string
    description = "Public Subnet"
}

variable "bastion_security_groups" {
    type        = list(string)
    description = "Bastion Host Security Groups"
}

# IAM
variable "common_iam_instance_profile" {
    type        = string
    description = "Bastion Host IAM Instance Profile"
}

# variable "bastion_iam_role" {
#     type        = string
#     description = "Bastion Host IAM Instance Profile"
# }

# variable "bastion_iam_role_policy" {
#     type        = string
#     description = "Bastion Host IAM Role"
# }

# variable "bastion_iam_instance_profile" {
#     type        = string
#     description = "Bastion Host IAM Instance Profile"
  
# }

