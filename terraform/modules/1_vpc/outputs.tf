# Output VPC ID
output "vpc_id" {
  value = var.vpc_id
}

# Output all subnet IDs
output "subnet_ids" {
  value = data.aws_subnets.all_subnets.ids
}

# Output public subnet IDs (where map_public_ip_on_launch is true)
output "public_subnet_ids" {
  value = [
    for subnet in data.aws_subnet.subnet_details :
    subnet.id
    if subnet.map_public_ip_on_launch == true
  ]
}

# Output private subnet IDs (where map_public_ip_on_launch is false)
output "private_subnet_ids" {
  value = [
    for subnet in data.aws_subnet.subnet_details :
    subnet.id
    if subnet.map_public_ip_on_launch == false
  ]
}
