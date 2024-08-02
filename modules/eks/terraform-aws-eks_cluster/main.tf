resource "aws_eks_cluster" "yyk-eks_cluster" {
  name     = "example"
  role_arn = aws_iam_role.iam_role_for_eks-cluster.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    #aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}

#eks가 특정 role을 assume하도록 하는 role
#이걸 eks iam role에 할당해야 한다.
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service" 
      identifiers = ["eks.amazonaws.com"] #주체는 eks
    }

    actions = ["sts:AssumeRole"] #eks가 특정 role을 가정(asuume)하도록 허용한다.
  }
}

#eks iam role 생성. 위에 cluster에서 eks의 role_arn을 이걸로 설정함
resource "aws_iam_role" "iam_role_for_eks-cluster" {
  name               = "eks-cluster-example"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

#iam role과 policy를 연결
resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role_for_eks-cluster.name
}

#security group과 관련한 role_policy_attachment도 있으니 나중에 필요하면 문서 참고
#resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#  role       = aws_iam_role.example.name
#}
