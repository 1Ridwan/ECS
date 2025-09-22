# Shiori on AWS ECS Fargate

## Overview
This project deploys [Shiori](https://github.com/go-shiori/shiori) on AWS ECS Fargate using a highly available architecture across two availability zones. The deployment leverages public and private subnets, an application load balancer, and modular Terraform infrastructure-as-code. Security and compliance best practices are applied throughout the stack.

## Architecture
- **ECS Fargate** cluster with tasks running in private subnets.  
- **Public subnets** host the Application Load Balancer and NAT Gateways.  
- **NAT Gateway** provides outbound internet access for ECS tasks to pull images from Amazon ECR and communicate with external services.  
- **Application Load Balancer (ALB)** terminates TLS and routes traffic to ECS tasks. HTTP requests are redirected to HTTPS.  
- **Amazon Route 53** manages DNS records for custom domain ridwanprojects.con.  
- **AWS Certificate Manager (ACM)** provides SSL/TLS certificates with automated validation.  
- **CloudWatch** collects and stores ECS task logs for observability.  

## Architecture Diagram
The diagram below illustrates the high-level architecture of this deployment.  

![Architecture Diagram](ecs-architecture-diagram.jpeg)

## Security
- **Security groups** enforce least privilege:
  - ALB allows inbound HTTP/HTTPS traffic from the internet.
  - ECS tasks accept traffic only on the application port from the ALB security group.  
- **WAFv2** is deployed with AWS Managed Core Rule Set to mitigate:
  - SQL injection  
  - Cross-site scripting  
  - HTTP flood attacks  
  - Scanning probes and other common threats  
- **IAM roles** follow the principle of least privilege:
  - ECS task execution role allows pulling images from ECR and sending logs to CloudWatch.

## Infrastructure as Code
- **Terraform** provisions AWS resources.  
- Modularised design follows DRY principles for maintainability and reusability.  
- Remote backend uses S3 for state storage with the new native state locking feature (no DynamoDB required).  
- Terraform import used to import ECR repository and hosted zone resources

## CI/CD
- **GitHub Actions** automates build, security scanning, and deployment.  
- **Docker** builds container images and pushes them to Amazon ECR.  
- **Checkov** scans Terraform configurations for misconfigurations.  
- **Trivy** scans container images for vulnerabilities.  
- Pipelines ensure that only secure and compliant builds are deployed.  

## Deployment Steps
1. Clone the repository.  
2. Configure AWS credentials with appropriate IAM permissions.  
3. Build and push Shiori Docker image to ECR using GitHub Actions pipeline.  
4. Run Terraform to provision networking, ECS, ALB, Route 53, ACM, WAF, and supporting resources.  
5. ECS Service deploys the Shiori containers in private subnets.  
6. Access Shiori securely through the Route 53 domain with HTTPS enabled.  

## Monitoring
- ECS task logs are available in CloudWatch.  
