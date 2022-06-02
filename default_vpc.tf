
# The aws_default_vpc resource behaves differently from normal resources in that
# if a default VPC exists, Terraform does not create this resource,
# but instead "adopts" it into management

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

data "aws_subnet" "default" {
  #for_each = toset(data.aws_subnets.example.ids)
  #id       = each.value
}



