# Deploy to AWS App Runner via ECR (Container Image)

This guide shows how to deploy using AWS ECR (Elastic Container Registry) instead of direct GitHub connection.

## Prerequisites

You need to install:
1. **AWS CLI**: https://aws.amazon.com/cli/
2. **Docker Desktop**: https://www.docker.com/products/docker-desktop/

## Installation Commands

### macOS (using Homebrew):
```bash
# Install AWS CLI
brew install awscli

# Install Docker Desktop (download from website or):
brew install --cask docker

# Configure AWS CLI (you'll need your access keys)
aws configure
```

## ECR Deployment Steps

### Step 1: Login to ECR
```bash
aws ecr get-login-password --region us-east-2 \
  | docker login --username AWS --password-stdin 529088268260.dkr.ecr.us-east-2.amazonaws.com
```

### Step 2: Create ECR Repository (if it doesn't exist)
```bash
aws ecr create-repository --repository-name ecoroute-ai --region us-east-2
```

**Note**: If repository already exists, you'll get an error - that's fine, continue.

### Step 3: Build Docker Image
```bash
docker build -t ecoroute-ai .
```

### Step 4: Tag Image for ECR
```bash
docker tag ecoroute-ai:latest 529088268260.dkr.ecr.us-east-2.amazonaws.com/ecoroute-ai:latest
```

### Step 5: Push to ECR
```bash
docker push 529088268260.dkr.ecr.us-east-2.amazonaws.com/ecoroute-ai:latest
```

## Connect App Runner to ECR

Once the image is pushed:

1. Go to AWS App Runner Console: https://console.aws.amazon.com/apprunner
2. Click "Create service"
3. Select **"Container registry"** (not Source code repository)
4. Choose **"Amazon ECR"**
5. Select your image:
   - Container image URI: `529088268260.dkr.ecr.us-east-2.amazonaws.com/ecoroute-ai:latest`
   - Tag: `latest`
6. Configure service:
   - Service name: `ecoroute-ai`
   - CPU: 0.25 vCPU
   - Memory: 0.5 GB
   - Port: 8080
7. Click "Create & deploy"

## Alternative: Use GitHub Source (Easier)

If you prefer not to install Docker/AWS CLI, you can use GitHub source code directly:

1. Go to AWS App Runner Console
2. Select "Source code repository"
3. Connect GitHub
4. Select your repository
5. App Runner will build and deploy automatically

See `START_HERE.md` for GitHub-based deployment.

