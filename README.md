# Ondaum Infrastructure

> 📅 This README was written on **May 15, 2025**.

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![Cloudflare](https://img.shields.io/badge/Cloudflare-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white)


## 🌍 OVERVIEW

Hello👋 This is team Ondaum. ***Ondaum*** is a pure Korean word, meaning ***'a warm and genuine self'***.

We want to help people around the world live healthier lives by being with Um, an AI professional psychological counseling companion, anytime and anywhere.

Let's start https://ondaum.revimal.me/

## 🛠 SKILLS
![Tech-Stack](https://raw.githubusercontent.com/solutionchallenge/.github/refs/heads/main/assets/images/Ondaum-Stack.png)

## 📁 DIRECTORY

```
.
├── gcp/                   # Google Cloud Platform infrastructure
│   ├── modules/           # Reusable GCP infrastructure modules
│   │   ├── core/          # Google provider definitions
│   │   ├── database/      # Google-Cloud-SQL definitions
│   │   ├── kubernetes/    # Google-Kubernetes-Engine definitions
│   │   └── network/       # Google-Cloud-Network definitions
│   ├── main.tf            # Main GCP infrastructure configuration
│   ├── variables.tf       # GCP infrastructure variables
│   ├── outputs.tf         # GCP infrastructure outputs
│   └── init.sh            # GCP infrastructure initialization script
│
├── gke/                    # Google Kubernetes Engine infrastructure
│   ├── module/            # Reusable GKE infrastructure modules
│   ├── configs/           # Kubernetes configuration files
│   ├── environments/      # Environment-injection configurations
│   ├── services/          # Kubernetes service definitions
│   │   ├── docker/        # Docker service definitions
│   │   └── gcr/           # Google-Container-Registry service definitions
│   ├── main.tf            # Main GKE infrastructure configuration
│   ├── variables.tf       # GKE infrastructure variables
│   ├── outputs.tf         # GKE infrastructure outputs
│   └── init.sh            # GKE infrastructure initialization script
│
└── .github/               # GitHub Actions workflows and templates
```

## 🚀 PROVISION
```bash
# GCP Infrastructure Setup
cd gcp
./init.sh
terraform init
terraform plan
terraform apply

# GKE Infrastructure Setup
cd ../gke
./init.sh
terraform init
terraform plan
terraform apply
```

## ⏥ ARCHITECTURE
![Infra-Architecture](https://raw.githubusercontent.com/solutionchallenge/.github/refs/heads/main/assets/images/Ondaum-Infrastructure.png)

## 💵 FORECAST
![Financial-Forecast](https://raw.githubusercontent.com/solutionchallenge/.github/refs/heads/main/assets/images/Ondaum-Forecast.png)

## 📱 FEATURE
- AI Counseling With Um
- Psychological Assessments
  - International standard tests PHQ-9 / GAD-7 / PSS 
- AI Analysis of Conversation Content
  - Summary and organization of the conversation
  - Sharing feedback and areas for improvement
    
## ✨ VALUE
- Available for consultation anytime, anywhere
- Personalized consultation possible
- Reduced barriers to seeking counseling
- Access to a pre-trained professional psychological counseling AI


