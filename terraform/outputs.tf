output "ansible_security_group_id" {
  value = module.security_groups.ansible_security_group_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}


output "bastion_public_ip_first" {
  value = module.ansible_slave.bastion_public_ip_first
}

output "bastion_public_ip_second" {
  value = module.ansible_slave.bastion_public_ip_second
}
output "bastion_public_ip_third" {
  value = module.ansible_slave.bastion_public_ip_third
}
output "ansible_master_public_ip" {
  value = module.ansible_master.ansible_master_public_ip
}

output "ansible_master_pemkey" {
  value     = module.ansible_master.private_key
  sensitive = true
}

output "ansible_slave_pemkey" {
  value     = module.ansible_slave.ansible_slave_pemkey
  sensitive = true
}