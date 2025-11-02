#!/bin/bash

# AWS App Runner Deployment Script
# This script helps you deploy your AskEd chatbot to AWS App Runner

echo "🚀 AskEd Chatbot - AWS App Runner Deployment Helper"
echo "=================================================="
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    echo "✅ Git initialized"
fi

# Check if remote is set
if ! git remote | grep -q origin; then
    echo ""
    echo "⚠️  GitHub repository not connected!"
    echo ""
    echo "STEP 1: Create a GitHub repository first:"
    echo "   1. Go to https://github.com/new"
    echo "   2. Repository name: asked-chatbot (or your choice)"
    echo "   3. Make it PUBLIC (required for App Runner free tier)"
    echo "   4. DO NOT initialize with README"
    echo "   5. Click 'Create repository'"
    echo ""
    read -p "Enter your GitHub username: " GITHUB_USER
    read -p "Enter your repository name [asked-chatbot]: " REPO_NAME
    REPO_NAME=${REPO_NAME:-asked-chatbot}
    
    git remote add origin https://github.com/${GITHUB_USER}/${REPO_NAME}.git
    echo "✅ Remote added: https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
fi

# Add all files
echo ""
echo "📦 Adding files to git..."
git add .

# Check if there are changes
if git diff --staged --quiet; then
    echo "ℹ️  No changes to commit"
else
    # Create commit
    read -p "Enter commit message [Deploy to AWS App Runner]: " COMMIT_MSG
    COMMIT_MSG=${COMMIT_MSG:-Deploy to AWS App Runner}
    git commit -m "$COMMIT_MSG"
    echo "✅ Changes committed"
fi

# Push to GitHub
echo ""
echo "📤 Pushing to GitHub..."
echo "   (You may need to authenticate with GitHub)"
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully pushed to GitHub!"
    echo ""
    echo "📋 Next Steps:"
    echo "   1. Go to AWS Console: https://console.aws.amazon.com/apprunner"
    echo "   2. Click 'Create service'"
    echo "   3. Connect your GitHub repository"
    echo "   4. Select this repository: ${GITHUB_USER}/${REPO_NAME}"
    echo "   5. Configure:"
    echo "      - Build: Use Dockerfile (in frontend/)"
    echo "      - Port: 8080"
    echo "      - CPU: 0.25 vCPU (free tier)"
    echo "      - Memory: 0.5 GB (free tier)"
    echo "   6. Wait 5-10 minutes for deployment"
    echo "   7. Get your live URL from the App Runner console"
    echo ""
    echo "📖 For detailed instructions, see DEPLOYMENT.md"
else
    echo ""
    echo "❌ Failed to push to GitHub"
    echo "   Make sure:"
    echo "   - You have a GitHub repository created"
    echo "   - You're authenticated with GitHub"
    echo "   - The repository URL is correct"
fi

