locals {
  common_tags = {
    Organization    = upper("Everesto")
    Env-Type        = upper(var.env_type)
    ManagedBy       = upper("Terraform")
    BusinessService = upper("Everesto-Coffee")
    Application     = upper("Service")

  }
}

#########################################################################################
###################################### Root Module ######################################
#########################################################################################
module "vpc" {
  source = "./modules/1_vpc"
  vpc_id = var.vpc_id

}

module "security_groups" {
  source = "./modules/2_security_groups"

  vpc_id = var.vpc_id
}

module "ansible_master" {
  source = "./modules/3_ansible_master"

  bastion_ami                  = var.bastion_ami
  instacne_type                = var.instacne_type
  public_subnet                = module.vpc.public_subnet_ids[0]
  bastion_security_groups      = [module.security_groups.ansible_security_group_id] # coming from the security group module
  key_name                     = lower(format("%s_%s_ansible_master_key", local.common_tags["Application"], var.env_type))
  bastion_iam_role             = lower(format("%s_%s_bastion_iam_role", local.common_tags["Application"], var.env_type))
  bastion_iam_role_policy      = lower(format("%s_%s_bastion_role_policy", local.common_tags["Application"], var.env_type))
  bastion_iam_instance_profile = lower(format("%s_%s_bastion_instance_profile", local.common_tags["Application"], var.env_type))

  # # Pass backend server private key and IP to bastion_host module
  # backend_private_key      = module.backend_server.backend_private_key
  # backend_private_ip       = module.backend_server.backend_private_ip

  tags = merge(
    local.common_tags,
    {
      Name = upper(format("bastion-host-%s-%s", var.env_type, var.components["Infra"]))

    }
  )
}


module "ansible_slave" {
  source = "./modules/3_ansible_slave"

  bastion_ami                  = var.bastion_ami
  instacne_type                = var.instacne_type
  public_subnet                = module.vpc.public_subnet_ids[0]
  bastion_security_groups      = [module.security_groups.ansible_security_group_id] # coming from the security group module
  key_name                     = lower(format("%s_%s_ansible_slave_key", local.common_tags["Application"], var.env_type))
  bastion_iam_role             = lower(format("%s_%s_bastion_iam_role", local.common_tags["Application"], var.env_type))
  bastion_iam_role_policy      = lower(format("%s_%s_bastion_role_policy", local.common_tags["Application"], var.env_type))
  bastion_iam_instance_profile = lower(format("%s_%s_bastion_instance_profile", local.common_tags["Application"], var.env_type))

  tags = merge(
    local.common_tags,
    {
      Name = upper(format("bastion-host-%s-%s", var.env_type, var.components["Infra"]))

    }
  )
}


# module "backend_server" {
#   source = "./modules/4_backend_server"

#   backend_ami             = var.backend_ami
#   backend_instacne_type   = var.backend_instance_type
#   private_subnet          = module.vpc.private_subnets[0]
#   private_server_sg       = [module.security_groups.backend_security_group_id] # comes from the Output of the Security Group
#   private_server_key_name = lower(format("%s_%s_backend_key", local.common_tags["Application"], var.env_type))

#   backend_iam_role        = lower(format("%s_%s_backend_iam_role", local.common_tags["Application"], var.env_type))
#   backend_iam_role_policy = lower(format("%s_%s_backend_role_policy", local.common_tags["Application"], var.env_type))
#   backend_iam_instance_profile = lower(format("%s_%s_backend_instance_profile", local.common_tags["Application"], var.env_type))
#   db_password             = var.db_password
#   db_instance_address     = module.db.db_instance_endpoint
#   tags = merge(

#     local.common_tags,
#     {
#       Name = upper(format("backend-server-%s-%s", var.env_type, var.components["Infra"]))
#     }
#   )
# }


# module "alb" {
#   source = "./modules/5_alb"

#   alb_name              = lower(format("alb-%s-%s", var.env_type, var.components["Infra"]))
#   vpc_id                = module.vpc.vpc_id
#   public_subnets        = module.vpc.public_subnets
#   alb_security_group_id = [module.security_groups.alb_security_group_id] # comes from the Output of the Security Group
#   target_instance_backend = module.backend_server.backend_instance_id
#   # TODO: We need to attach ec2 for frontend server to ALB
#   # TODO: There is no frontend app so left unattached
#   # TODO: Or both app can be (Backend and Frontend) at same Ec2 and running in different Ports as well.
#   tags = merge(
#     local.common_tags,
#     {
#       Name = upper(format("alb-%s-%s", var.env_type, var.components["Infra"]))
#     }
#   )

#   tags_http = merge(
#     local.common_tags,
#     {
#       Name = upper(format("alb-listener-http-%s-%s", var.env_type, var.components["Infra"]))
#     }
#   )

#     tags_https = merge(
#     local.common_tags,
#     {
#       Name = upper(format("alb-listener-https-%s-%s", var.env_type, var.components["Infra"]))
#     }
#   )

#     tags_backend_target_group = merge(
#     local.common_tags,
#     {
#       Name = upper(format("alb-tg-%s-%s", var.env_type, var.components["Infra"]))
#     }
#   )
# }

# module "db" {
#   source = "./modules/6_db"
#   db_subnet_group_name = lower(format("db-subnet-group-%s-%s", var.env_type, var.components["Infra"]))
#   db_private_subnet_ids = module.vpc.private_subnets
#   db_identifier           = lower(format("db-%s-%s", var.env_type, var.components["Infra"]))
#   db_password             = var.db_password
#   vpc_id                  = module.vpc.vpc_id
#   db_sg                   = [module.security_groups.db_security_group_id]

#   tags = merge(
#     local.common_tags,
#     {
#       Name = upper(format("db-%s-%s", var.env_type, var.components["Infra"]))
#     }
#   )
# }
