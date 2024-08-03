resource "aws_eks_cluster" "yyk-eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.iam_role_for_eks-cluster.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    #aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.attach_eks_custom_policy,
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




#사용자 정의 IAM policy 생성
#노드 그룹을 확인할 수 없어서 새로 추가함
#아래 문서 참조
#https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/view-kubernetes-resources.html#view-kubernetes-resources-permissions

resource "aws_iam_policy" "eks_custom_policy" {
  name        = "eks-custom-policy"
  description = "Custom policy for EKS cluster to access various AWS resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:ListFargateProfiles",
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:ListUpdates",
          "eks:AccessKubernetesApi",
          "eks:ListAddons",
          "eks:DescribeCluster",
          "eks:DescribeAddonVersions",
          "eks:ListClusters",
          "eks:ListIdentityProviderConfigs",
          "iam:ListRoles"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = "ssm:GetParameter"
        Resource = "arn:aws:ssm:*:992382518527:parameter/*" #내 계정 ID
      }
    ]
  })
}
#위 esk custom policy를 eks의 role에 연결
resource "aws_iam_role_policy_attachment" "attach_eks_custom_policy" {
  policy_arn = aws_iam_policy.eks_custom_policy.arn
  role       = aws_iam_role.iam_role_for_eks-cluster.name
}

