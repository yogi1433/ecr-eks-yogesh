# EC2 Instance for Cluster Management
resource "aws_instance" "eks_management_instance" {
  ami                    = data.aws_ami.ubuntu.id  # Use the latest Ubuntu AMI
  instance_type          = var.eks_ec2_instance_type
  subnet_id              = aws_subnet.eks_public_subnets[0].id
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.eks_manager_instance_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "yogi_eks-management-instance"
  }

  user_data = file("app.sh")  # Ensure the script exists and is executable
}

# Get Latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu-*-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]  # Canonical's AWS account ID
}

# Security Group for EKS Management Instance
resource "aws_security_group" "eks_manager_instance_sg" {
  name        = "yogi_ec2_eks_security_group"
  description = "Allow ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    description      = "Allow SSH and all TCP traffic"
    from_port        = 22
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
