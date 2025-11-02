# Quick Start: Deploy to AWS App Runner

## ⚡ Fast Track (5 Steps)

### 1. Create GitHub Repository
- Go to https://github.com/new
- Name: `asked-chatbot`
- Make it **PUBLIC**
- Don't initialize with files
- Click "Create repository"

### 2. Push Your Code
Run this command in your project directory:
```bash
./deploy.sh
```

Or manually:
```bash
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/asked-chatbot.git
git push -u origin main
```

### 3. Go to AWS App Runner
- Open: https://console.aws.amazon.com/apprunner
- Click **"Create service"**

### 4. Connect GitHub
- Source: **Source code repository**
- Repository: Connect GitHub → Select `asked-chatbot`
- Branch: `main`
- Deployment: **Automatic**

### 5. Configure Build
- **Runtime**: Docker
- **Dockerfile path**: Leave default (it will find the Dockerfile in root)
- **Port**: `8080`

### 6. Configure Service
- Service name: `asked-chatbot`
- CPU: **0.25 vCPU** (free tier)
- Memory: **0.5 GB** (free tier)
- Min size: `1`
- Max size: `1`

### 7. Create & Deploy
- Click **"Create & deploy"**
- Wait 5-10 minutes
- Your URL will appear when ready!

## 🎯 Your Live URL Format
```
https://XXXXXXXXXX.us-east-1.awsapprunner.com
```

## 📝 Important Notes

1. **Repository must be PUBLIC** for free tier
2. **First deployment takes 5-10 minutes**
3. **Auto-deploy is enabled** - every push to main triggers a new deployment
4. **Free tier**: 750 hours/month free

## 🔧 Troubleshooting

**Build fails?**
- Check CloudWatch logs
- Verify Dockerfile is in project root
- Ensure package.json has all dependencies

**Can't connect GitHub?**
- Make sure repository is public
- Re-authorize GitHub connection

**Need help?** See `DEPLOYMENT.md` for detailed instructions.

