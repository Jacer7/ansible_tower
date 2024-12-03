output "ansible_security_group_id" {
  value = module.security_groups.ansible_security_group_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "bastion_pemkey" {
  value     = module.bastion_host.private_key
  sensitive = true
}

output "bastion_public_ip_first" {
  value = module.bastion_host.bastion_public_ip_first
}

output "bastion_public_ip_second" {
  value = module.bastion_host.bastion_public_ip_second
}
output "bastion_public_ip_third" {
  value = module.bastion_host.bastion_public_ip_third
}
output "ansible_master_public_ip" {
  value = module.bastion_host.ansible_master_public_ip
}
