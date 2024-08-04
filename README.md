# 인프라 구성도
![infra drawio](https://github.com/user-attachments/assets/ca4f7986-48f5-459e-bbea-74cd6f90d910)

- EKS 구현 도중, node group failed to join cluster 에러가 발생했습니다.
- 노드는 정상적으로 생성됐지만 EKS가 노드를 확인할 수 없는 에러 같습니다.
- 에러를 해결하려고 aws documentation을 따라 여러 시도를 해봤지만, 해결에 실패해서 구성도 중 EKS 부분은 구현에 실패했습니다.

- 따라서 API Server 테스트를 위해 EKS 워커 노드의 프라이빗 서브넷에 콘솔로 EC2를 생성했습니다.
- bastion에서 EC2에 ssh 연결 후, API Server 컨테이너를 실행했습니다.
- 아래는 public subnet의 bastion에서 private subnet의 워커 노드에 ssh 연결한 사진입니다. ( health check, CRUD 시도 사진은 서버 레포지토리에 업로드했습니다. )
![ssh](https://github.com/user-attachments/assets/05da8fc4-12a4-4bac-b111-029eedbe051e)
 
 
# 디렉터리 구조
각 디렉터리에는 main.tf, outputs.tf, variables.tf가 있습니다.

.

├── README.md

├── main.tf

├── modules # terraform-{프로바이더 이름}-{모듈 이름} 순서입니다.

│   ├── eks #eks와 관련한 매니페스트 파일과 디렉터리입니다.

│   │   ├── clusterConfig.yaml #본래 bastion에서 eksctl로 만드려 했던 클러스터와 노드 그룹의 매니페스트 파일입니다.

│   │   ├── lb.yaml #본래 워커 노드에서 테스트용으로 실행하려면 service 파일입니다. ALB를 프로비저닝하려면 이게 아니라 ingress를 사용해야 합니다.

│   │   ├── pod.yaml #본래 워커 노드에서 실행하려면 API Server image를 실행하는 pod의 매니페스트 파일입니다.

│   │   ├── terraform-aws-eks_cluster #초기 terraform을 이용해 eks cluster를 구성하려고 했으나 node group failed to join cluster 에러로 인해 실패했습니다.

│   │   └── terraform-aws-node_group

│   ├── terraform-aws-ec2 #bastion을 생성하기 위한 모듈입니다.

│   ├── terraform-aws-eip #NAT에 할당할 eip를 생성하기 위한 모듈입니다.

│   ├── terraform-aws-igw #Internet Gateway 모듈입니다.

│   ├── terraform-aws-nat #NAT Gateway 모듈입니다.

│   ├── terraform-aws-rds # DS(MySQL) 모듈입니다.

│   ├── terraform-aws-route_table #route table 모듈입니다.

│   ├── terraform-aws-route_table_association #route table을 subnet에 연결하는 모듈입니다.

│   ├── terraform-aws-security_group
 
│   │   ├── bastion #bastion용 보안 그룹 모듈입니다.

│   │   └── db #RDS용 보안 그룹 모듈입니다.

│   ├── terraform-aws-subnet #Subnet 모듈입니다.

│   ├── terraform-aws-subnet_group #RDS의 multi region에 사용할 subnet group 모듈입니다.

│   └── terraform-aws-vpc #VPC 모입니다.

├── outputs.tf

├── provider.tf

├── terraform.tfstate

├── terraform.tfstate.backup

├── terraform.tfvars

└── variables.tf

 
# 주요 인프라
### RDS
![resource_rds](https://github.com/user-attachments/assets/e51301c1-0b04-482c-af63-792d0f640f31)

### NAT
![NAT](https://github.com/user-attachments/assets/cf3eb846-9ce2-4203-bb2d-218228057689)

### Subnet
![resource_subnet](https://github.com/user-attachments/assets/5cfda82b-a66c-4f02-9d60-4dc25ba1614d)
