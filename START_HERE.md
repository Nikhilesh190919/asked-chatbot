# 🚀 START HERE: Deploy Your App to AWS App Runner

## ✅ What's Ready

Your code is **100% ready** for deployment:
- ✅ Git repository initialized
- ✅ All files committed
- ✅ Dockerfile configured (builds with `npm run build`, serves on port 8080)
- ✅ App Runner configuration ready
- ✅ Deployment scripts created

## 🎯 3 Simple Steps to Deploy

### STEP 1: Create GitHub Repository (2 min)

**YOU MUST DO THIS FIRST:**

1. Go to: **https://github.com/new**
2. Repository name: `asked-chatbot`
3. **Make it PUBLIC** ⚠️ (required for App Runner)
4. **DO NOT** check "Add README" or any other options
5. Click **"Create repository"**
6. **Don't close the page yet** - you'll need the URL

### STEP 2: Push Code to GitHub (1 min)

Run this command in your terminal:
```bash
./deploy-to-apprunner.sh
```

The script will:
- Ask for your GitHub username
- Connect your local repo to GitHub
- Push all your code
- Give you next steps

**Or manually:**
```bash
git remote add origin https://github.com/YOUR_USERNAME/asked-chatbot.git
git branch -M main
git push -u origin main
```

### STEP 3: Deploy to AWS App Runner (10 min)

1. **Go to AWS Console**: https://console.aws.amazon.com/apprunner
   - Sign in (create account if needed)

2. **Click "Create service"**

3. **Connect GitHub**:
   - Source: "Source code repository"
   - Add new → GitHub → Connect → Authorize
   - Select: `YOUR_USERNAME/asked-chatbot`
   - Branch: `main`
   - Trigger: **Automatic**

4. **Configure Build**:
   - Build: "Use a configuration file" or "Dockerfile"
   - (App Runner will auto-detect your Dockerfile)

5. **Configure Service**:
   - Name: `asked-chatbot`
   - CPU: **0.25 vCPU** (free tier)
   - Memory: **0.5 GB** (free tier)

6. **Auto Scaling**:
   - Max size: **1** (free tier)
   - Min/Max concurrency: 10/20

7. **Click "Create & deploy"**

8. **Wait 5-10 minutes** ⏱️

9. **Get Your URL**: 
   - When status = "Running"
   - Click service name
   - Find "Default domain"
   - **That's your live URL!** 🎉

## 📋 Your Live URL Format

```
https://XXXXXXXXXX.REGION.awsapprunner.com
```

## ⚡ Quick Reference

**Files you need:**
- `deploy-to-apprunner.sh` - Run this to push to GitHub
- `COMPLETE_DEPLOYMENT_GUIDE.md` - Full detailed guide
- `Dockerfile` - Already configured ✅

**Ports:**
- Local dev: 3003 (your `npm start`)
- Production: 8080 (App Runner, configured in Dockerfile)

**Build process:**
- `npm run build` → Creates optimized build
- `serve -s build -l 8080` → Serves on port 8080

## 🆘 Quick Troubleshooting

**Can't push to GitHub?**
- Make sure repo is created and PUBLIC
- Use Personal Access Token for auth

**Build fails in App Runner?**
- Check CloudWatch Logs
- Test locally: `cd frontend && npm run build`

**Can't find your URL?**
- Wait for status = "Running" (green)
- Click on service name in App Runner console
- Look for "Default domain"

## 💰 Free Tier Info

- **750 hours/month** FREE
- **100 GB/month** data transfer FREE
- Your config (0.25 CPU, 0.5 GB) = **FREE for full month!**

## ✨ That's It!

Follow the 3 steps above and you'll have a live app in ~15 minutes!

---

**Need more help?** See `COMPLETE_DEPLOYMENT_GUIDE.md` for detailed instructions.

