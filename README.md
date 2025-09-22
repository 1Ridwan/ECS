# Shiori on AWS ECS Fargate

## Overview

**Shiori**

This project deploys [Shiori](https://github.com/go-shiori/shiori) on AWS ECS Fargate using a highly available architecture across two availability zones.

Shiori is a bookmark manager written in Go that provides bookmark management in a simple and easy to use web interface.

**Deployment**

The deployment leverages public and private subnets, an application load balancer, and modular Terraform infrastructure-as-code. Security and compliance best practices are applied throughout the stack.

## Project Structure

```text
.
├── app/
├── README.md
└── terraform
    ├── modules
        ├── acm
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
        ├── alb
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
        ├── ecr
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
        ├── ecs
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
        ├── iam
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
        ├── route53
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
        ├── routes
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
        ├── sg
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
        ├── vpc
           ├── main.tf
           ├── outputs.tf
           ├── variables.tf
    ├── backend.tf
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    ├── terraform.tfvars
    └── variables.tf
```

## Architecture Diagram
The diagram below illustrates the architecture of this deployment.  

![Architecture Diagram](ecs-architecture-diagram.jpeg)

### Description:
> - **ECS Fargate** cluster with tasks running in private subnets.  
> - **Public subnets** host the Application Load Balancer and NAT Gateways.  
> - **NAT Gateway** provides outbound internet access for ECS tasks to pull images from Amazon ECR and communicate with external services.  
> - **Application Load Balancer (ALB)** terminates TLS and routes traffic to ECS tasks. HTTP requests are redirected to HTTPS.  
> - **Amazon Route 53** manages DNS records for custom domain ridwanprojects.com.  
> - **AWS Certificate Manager (ACM)** provides SSL/TLS certificates with automated validation.  
> - **CloudWatch** collects and stores ECS task logs for observability.  
### Architecture Features

| AWS Resource / Tool                  | Purpose                                                                 |
|--------------------------------------|-------------------------------------------------------------------------|
| **Amazon ECS (Fargate)**             | Runs Shiori containers in a serverless, managed compute environment.    |
| **Amazon ECR**                       | Stores and manages Docker images built by the CI/CD pipeline.           |
| **Application Load Balancer (ALB)**  | Distributes traffic across ECS tasks; handles HTTP to HTTPS redirection.|
| **AWS WAFv2**                        | Protects ALB with AWS Managed Core Rule Set against common web exploits.|
| **Amazon VPC**                       | Provides isolated networking environment with public and private subnets.|
| **NAT Gateway**                      | Allows ECS tasks in private subnets to access the internet securely.    |
| **Amazon Route 53**                  | Manages DNS records for the custom domain (ridwanprojects.com).         |
| **AWS Certificate Manager (ACM)**    | Issues and manages TLS certificates with automated validation.          |
| **Amazon CloudWatch**                | Collects ECS task logs and provides monitoring and metrics.              |
| **AWS IAM**                          | Manages roles and policies following least privilege principle.         |
| **AWS S3 (Terraform Backend)**       | Stores Terraform state file with native state locking.                  |
| **GitHub Actions**                   | Automates build, scanning, and deployment pipelines.                    |
| **Docker**                           | Builds and packages Shiori container images for deployment.             |
| **Checkov**                          | Scans Terraform code for security and compliance issues.                |
| **Trivy**                            | Scans container images for vulnerabilities before deployment.           |
| **Terraform**                        | Infrastructure as Code used to provision and manage AWS resources.      |

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
