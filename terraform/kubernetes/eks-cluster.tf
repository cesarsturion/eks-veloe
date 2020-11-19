# ## Crate EKS master security group
# resource "aws_security_group" "eks-sec-group-cluster" {
#   name        = "eks-sec-group-cluster"
#   description = "Cluster communication with worker nodes"
#   vpc_id      = data.aws_vpc.vpc.id

#   tags = {
#     "Name" = "eks-sec-group-cluster"
#   }
# }

# resource "aws_security_group_rule" "allow_all_egress" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-cluster.id
# }

# resource "aws_security_group_rule" "allow_all_ingress" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-cluster.id
# }

# resource "aws_security_group_rule" "allow_ssh" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-cluster.id
# }

# resource "aws_security_group_rule" "allow_https" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-cluster.id
# }

# resource "aws_security_group_rule" "allow_http" {
#   type              = "ingress"(eks-gudiao):
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-cluster.id
# }


#EKS Service
resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = aws_iam_role.eks-cluster-service-role.arn
  #role_arn = "arn:aws:iam::495964244270:role/eksServiceRole"

  vpc_config {
    security_group_ids = [data.aws_security_group.selected.id]
    subnet_ids         = data.aws_subnet_ids.public.ids
  }

  depends_on = [
    aws_nat_gateway.eks-nat-gw
  ]  

  tags = {
    "Name"                                      = var.cluster-name
  }


}