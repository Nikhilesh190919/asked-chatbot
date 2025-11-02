# 🚀 Complete AWS App Runner Deployment Guide

This guide will help you deploy your AskEd React app to AWS App Runner and get your live URL.

## ⚡ Quick Deploy (Run This Script)

```bash
./deploy-to-apprunner.sh
```

This script will:
- ✅ Check git setup
- ✅ Help you connect to GitHub
- ✅ Push your code to GitHub
- ✅ Guide you through AWS App Runner setup

---

## 📋 Detailed Step-by-Step Instructions

### Step 1: Create GitHub Repository (2 minutes)

**You must do this first!**

1. **Go to GitHub**
   - Visit: https://github.com/new
   - Sign in to your GitHub account

2. **Create Repository**
   - Repository name: `asked-chatbot` (or your choice)
   - Description: "AskEd - AI Chatbot for University Student Services"
   - Visibility: **PUBLIC** ⚠️ (Required for App Runner free tier connection)
   - **DO NOT** check:
     - ❌ Add a README file
     - ❌ Add .gitignore
     - ❌ Choose a license
   - Click **"Create repository"**

3. **Copy the repository URL** (you'll need it in Step 2)

---

### Step 2: Push Code to GitHub (1 minute)

**Option A: Use the automated script** (Recommended)
```bash
./deploy-to-apprunner.sh
```

**Option B: Manual commands**
```bash
# Add GitHub remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/asked-chatbot.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**GitHub Authentication:**
- If prompted, use a **Personal Access Token** (not password)
- Create one at: GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
- Required scopes: `repo` (full control of private repositories)

---

### Step 3: Deploy to AWS App Runner (10 minutes)

#### 3.1. Access AWS App Runner

1. Go to: https://console.aws.amazon.com/apprunner
2. Sign in to your AWS account
   - Create account at aws.amazon.com if needed (free tier available)

#### 3.2. Create App Runner Service

1. Click **"Create service"** button (top right)

#### 3.3. Connect Source Repository

1. **Source type**: Select **"Source code repository"**
2. **Repository**: Click **"Add new"**
3. **Provider**: Choose **"GitHub"**
4. **Connect GitHub**:
   - Click **"Connect to GitHub"**
   - Authorize AWS App Runner to access your GitHub account
   - Grant permissions when prompted
5. **Select Repository**:
   - Repository: Choose `YOUR_USERNAME/asked-chatbot`
   - Branch: `main`
   - Deployment trigger: **Automatic** (deploys on every push)

#### 3.4. Configure Build

- **Build configuration**: Select **"Use a configuration file"** or **"Dockerfile"**
  - App Runner will automatically detect the Dockerfile in your repository
  - The Dockerfile is configured to:
    1. Build your React app with `npm run build`
    2. Serve it on port 8080 using `serve`

#### 3.5. Configure Service Settings

- **Service name**: `asked-chatbot`
- **Virtual CPU**: **0.25 vCPU** (free tier eligible)
- **Memory**: **0.5 GB** (free tier eligible)
- **Instance role**: 
  - Select **"Create new service role"**
  - App Runner will create it automatically

#### 3.6. Configure Auto Scaling

- **Min concurrency**: `10`
- **Max concurrency**: `20`
- **Max size**: `1` (free tier - keeps cost minimal)
- **Min size**: `1` (always running)

#### 3.7. Review and Deploy

1. Review all settings
2. Click **"Create & deploy"**
3. **Wait 5-10 minutes** for the first deployment
   - You'll see the deployment progress in real-time
   - Status will change: "Creating" → "Build in progress" → "Deploying" → "Running"

#### 3.8. Get Your Live URL 🎉

1. Once status shows **"Running"** (green)
2. Click on your service name: `asked-chatbot`
3. Find the **"Default domain"** section
4. Your live URL will be:
   ```
   https://XXXXXXXXXX.REGION.awsapprunner.com
   ```
5. **Bookmark this URL** - it's your permanent app URL!

---

## 📊 Deployment Configuration Summary

### Your App Setup
- **Local development**: Runs on port 3003 (`npm start`)
- **Production build**: Uses `npm run build` (creates optimized build)
- **Production server**: Uses `serve` package on port 8080
- **Docker**: Multi-stage build for optimal image size

### App Runner Configuration
- **Runtime**: Docker
- **Port**: 8080
- **Build**: Automatic (uses Dockerfile)
- **Deploy**: Automatic on every push to `main` branch

---

## 🔄 Automatic Deployments

Once set up, **every push to your `main` branch** automatically triggers a new deployment:

```bash
# Make changes to your code
git add .
git commit -m "Update features"
git push origin main

# App Runner will automatically:
# 1. Detect the push
# 2. Build the new version
# 3. Deploy it (takes 5-10 minutes)
```

---

## 💰 Cost Information (Free Tier)

### AWS Free Tier Includes:
- **750 hours/month** of App Runner service (FREE)
- **100 GB/month** data transfer (FREE)

### After Free Tier:
- **Compute**: ~$0.007 per vCPU-hour
- **Memory**: ~$0.0008 per GB-hour
- **Estimated monthly cost**: ~$5-10 if running 24/7 after free tier

### Tips to Stay Free:
- With 0.25 vCPU and 0.5 GB, you get **750 hours/month free**
- That's enough for **continuous operation** (24/7) for the entire month!
- Most users stay within free tier limits

---

## 📱 Monitoring & Management

### View Logs
1. Go to your App Runner service
2. Click **"Logs"** tab
3. View real-time logs and build logs

### View Metrics
1. Go to your App Runner service
2. Click **"Metrics"** tab
3. Monitor:
   - Requests per second
   - Response time
   - CPU/Memory usage
   - Active instances

### Update Service
1. Click **"Configuration"** tab
2. Edit settings (CPU, memory, scaling)
3. Click **"Save changes"**
4. New deployment will start automatically

---

## 🔧 Troubleshooting

### Build Fails

**Problem**: Build fails in App Runner

**Solutions**:
1. Check CloudWatch Logs (in App Runner console → Logs tab)
2. Verify Dockerfile syntax
3. Ensure `package.json` has all dependencies
4. Check that `npm run build` works locally:
   ```bash
   cd frontend
   npm install
   npm run build
   ```

### App Not Loading

**Problem**: App shows error or blank page

**Solutions**:
1. Check service logs in App Runner console
2. Verify port 8080 is exposed in Dockerfile
3. Ensure build completed successfully
4. Check browser console for errors

### GitHub Connection Issues

**Problem**: Can't connect GitHub repository

**Solutions**:
1. Make sure repository is **PUBLIC**
2. Re-authorize GitHub connection:
   - Go to App Runner → Settings → Source
   - Remove and re-add GitHub connection
3. Check repository permissions

### Port Configuration

**Problem**: App not accessible

**Solution**: 
- App Runner uses port 8080 (configured in Dockerfile)
- Your local port 3003 is only for development
- Production uses port 8080 - this is correct!

---

## ✅ Verification Checklist

Before you finish, verify:

- [ ] GitHub repository is **PUBLIC**
- [ ] Code is pushed to GitHub `main` branch
- [ ] AWS App Runner service shows status **"Running"**
- [ ] You have your **Default domain URL**
- [ ] App loads in browser at your URL
- [ ] Automatic deployments are enabled

---

## 🎯 Your Live App URL

After successful deployment, your app is live at:

```
https://YOUR-SERVICE-ID.REGION.awsapprunner.com
```

**This URL is permanent** and won't change unless you delete the service.

---

## 🆘 Need Help?

- **Detailed troubleshooting**: Check CloudWatch Logs in AWS Console
- **Build issues**: Run `npm run build` locally to test
- **GitHub issues**: Verify repository is public and connection is authorized
- **AWS support**: Use AWS Support Center (free tier includes basic support)

---

## 🎉 Success!

Once you see **"Running"** status and have your URL, your app is live and accessible worldwide!

**Next steps**:
- Share your URL
- Monitor usage in App Runner console
- Make changes and push - they'll auto-deploy!

---

**Quick Reference**:
- GitHub Repo: https://github.com/YOUR_USERNAME/asked-chatbot
- AWS App Runner: https://console.aws.amazon.com/apprunner
- Your Live App: https://YOUR-SERVICE-ID.REGION.awsapprunner.com

