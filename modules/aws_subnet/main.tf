resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  availability_zone = var.availability_zone

  tags = var.tags
}


output "subnet_id" {
  value = aws_subnet.main.id
  
}
