
# Fetch all subnets in the given VPC
data "aws_subnets" "all_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Fetch details for each subnet
data "aws_subnet" "subnet_details" {
  for_each = toset(data.aws_subnets.all_subnets.ids)
  id       = each.value
}
