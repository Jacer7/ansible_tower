output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

output "bastion_public_ip_first" {
  value       = aws_instance.bastion[0].public_ip
  description = "Public IP of the first bastion instance"
}

output "bastion_public_ip_second" {
  value       = aws_instance.bastion[1].public_ip
  description = "Public IP of the second bastion instance"
}

output "bastion_public_ip_third" {
  value       = aws_instance.bastion[2].public_ip
  description = "Public IP of the third bastion instance"
}
