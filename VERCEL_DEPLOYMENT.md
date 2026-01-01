# Vercel Deployment Guide - Intern Management System

## 📋 Overview

This guide will help you deploy your Intern Management System to Vercel. The deployment strategy:
- **Frontend**: Deployed as a static site on Vercel
- **Backend**: Two options available (see below)
- **Database**: Hosted on a cloud PostgreSQL service

## 🚀 Deployment Architecture Options

### Option 1: Separate Backend Hosting (Recommended)
**Frontend on Vercel + Backend elsewhere (Render/Railway/Heroku)**

✅ **Pros:**
- Better performance for backend
- No cold starts
- Easier file upload handling
- Full Express.js features
- Better for long-running processes

**Best for:** Production applications with file uploads and complex backend logic

### Option 2: Vercel Serverless Functions
**Both Frontend and Backend on Vercel**

✅ **Pros:**
- Single platform deployment
- Simpler setup
- Free tier available

⚠️ **Cons:**
- 10s timeout on Hobby plan, 60s on Pro
- File upload limitations
- Cold starts possible
- More complex configuration

**Best for:** Testing or applications with simple API needs

---

## 🎯 Recommended Deployment: Option 1

### Step-by-Step Guide

#### 1. Deploy Backend (Choose One Platform)

##### Option A: Railway.app (Easiest)
```bash
# Install Railway CLI
npm i -g @railway/cli

# Login to Railway
railway login

# Initialize project
cd backend
railway init

# Add PostgreSQL database
railway add --database postgresql

# Deploy
railway up
```

Configure environment variables in Railway dashboard.

##### Option B: Render.com
1. Go to [render.com](https://render.com)
2. Click "New +" → "Web Service"
3. Connect your Git repository
4. Configure:
   - **Build Command**: `cd backend && npm install && npm run build`
   - **Start Command**: `cd backend && npm start`
   - **Environment**: Node
5. Add environment variables (see section below)
6. Click "Create Web Service"

##### Option C: Heroku
```bash
# Install Heroku CLI
npm install -g heroku

# Login
heroku login

# Create app
heroku create your-app-name-backend

# Add PostgreSQL
heroku addons:create heroku-postgresql:essential-0

# Set environment variables
heroku config:set NODE_ENV=production
heroku config:set JWT_SECRET=$(openssl rand -base64 32)
# ... add other env vars

# Deploy
git subtree push --prefix backend heroku main
```

#### 2. Set Up PostgreSQL Database

##### Recommended Providers:
- **Neon** (free tier, serverless): [neon.tech](https://neon.tech)
- **Supabase** (free tier): [supabase.com](https://supabase.com)
- **Railway**: Included with backend deployment
- **Render**: Add PostgreSQL service

##### Setup Steps:
1. Create a PostgreSQL database on your chosen provider
2. Copy the connection string
3. Run your schema:
   ```bash
   psql "your-connection-string" -f database/schema.sql
   psql "your-connection-string" -f database/seed.sql
   ```

#### 3. Deploy Frontend to Vercel

##### Option A: Vercel Dashboard (Easiest)
1. Go to [vercel.com](https://vercel.com) and sign in
2. Click "Add New Project"
3. Import your Git repository
4. Configure:
   - **Framework Preset**: Vite
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
5. Add environment variable:
   - `VITE_API_URL` = `https://your-backend-url.com/api`
6. Click "Deploy"

##### Option B: Vercel CLI
```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy from frontend directory
cd frontend
vercel

# Follow prompts:
# - Set up and deploy? Yes
# - Which scope? (select your account)
# - Link to existing project? No
# - What's your project's name? paths-dashboard-frontend
# - In which directory is your code located? ./
# - Want to override settings? Yes
# - Build Command? npm run build
# - Output Directory? dist
# - Development Command? npm run dev

# Set environment variable
vercel env add VITE_API_URL production
# Enter: https://your-backend-url.com/api

# Deploy to production
vercel --prod
```

---

## 🔧 Environment Variables Setup

### Backend Environment Variables

Set these in your backend hosting platform (Railway/Render/Heroku):

```env
# Server
PORT=5000
NODE_ENV=production

# Database (from your PostgreSQL provider)
DB_HOST=your-db-host.com
DB_PORT=5432
DB_NAME=intern_management
DB_USER=your_db_user
DB_PASSWORD=your_db_password

# Security
JWT_SECRET=<generate with: openssl rand -base64 32>
JWT_EXPIRES_IN=7d

# File Upload
UPLOAD_DIR=./uploads
MAX_FILE_SIZE=5242880

# CORS - Your Vercel frontend URL
CORS_ORIGIN=https://your-frontend.vercel.app
```

### Frontend Environment Variables

Set in Vercel dashboard or using CLI:

```env
VITE_API_URL=https://your-backend-url.com/api
```

---

## 🌐 Custom Domain Setup (Optional)

### For Frontend (Vercel)
1. Go to Project Settings → Domains
2. Add your custom domain (e.g., `app.paths4ai.com`)
3. Follow DNS configuration instructions

### For Backend
- **Railway/Render**: Go to Settings → Add custom domain
- **Heroku**: `heroku domains:add api.yourdom ain.com`

---

## ✅ Post-Deployment Checklist

After deployment, verify:

- [ ] Frontend loads correctly at Vercel URL
- [ ] Backend API is accessible
- [ ] Database connection works
- [ ] Login functionality works (test with admin@example.com / admin123)
- [ ] File uploads work (profile photos, task submissions)
- [ ] CORS is configured correctly
- [ ] HTTPS is enabled on both frontend and backend
- [ ] Environment variables are set correctly
- [ ] Change default admin password!

### Test These Features:
- [ ] Admin login
- [ ] Create intern account
- [ ] Create and assign task
- [ ] Mark attendance
- [ ] Submit task (file upload)
- [ ] Rate submission
- [ ] Check notifications
- [ ] Upload profile photo

---

## 🐛 Troubleshooting

### Frontend Issues

**Blank page on Vercel:**
- Check browser console for errors
- Verify `VITE_API_URL` is set correctly in Vercel environment variables
- Redeploy after setting environment variables

**API calls failing:**
- Check Network tab in browser DevTools
- Verify backend URL is correct and accessible
- Check CORS configuration in backend

**404 on page refresh:**
- Vercel should auto-configure SPA routing
- If not, create `vercel.json` in frontend:
  ```json
  {
    "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
  }
  ```

### Backend Issues

**Database connection errors:**
- Verify database credentials
- Check if database allows external connections
- Ensure database is running

**File upload not working:**
- Check `UPLOAD_DIR` exists
- Verify file size limits
- Check disk space on server

**CORS errors:**
- Update `CORS_ORIGIN` to match your Vercel frontend URL exactly
- Include protocol (https://)
- No trailing slash

### Environment Variable Issues

**Changes not taking effect:**
- Redeploy after changing environment variables
- For Vercel: Trigger new deployment
- For Railway/Render: Should auto-redeploy

---

## 📊 Monitoring & Maintenance

### Vercel Dashboard
- View deployment logs
- Monitor function metrics
- Check analytics

### Backend Logs
- **Railway**: View logs in dashboard
- **Render**: Logs tab in dashboard
- **Heroku**: `heroku logs --tail`

### Database Backups
Most providers offer automatic backups:
- **Neon**: Automatic with Time Travel feature
- **Supabase**: Point-in-time recovery
- **Railway**: Enable in database settings

---

## 💰 Pricing Estimates

### Free Tier Option
- **Frontend (Vercel)**: Free (Hobby plan)
- **Backend (Railway)**: $5/month starter
- **Database (Neon)**: Free tier (0.5 GB)
- **Total**: ~$5/month

### Production Option
- **Frontend (Vercel Pro)**: $20/month
- **Backend (Render)**: $7-25/month
- **Database (Supabase)**: $25/month (Pro)
- **Total**: ~$52-70/month

---

## 🔗 Useful Links

- [Vercel Documentation](https://vercel.com/docs)
- [Railway Documentation](https://docs.railway.app)
- [Render Documentation](https://render.com/docs)
- [Neon Documentation](https://neon.tech/docs)
- [Supabase Documentation](https://supabase.com/docs)

---

## 📞 Support

For deployment issues:
- Check the troubleshooting section above
- Review platform-specific documentation
- Check community forums for your chosen platform

---

**Last Updated**: January 1, 2026
**Status**: Ready for Deployment 🚀
