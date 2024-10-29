variable "instance_name" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ingress_ports" {
  type    = list(string)
  default = []
}

variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "cidr_private_subnet_1" {
  type = string
}

variable "cidr_public_subnet_1" {
  type = string
}

variable "cidr_private_subnet_2" {
  type = string
}

variable "cidr_public_subnet_2" {
  type = string
}

variable "az_private_subnet_1" {
  type = string
}

variable "az_private_subnet_2" {
  type = string
}

variable "az_public_subnet_1" {
  type = string
}

variable "az_public_subnet_2" {
  type = string
}