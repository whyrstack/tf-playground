module "vpc" {
  source   = "./vpc"
  vpc_name = var.vpc_name

  vpc_cidr_block = var.vpc_cidr_block

  cidr_private_subnet_1 = var.cidr_private_subnet_1
  az_private_subnet_1   = var.az_private_subnet_1

  cidr_private_subnet_2 = var.cidr_private_subnet_2
  az_private_subnet_2   = var.az_private_subnet_2

  cidr_public_subnet_1 = var.cidr_public_subnet_1
  az_public_subnet_1   = var.az_public_subnet_1

  cidr_public_subnet_2 = var.cidr_public_subnet_2
  az_public_subnet_2   = var.az_public_subnet_2
}

module "kms" {
  source                  = "./kms"
  deletion_window_in_days = 30
}

module "instance" {
  source               = "./ec2"
  depends_on           = [module.vpc, module.kms]
  instance_public      = true # assign static eip 
  instance_name        = var.instance_name
  instance_domain_name = var.instance_domain_name
  instance_type        = "t2.micro"
  key_name             = var.key_name
  ami                  = data.aws_ami.ubuntu.id
  vpc_id               = module.vpc.vpc_id
  subnet_id            = module.vpc.subnet_public_1
  ingress_ports        = var.ingress_ports # ["22", "80", "443"]
  kms_key_id           = module.kms.kms_arn
  iam_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess"
  ]
}

# module "efs" {
#   depends_on    = [module.vpc, module.kms]
#   source        = "./efs"
#   instance_name = var.instance_name # EC2 instance name because IAM role gets assigned that provides permission in EFS policy
#   vpc_id        = module.vpc.vpc_id
#   subnet_ids    = [module.vpc.subnet_public_1, module.vpc.subnet_public_2]
#   kms_key_id    = module.kms.kms_arn
# }