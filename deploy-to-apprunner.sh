#!/bin/bash

# Complete AWS App Runner Deployment Script
# This script automates everything possible for deploying to AWS App Runner

set -e  # Exit on error

echo "🚀 AskEd Chatbot - Complete AWS App Runner Deployment"
echo "====================================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}Initializing git repository...${NC}"
    git init
    echo -e "${GREEN}✅ Git initialized${NC}"
fi

# Check current git status
echo -e "${BLUE}Checking git status...${NC}"
git status --short || true

# Check if remote is set
GITHUB_REPO=""
if git remote | grep -q origin; then
    GITHUB_REPO=$(git remote get-url origin 2>/dev/null | sed 's/.*github.com[:/]\(.*\)\.git/\1/') || true
    echo -e "${GREEN}✅ GitHub remote found: ${GITHUB_REPO}${NC}"
else
    echo -e "${YELLOW}⚠️  GitHub repository not connected!${NC}"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "STEP 1: Create GitHub Repository (Required)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "1. Go to: https://github.com/new"
    echo "2. Repository name: asked-chatbot (or your choice)"
    echo "3. Set visibility: PUBLIC (required for App Runner free tier)"
    echo "4. DO NOT initialize with README, .gitignore, or license"
    echo "5. Click 'Create repository'"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    read -p "Enter your GitHub username: " GITHUB_USER
    read -p "Enter your repository name [asked-chatbot]: " REPO_NAME
    REPO_NAME=${REPO_NAME:-asked-chatbot}
    
    GITHUB_REPO="${GITHUB_USER}/${REPO_NAME}"
    git remote add origin "https://github.com/${GITHUB_REPO}.git"
    echo -e "${GREEN}✅ Remote added: https://github.com/${GITHUB_REPO}.git${NC}"
fi

# Add all files
echo ""
echo -e "${BLUE}📦 Staging all files...${NC}"
git add .

# Check if there are changes to commit
if git diff --staged --quiet 2>/dev/null; then
    echo -e "${YELLOW}ℹ️  No changes to commit (everything is already committed)${NC}"
else
    # Create commit
    COMMIT_MSG="Deploy to AWS App Runner - $(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "${BLUE}📝 Creating commit...${NC}"
    git commit -m "$COMMIT_MSG" || {
        echo -e "${YELLOW}⚠️  Commit skipped (might need git config)${NC}"
    }
    echo -e "${GREEN}✅ Changes committed${NC}"
fi

# Ensure we're on main branch
git branch -M main 2>/dev/null || true

# Push to GitHub
echo ""
echo -e "${BLUE}📤 Pushing to GitHub...${NC}"
echo -e "${YELLOW}(You may need to authenticate with GitHub)${NC}"
echo ""

if git push -u origin main 2>&1; then
    echo ""
    echo -e "${GREEN}✅ Successfully pushed to GitHub!${NC}"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "STEP 2: Deploy to AWS App Runner (Manual - Requires AWS Console)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Your code is now on GitHub: https://github.com/${GITHUB_REPO}"
    echo ""
    echo "Next steps in AWS Console:"
    echo ""
    echo "1. Go to: https://console.aws.amazon.com/apprunner"
    echo "2. Click 'Create service'"
    echo "3. Source: Select 'Source code repository'"
    echo "4. Connect GitHub:"
    echo "   - Click 'Add new' next to Repository"
    echo "   - Choose 'GitHub'"
    echo "   - Click 'Connect to GitHub' and authorize"
    echo "   - Repository: ${GITHUB_REPO}"
    echo "   - Branch: main"
    echo "5. Deployment:"
    echo "   - Trigger: Automatic"
    echo "   - Build: Use a configuration file"
    echo "6. Service settings:"
    echo "   - Service name: asked-chatbot"
    echo "   - Virtual CPU: 0.25 vCPU (free tier)"
    echo "   - Memory: 0.5 GB (free tier)"
    echo "   - Instance role: Create new service role"
    echo "7. Auto scaling:"
    echo "   - Min concurrency: 10"
    echo "   - Max concurrency: 20"
    echo "   - Max size: 1 (free tier)"
    echo "8. Click 'Create & deploy'"
    echo "9. Wait 5-10 minutes for deployment"
    echo "10. Your live URL will appear in the service details!"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo -e "${GREEN}✨ Your GitHub repository is ready!${NC}"
    echo -e "${BLUE}📖 See DEPLOYMENT.md for detailed instructions${NC}"
    echo ""
else
    echo ""
    echo -e "${YELLOW}❌ Failed to push to GitHub${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "1. Make sure you created the GitHub repository first"
    echo "2. Authenticate with GitHub:"
    echo "   - Use Personal Access Token (Settings → Developer settings)"
    echo "   - Or set up SSH keys"
    echo "3. Verify the repository URL is correct"
    echo ""
    exit 1
fi

