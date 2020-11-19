variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr_block" {
  description = "Range of IPv4 address for the VPC"
  default     = "10.1.0.0/16"
}

variable "az_count" {
  default = 2
}

variable "tagName" {
  default = "veloe"
}

variable "cluster-name" {
  default     = "veloe-eks"
  description = "Enter eks cluster name - example like eks-demo, eks-dev etc"
}

