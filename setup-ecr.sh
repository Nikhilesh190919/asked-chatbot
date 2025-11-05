#!/bin/bash
# ECR Deployment Script for Ecoroute AI

set -e

REGION="us-east-2"
ACCOUNT_ID="529088268260"
REPO_NAME="ecoroute-ai"
IMAGE_NAME="ecoroute-ai"
ECR_URI="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"

echo "🚀 Deploying Ecoroute AI to AWS ECR"
echo "======================================"
echo ""

# Check prerequisites
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI not found. Please install it first:"
    echo "   macOS: brew install awscli"
    echo "   Or download: https://aws.amazon.com/cli/"
    exit 1
fi

if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker Desktop:"
    echo "   https://www.docker.com/products/docker-desktop/"
    exit 1
fi

echo "✅ Prerequisites check passed"
echo ""

# Step 1: Login to ECR
echo "📝 Step 1: Logging into ECR..."
aws ecr get-login-password --region ${REGION} \
  | docker login --username AWS --password-stdin ${ECR_URI}

echo "✅ Logged into ECR"
echo ""

# Step 2: Create repository (ignore error if exists)
echo "📝 Step 2: Creating ECR repository..."
aws ecr create-repository --repository-name ${REPO_NAME} --region ${REGION} 2>/dev/null || \
  echo "ℹ️  Repository already exists (that's fine)"
echo "✅ Repository ready"
echo ""

# Step 3: Build Docker image
echo "📝 Step 3: Building Docker image..."
docker build -t ${IMAGE_NAME} .
echo "✅ Image built"
echo ""

# Step 4: Tag image
echo "📝 Step 4: Tagging image for ECR..."
docker tag ${IMAGE_NAME}:latest ${ECR_URI}/${REPO_NAME}:latest
echo "✅ Image tagged"
echo ""

# Step 5: Push to ECR
echo "📝 Step 5: Pushing to ECR..."
docker push ${ECR_URI}/${REPO_NAME}:latest
echo ""
echo "✅ Successfully pushed to ECR!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Next Steps:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. Go to: https://console.aws.amazon.com/apprunner"
echo "2. Click 'Create service'"
echo "3. Select 'Container registry' → 'Amazon ECR'"
echo "4. Container image URI: ${ECR_URI}/${REPO_NAME}:latest"
echo "5. Configure service (CPU: 0.25, Memory: 0.5 GB, Port: 8080)"
echo "6. Click 'Create & deploy'"
echo "7. Wait 5-10 minutes for deployment"
echo "8. Get your live URL from service details!"
echo ""
