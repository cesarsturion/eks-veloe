# ## Crate EKS Nodes security group
# resource "aws_security_group" "eks-sec-group-nodes" {
#   name        = "eks-sec-group-nodes"
#   description = "Security group for all nodes in the cluster"
#   vpc_id      = data.aws_vpc.vpc.id

#   tags = {
#     "Name"                   = "eks-sec-group-nodes"
#     "kubernetes.io/cluster/" = "${var.cluster-name}"
#   }
# }

# resource "aws_security_group_rule" "allow_all_nodes_egress" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-nodes.id
# }

# resource "aws_security_group_rule" "allow_all_nodes_ingress" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-nodes.id
# }

# resource "aws_security_group_rule" "allow_ssh_nodes" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-nodes.id
# }

# resource "aws_security_group_rule" "allow_com_nodes_cluster" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.eks-sec-group-nodes.id
# }

# resource "aws_security_group_rule" "demo-cluster-ingress-node-https" {
#   description              = "Allow pods to communicate with the cluster API Server"
#   from_port                = 443
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.eks-sec-group-cluster.id
#   source_security_group_id = aws_security_group.eks-sec-group-nodes.id
#   to_port                  = 443
#   type                     = "ingress"
# }


resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-veloe-nodes"
  node_role_arn   = aws_iam_role.eks-node-service-role.arn
  #node_role_arn   = "arn:aws:iam::495964244270:role/eksNodeInstanceRole"  
  subnet_ids      = data.aws_subnet_ids.public.ids


  scaling_config {
    desired_size = 3
    max_size     = 10
    min_size     = 2
  }

  remote_access {
    ec2_ssh_key               = "veloeEks"
    source_security_group_ids = [data.aws_security_group.selected.id]
  }  

  tags = {
    "Name" = "eks_node_group"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }

}