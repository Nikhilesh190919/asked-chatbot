# 🚀 Next Steps: Deploy Your App

Your code is **ready to deploy**! All files are committed to git. Follow these steps:

## ✅ What's Already Done

- ✅ Git repository initialized
- ✅ All code committed
- ✅ Dockerfile created and configured
- ✅ App Runner configuration ready
- ✅ Production build setup complete

## 📋 Step-by-Step Deployment

### STEP 1: Create GitHub Repository (2 minutes)

1. Go to https://github.com/new
2. Repository name: `asked-chatbot` (or your choice)
3. **Make it PUBLIC** (required for App Runner free tier)
4. **DO NOT** check "Add a README file"
5. Click **"Create repository"**

### STEP 2: Push Code to GitHub (1 minute)

**Option A: Use the helper script**
```bash
./deploy.sh
```
Follow the prompts to enter your GitHub username.

**Option B: Manual commands**
Replace `YOUR_USERNAME` with your GitHub username:
```bash
git remote add origin https://github.com/YOUR_USERNAME/asked-chatbot.git
git branch -M main
git push -u origin main
```

**Note**: If you need GitHub authentication:
- Use a Personal Access Token (Settings → Developer settings → Personal access tokens)
- Or set up SSH keys

### STEP 3: Deploy to AWS App Runner (10 minutes)

1. **Go to AWS Console**
   - Visit: https://console.aws.amazon.com/apprunner
   - Sign in to your AWS account (create one at aws.amazon.com if needed)

2. **Create Service**
   - Click **"Create service"** button

3. **Connect Source**
   - Select **"Source code repository"**
   - Click **"Add new"** next to Repository
   - Choose **"GitHub"**
   - Click **"Connect to GitHub"** and authorize
   - Select repository: `YOUR_USERNAME/asked-chatbot`
   - Branch: `main`

4. **Configure Deployment**
   - Deployment trigger: **Automatic** (deploys on every push)
   - Build configuration: **"Use a configuration file"** (apprunner.yaml exists)

5. **Configure Service**
   - Service name: `asked-chatbot`
   - **Virtual CPU**: `0.25 vCPU` (free tier)
   - **Memory**: `0.5 GB` (free tier)
   - Instance role: Create new (App Runner handles this)

6. **Configure Auto Scaling**
   - Min concurrency: `10`
   - Max concurrency: `20`
   - Max size: `1` (free tier)

7. **Review & Deploy**
   - Review settings
   - Click **"Create & deploy"**
   - Wait 5-10 minutes for first deployment

8. **Get Your Live URL** 🎉
   - Once status shows "Running"
   - Click on your service name
   - Find **"Default domain"** - that's your live URL!
   - Format: `https://xxxxxxxxxx.REGION.awsapprunner.com`

## 🔗 Your App Will Be Live At:
```
https://YOUR-SERVICE-ID.REGION.awsapprunner.com
```

## 💰 Cost Information

- **First 750 hours/month**: FREE
- **After free tier**: ~$0.007/hour (~$5/month if running 24/7)
- **Data transfer**: First 100 GB/month free

## 🎯 What Happens Next

- **Automatic deployments**: Every push to `main` branch triggers a new deployment
- **Monitoring**: View logs and metrics in App Runner console
- **Updates**: Just push to GitHub and App Runner auto-deploys!

## 🆘 Need Help?

- **Detailed guide**: See [DEPLOYMENT.md](./DEPLOYMENT.md)
- **Quick reference**: See [QUICK_START.md](./QUICK_START.md)
- **Build issues**: Check CloudWatch Logs in AWS Console
- **GitHub issues**: Make sure repo is public and connection is authorized

## ✨ You're All Set!

Your code is ready. Just follow the 3 steps above and you'll have a live app in about 15 minutes!

---

**Pro Tip**: Bookmark your App Runner service URL in AWS Console for easy access to logs and settings.

