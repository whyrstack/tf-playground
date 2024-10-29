variable "instance_name" {
  type = string
}

variable "instance_domain_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_public" {
  type = bool
}

variable "vpc_id" {
  type = string
}

variable "kms_key_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ami" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ingress_ports" {
  type    = list(string)
  default = []
}

variable "iam_policy_arns" {
  type    = list(string)
  default = []
}