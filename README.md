# Fast Terraform Infrastructure (fast-tf-infra)

A **production-ready AWS infrastructure-as-code boilerplate** designed for rapid, secure, and scalable deployments. Built with Terraform, Ansible, and robust DevSecOps pipelines.

---

## 🏗️ Architecture Overview

**fast-tf-infra** provisions a modern AWS cloud stack optimized for web apps and microservices. Features include:

* Multi-tier VPC with public/private subnets across multiple AZs
* Auto-scaling EC2 behind an Application Load Balancer (ALB)
* Managed RDS (PostgreSQL/MySQL) with high availability
* ECR for container images
* Automated CI/CD with GitHub Actions, AWS CodePipeline, and CodeBuild
* Route53 DNS and automated SSL/TLS with AWS Certificate Manager
* Least-privilege IAM and secure Security Groups
* Centralized secrets via AWS Secrets Manager

---

## 🛠️ Stack & Tools

* **Terraform** (v1.2+): Infrastructure provisioning
* **AWS Provider** (\~5.0): Cloud resource management
* **S3 Backend**: Remote, locked state storage
* **Ansible**: Automated configuration management
* **GitHub Actions**: CI/CD pipeline orchestration
* **AWS CodePipeline/CodeBuild**: Automated builds and deployments
* **Docker & ECR**: Container management
* **Trivy**: Vulnerability and IaC scanning
* **detect-secrets**: Secrets detection in code
* **Pre-commit hooks**: Enforce code quality and security
* **CloudWatch**: Monitoring and logging

---

## 🔒 DevSecOps Pipeline

**Security-first, automated deployments with approval gates:**

### 1. Dev Validation (on every `main` push)

* `terraform fmt` and pre-commit for code quality
* Trivy for IaC vulnerability scanning (critical/high)
* detect-secrets for credential leak prevention
* `terraform init`, `validate`, and `plan` for configuration checks

### 2. Production Deployment (manual approval required)

* Secure, keyless AWS authentication (OIDC)
* `terraform apply` to production
* Automatic rollback on failure
* Complete audit trail via GitHub environments

#### **Pipeline Features**

* **Environment isolation:** Separate dev and prod stages
* **Fail-fast:** Blocks on any failed check
* **Audit & traceability:** All deployments and approvals logged

---

## 🚀 Core Features

### Infrastructure

* **Highly available:** Multi-AZ, auto-scaling, ALB health checks
* **Secure:** Least-privilege IAM, encrypted storage, VPC flow logs, SSL everywhere
* **Efficient scaling:** Automated ASG and managed RDS clustering

### Development Workflow

* **Plan-first:** `terraform plan` on every push
* **Zero-touch deployments:** Automated on `main` branch with manual prod approval
* **Security built-in:** Trivy and detect-secrets block unsafe changes

### Configuration Management

* **Ansible automation:** Server setup, updates, package management
* **Dynamic inventory:** Live EC2 discovery for configuration runs

---

## 📁 Project Layout

```
fast-tf-infra/
├── main.tf                   # Main Terraform config
├── variables.tf              # Global variables
├── modules/                  # Reusable infrastructure modules
│   ├── compute/              # EC2, ASG, ALB
│   ├── networking/           # VPC, subnets
│   ├── storage/              # RDS, S3
│   ├── security/             # IAM, security groups
│   ├── dns/                  # Route53, certificates
│   ├── ecr/                  # Container registry
│   ├── code_pipeline/        # CI/CD setup
│   └── secrets/              # Secrets Manager
├── ansible/                  # Server configuration
│   ├── site.yml              # Main playbook
│   ├── inventory.aws_ec2.yml # Dynamic inventory
│   └── requirements.txt      # Ansible dependencies
├── scripts/                  # Utility scripts
├── .github/workflows/        # GitHub Actions CI/CD
│   └── ci.yml
└── .pre-commit-config.yaml   # Linting & hooks
```

---

## 🎯 Use Cases

* **Scalable web & API backends**
* **Microservices and container deployments**
* **Dev/prod environments with one config**
* **PoCs and hackathons**
* **Learning modern cloud DevSecOps**
* **Startups needing production infra, fast**

---

## 🔧 Configuration

Customize easily with Terraform variables:

* **Environment:** (`dev`, `production`)
* **Region:** (`ap-southeast-1` by default)
* **Instance types:** EC2 sizing
* **Domain/DNS:** Custom domain and subdomains
* **Database:** Engine, instance size, storage
* **Scaling:** Min/max ASG, scale policies

---

## 🔐 Security Best Practices

* **Remote state:** Encrypted S3 with state locking
* **IAM:** Least privilege and short-lived tokens (OIDC)
* **Network:** Private subnets, VPC flow logs, bastion host for admin
* **Secrets:** AWS Secrets Manager for all credentials
* **Encryption:** At rest (RDS, S3, Secrets) and in transit (SSL/TLS)
* **Automated security scanning** on every push

---

## 🚦 Getting Started

1. **Install:** AWS CLI, Terraform, and Ansible
2. **Configure:** AWS creds, edit Terraform vars
3. **Deploy:** Push to `main` to trigger pipeline
4. **Approve:** Manual approval for production deploys
5. **Monitor:** Use AWS CloudWatch for all metrics/logs

---

**fast-tf-infra** gives you a modern, security-first AWS foundation—automated, auditable, and production-ready. Deploy with confidence!
