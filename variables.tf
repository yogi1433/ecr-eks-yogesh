# Variables
variable "cluster_name" {
  default = "yogi_eks-cluster"
}

variable "vpc_name" {
  default = "yogi_eks-vpc"
}

variable "subnet_names" {
  default = ["yogi_eks-public-subnet1", "yogi_eks-public-subnet2"]
}

variable "instance_types" {
  default = ["t3.medium"]
}

variable "desired_size" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "key" {
    default = "eks-manager"
}
variable "eks_ec2_instance_type" {
  default = "t2.micro"
}
