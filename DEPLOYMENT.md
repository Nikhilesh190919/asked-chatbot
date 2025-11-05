# AWS App Runner Deployment Guide

This guide will help you deploy your Ecoroute AI React app to AWS App Runner.

## Prerequisites

1. AWS Account (free tier eligible)
2. GitHub account
3. Git installed locally
4. AWS CLI installed (optional, but helpful)

## Step 1: Create GitHub Repository

1. Go to [GitHub](https://github.com) and sign in
2. Click the "+" icon in the top right → "New repository"
3. Repository name: `ecoroute-ai` (or your preferred name)
4. Set visibility: **Public** (required for App Runner free tier connection)
5. **DO NOT** initialize with README, .gitignore, or license (we already have these)
6. Click "Create repository"

## Step 2: Push Code to GitHub

Run these commands in your project root:

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Ecoroute AI chatbot app"

# Add your GitHub repository as remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/ecoroute-ai.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**Note**: If you haven't set up GitHub authentication, you may need to:
- Use a Personal Access Token instead of password
- Or set up SSH keys

## Step 3: Set Up AWS App Runner

### Option A: Using AWS Console (Recommended for First Time)

1. **Log in to AWS Console**
   - Go to https://console.aws.amazon.com
   - Sign in to your AWS account

2. **Navigate to App Runner**
   - Search for "App Runner" in the AWS services search bar
   - Click on "AWS App Runner"

3. **Create Service**
   - Click "Create service" button
   - Select **"Source code repository"**

4. **Connect to GitHub**
   - Click "Add new" next to "Repository"
   - Choose **"GitHub"**
   - Click "Connect to GitHub"
   - Authorize AWS App Runner to access your GitHub account
   - Select your repository: `YOUR_USERNAME/ecoroute-ai`
   - Branch: `main`

5. **Configure Deployment Settings**
   - Deployment trigger: **Automatic** (deploys on every push to main)
   - Build configuration: Select **"Use a configuration file"**
   - Configuration file: `apprunner.yaml` (in root directory)
   
   **OR use Dockerfile method:**
   - Build command: Leave default (we're using Dockerfile)
   - Runtime: Select **"Docker"**
   - Port: `8080`

6. **Configure Service Settings**
   - Service name: `asked-chatbot`
   - Virtual CPU: **0.25 vCPU** (free tier eligible)
   - Memory: **0.5 GB** (free tier eligible)
   - Instance role: Create new service role (App Runner will create it)

7. **Configure Auto Scaling**
   - Min concurrency: `10`
   - Max concurrency: `20`
   - Max size: `1` (free tier)

8. **Review and Create**
   - Review all settings
   - Click "Create & deploy"

9. **Wait for Deployment**
   - App Runner will:
     - Clone your repository
     - Build the Docker image
     - Deploy your service
   - This takes approximately 5-10 minutes

10. **Get Your URL**
    - Once deployment is complete (Status: "Running")
    - Click on your service name
    - Find the **"Default domain"** - this is your public URL!
    - Format: `https://xxxxxxxxx.us-east-1.awsapprunner.com`

### Option B: Using AWS CLI

```bash
# Create App Runner service using CLI
aws apprunner create-service \
  --service-name asked-chatbot \
  --source-configuration '{
    "AutoDeploymentsEnabled": true,
    "CodeRepository": {
      "RepositoryUrl": "https://github.com/YOUR_USERNAME/asked-chatbot",
      "SourceCodeVersion": {
        "Type": "BRANCH",
        "Value": "main"
      },
      "CodeConfiguration": {
        "ConfigurationSource": "REPOSITORY",
        "CodeConfigurationValues": {
          "Runtime": "DOCKER",
          "BuildCommand": "",
          "StartCommand": "",
          "RuntimeEnvironmentVariables": {}
        }
      }
    },
    "AuthenticationConfiguration": {
      "ConnectionArn": "YOUR_GITHUB_CONNECTION_ARN"
    }
  }' \
  --instance-configuration '{
    "Cpu": "0.25 vCPU",
    "Memory": "0.5 GB",
    "InstanceRoleArn": "arn:aws:iam::YOUR_ACCOUNT:role/service-role/apprunner-service-role"
  }' \
  --auto-scaling-configuration-arn '{
    "MinSize": 1,
    "MaxSize": 1,
    "AutoScalingConfigurationName": "asked-autoscaling"
  }'
```

## Step 4: Configure Environment Variables (If Needed)

If your app needs environment variables:

1. Go to your App Runner service
2. Click "Configuration" → "Variables"
3. Add any required environment variables

## Step 5: Update API URLs (If Using Backend)

If your React app calls the backend API, update the API URL in your frontend code:

```javascript
// In ChatInterface.js or wherever you make API calls
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000/api/chat';
```

Then set `REACT_APP_API_URL` as an environment variable in App Runner.

## Monitoring and Logs

- **Logs**: View in CloudWatch Logs
- **Metrics**: Monitor in App Runner console
- **Cost**: Free tier includes 750 hours/month

## Automatic Deployments

Once set up, every push to your `main` branch will automatically trigger a new deployment.

## Troubleshooting

### Build Fails
- Check CloudWatch logs for build errors
- Verify Dockerfile syntax
- Ensure all dependencies are in package.json

### App Not Loading
- Check that port 8080 is exposed
- Verify build completed successfully
- Check service logs in CloudWatch

### GitHub Connection Issues
- Re-authorize GitHub connection in App Runner settings
- Ensure repository is public (for free tier)

## Cost Estimate (Free Tier)

- **First 750 hours/month**: FREE
- **After free tier**: ~$0.007/hour (~$5/month for continuous running)
- **Data transfer**: First 100 GB/month free

## Your Deployment URL

After successful deployment, your app will be available at:
```
https://YOUR-SERVICE-ID.REGION.awsapprunner.com
```

This URL is permanent and won't change unless you delete and recreate the service.

