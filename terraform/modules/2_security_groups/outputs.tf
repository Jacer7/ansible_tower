
output "ansible_security_group_id" {
  description = "The ID of the ALB Security Group"
  value       = aws_security_group.ansible_sg.id
}


output "ansible_security_group_name" {
  description = "The name of the ALB Security Group"
  value       = aws_security_group.ansible_sg.name
}


output "iam_instance_profile" {
  value = aws_iam_instance_profile.ec2_instance_connect_profile.name
  
}
