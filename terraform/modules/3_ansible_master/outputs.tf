output "private_key" {
  value     = tls_private_key.ansible_master_key.private_key_pem
  sensitive = true
}

output "ansible_master_public_ip" {
  value = aws_instance.ansible_master.public_ip
}
