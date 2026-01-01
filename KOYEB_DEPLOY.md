# Koyeb Backend Deployment Guide (100% FREE!)

## Why Koyeb?
- ✅ **Completely free** - No credit card required
- ✅ **Perfect for Express.js** apps
- ✅ **Auto-deploy from Git**
- ✅ **512MB RAM, 2GB storage on free tier**

---

## Step 1: Create Koyeb Account (2 minutes)

1. Go to **https://www.koyeb.com**
2. Click **"Sign up"** or **"Start for free"**
3. **Sign up with GitHub** (easiest method)
4. Authorize Koyeb to access your GitHub account
5. You'll be redirected to the Koyeb dashboard

---

## Step 2: Deploy Your Backend (5 minutes)

### 2.1 Create New App

1. In Koyeb dashboard, click **"Create App"**
2. Select **"GitHub"** as the deployment method
3. If first time: Click **"Install Koyeb on GitHub"** and authorize your repository
4. **Select your repository**: `paths-dashboard` (or your repo name)

### 2.2 Configure Build Settings

**Builder**: Buildpack (auto-detected)

**Build and deployment settings**:
- **Branch**: `main` (or your default branch)
- **Build command**: `cd backend && npm install && npm run build`
- **Run command**: `cd backend && npm start`

Or if that doesn't work:
- **Working directory**: `backend`
- **Build command**: `npm install && npm run build`
- **Run command**: `npm start`

**Port**: `5000` (or set to auto-detect)

### 2.3 Add Environment Variables

Click **"Environment variables"** and add these one by one:

```
NODE_ENV=production
PORT=5000
JWT_SECRET=paths4ai-intern-management-jwt-secret-2026-production-key
JWT_EXPIRES_IN=7d
UPLOAD_DIR=./uploads
MAX_FILE_SIZE=5242880
CORS_ORIGIN=https://your-app.vercel.app
```

**Database Connection** (from Supabase):
```
DATABASE_URL=postgresql://postgres.cfvdbfdskzw:Paths2026!Dashboard@aws-0-eu-central-1.pooler.supabase.co:6543/postgres
```

> **Note**: Your backend code uses individual DB_ variables, so we need to update the backend to use DATABASE_URL or add all the individual variables.

Let me help you with this - we might need to update the backend database connection code to work with Koyeb.

### 2.4 Select Region & Deploy

- **Region**: Choose closest to you (Europe recommended)
- **Instance type**: **Free (Eco)**
- Click **"Deploy"**

Wait ~2-3 minutes for deployment to complete!

---

## Step 3: Get Your Backend URL

Once deployed:
1. You'll see your app URL: `https://your-app-name.koyeb.app`
2. **Copy this URL** - you'll need it for the frontend!

---

## What if Koyeb needs a card too?

If Koyeb also requires a card, we have one more truly free option:

### Alternative: Render.com
- Also has free tier
- Might require card for verification but won't charge
- Very similar setup to Koyeb

Should I proceed with Koyeb setup, or would you like to try Render instead?
