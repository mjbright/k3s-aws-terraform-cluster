#variable "AWS_ACCESS_KEY" { } 
#variable "AWS_SECRET_KEY" { }

variable "region" {
  type        = string
  default     = "us-west-1"
  description = "AWS Zone"
}

module "data_aws_ams" {
  #source = "../data-aws-ami"
  source        = "git::https://github.com/mjbright/terraform-modules.git//modules/data-aws-ami?ref=v0.9.2"

  #ami_family = var.ami_family
  ami_family = "ubuntu_2004"
}

module "k3s_cluster" {
  AWS_REGION          = var.region

  environment         = "staging"

  ami                 = module.data_aws_ams.ami

  #my_public_ip_cidr   = "<change_me>"
  my_public_ip_cidr   = "0.0.0.0/0"
  vpc_id              = aws_default_vpc.default.id

  vpc_subnets         = data.aws_subnet.default.*.id
  vpc_subnet_cidr     = aws_default_vpc.default.cidr_block

  cluster_name        = "k3s-cluster"

  # Generate using: ./gen_random_token.sh:
  k3s_token           = var.k3s_token

  source              = "./k3s_cluster/"
}


