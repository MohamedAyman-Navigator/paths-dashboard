#!/bin/bash

# Vercel Deployment Helper Script
# This script helps you deploy your Intern Management System to Vercel

echo "=================================="
echo "Vercel Deployment Helper"
echo "=================================="
echo ""

# Check if running from project root
if [ ! -d "frontend" ] || [ ! -d "backend" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

echo "📋 Deployment Checklist:"
echo ""
echo "1. Backend Deployment (Choose one):"
echo "   ☐ Railway: https://railway.app"
echo "   ☐ Render: https://render.com"
echo "   ☐ Heroku: https://heroku.com"
echo ""
echo "2. Database Setup:"
echo "   ☐ PostgreSQL instance created"
echo "   ☐ Schema and seed data loaded"
echo "   ☐ Connection string obtained"
echo ""
echo "3. Environment Variables:"
echo "   ☐ Backend environment configured"
echo "   ☐ Frontend VITE_API_URL configured"
echo ""
echo "=================================="
echo ""

# Function to deploy frontend
deploy_frontend() {
    echo "🚀 Deploying Frontend to Vercel..."
    echo ""
    
    # Check if Vercel CLI is installed
    if ! command -v vercel &> /dev/null; then
        echo "📦 Vercel CLI not found. Installing..."
        npm install -g vercel
    fi
    
    cd frontend
    
    echo "🏗️  Building frontend..."
    npm install
    npm run build
    
    echo ""
    echo "📤 Deploying to Vercel..."
    vercel --prod
    
    cd ..
    
    echo ""
    echo "✅ Frontend deployment complete!"
    echo ""
    echo "⚙️  Don't forget to set environment variable in Vercel dashboard:"
    echo "   VITE_API_URL = https://your-backend-url.com/api"
}

# Function to test build locally
test_build() {
    echo "🧪 Testing frontend build locally..."
    echo ""
    
    cd frontend
    echo "📦 Installing dependencies..."
    npm install
    
    echo "🏗️  Building..."
    npm run build
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Build successful!"
        echo "📁 Output directory: frontend/dist"
        echo ""
        echo "🌐 Preview build locally:"
        echo "   cd frontend && npm run preview"
    else
        echo ""
        echo "❌ Build failed. Please fix errors before deploying."
        exit 1
    fi
    
    cd ..
}

# Main menu
echo "What would you like to do?"
echo ""
echo "1) Test frontend build locally"
echo "2) Deploy frontend to Vercel"
echo "3) Show deployment guide"
echo "4) Exit"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        test_build
        ;;
    2)
        deploy_frontend
        ;;
    3)
        echo ""
        echo "📖 Opening deployment guide..."
        if command -v code &> /dev/null; then
            code VERCEL_DEPLOYMENT.md
        else
            cat VERCEL_DEPLOYMENT.md
        fi
        ;;
    4)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "=================================="
echo "📚 For more information, see:"
echo "   - VERCEL_DEPLOYMENT.md"
echo "   - https://vercel.com/docs"
echo "=================================="
