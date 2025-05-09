output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main_vpc.cidr_block
}

output "private_subnet_1" {
  description = "The ID of the private subnet 1"
  value       = aws_subnet.private_subnet_1.id
}

output "private_subnet_2" {
  description = "The ID of the private subnet 2"
  value       = aws_subnet.private_subnet_2.id
}

output "private_subnet_3" {
  description = "The ID of the private subnet 3"
  value       = aws_subnet.private_subnet_3.id
}

output "private_subnet_4" {
  description = "The ID of the private subnet 4"
  value       = aws_subnet.private_subnet_4.id
}

output "public_subnet_1" {
  description = "The ID of the public subnet 1"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
  description = "The ID of the public subnet 2"
  value       = aws_subnet.public_subnet_2.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.main_nat_gateway.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_route_table.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_route_table.id
}
