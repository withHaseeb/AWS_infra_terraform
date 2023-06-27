resource "aws_internet_gateway" "example" {
  vpc_id = var.vpc_id

  tags = var.tags
  
}

 