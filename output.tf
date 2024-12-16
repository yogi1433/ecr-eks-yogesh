# Outputs
output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.node_group_role.arn
}

output "subnet_ids" {
  value = aws_subnet.eks_public_subnets[*].id
}

output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

