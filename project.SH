aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications ResourceType=vpc,Tags='[{Key=Name,Value="project"}]'

aws ec2 modify-vpc-attribute --vpc-id vpc-002aec2311a88f624 --enable-dns-hostnames "{\"Value\":True}"

aws ec2 create-subnet --vpc-id vpc-002aec2311a88f624 --cidr-block 10.0.0.0/24 --tag-specifications ResourceType=subnet,Tags='[{Key=Name,Value="privatesubnet"}]' --availability-zone us-east-1e

aws ec2 create-subnet --vpc-id vpc-002aec2311a88f624 --cidr-block 10.0.2.0/23 --tag-specifications ResourceType=subnet,Tags='[{Key=Name,Value="publicsubnet"}]' --availability-zone us-east-1e


aws ec2 create-internet-gateway

aws ec2 attach-internet-gateway --vpc-id vpc-002aec2311a88f624 --internet-gateway-id igw-0454028b9cf9e3dd0

aws ec2 create-route-table --vpc-id vpc-002aec2311a88f624

aws ec2 associate-route-table  --subnet-id subnet-0075e6b2dabc3f959 --route-table-id rtb-015ef3eaf89577c0e

aws ec2 create-route --route-table-id rtb-015ef3eaf89577c0e --destination-cidr-block 0.0.0.0/0 --gateway-id igw-0454028b9cf9e3dd0

aws ec2 modify-subnet-attribute --subnet-id subnet-0075e6b2dabc3f959 --map-public-ip-on-launch


aws ec2 create-security-group --group-name APPSG --description "Security group for HTTP access" --vpc-id vpc-002aec2311a88f624

aws ec2 authorize-security-group-ingress --group-id sg-076b8f7508da86236 --protocol tcp --port 80 --cidr 0.0.0.0/0

aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > ./MyKeyPair.pem

aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1 

aws ec2 run-instances --image-id ami-0fff1b9a61dec8a5f --user-data file://userdata.TXT --count 1 --instance-type t2.micro --key-name vockey --subnet-id subnet-0075e6b2dabc3f959 --security-group-ids sg-076b8f7508da86236

