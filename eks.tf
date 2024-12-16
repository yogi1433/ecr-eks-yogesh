# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks_public_subnets[*].id
  }

  tags = {
    Name = var.cluster_name
  }
}

# Security Group for EKS Node Group
resource "aws_security_group" "eks_node_group_sg" {
  name        = "yogi_eks-node-group-sg"
  description = "Security group for EKS Node Group instances"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow all traffic within the security group"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    self             = true
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "yogi_eks-node-group-sg"
  }
}

# EKS Node Group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "yogi_eks-node-group"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = aws_subnet.eks_public_subnets[*].id

  remote_access {
    ec2_ssh_key               = var.key  # Specify your key pair name
    source_security_group_ids = [aws_security_group.eks_node_group_sg.id]
  }

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = var.instance_types

  tags = {
    Name = "yogi_eks-node-group"
  }
}
