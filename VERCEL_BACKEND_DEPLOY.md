# Deploying Backend to Vercel

## What We're Doing

Adapting your Express.js backend to run as a Vercel serverless function.

## Changes Made

1. **Created `backend/vercel.json`** - Vercel configuration
2. **Modified `backend/src/server.ts`** - Made it work with serverless
3. **Set up environment variables** - For Vercel deployment

## How to Deploy

### Step 1: Build the Backend

```bash
cd backend
npm run build
```

### Step 2: Deploy to Vercel

1. Go to **https://vercel.com/dashboard**
2. Click **"Add New..."** → **"Project"**
3. Select your **`paths-dashboard`** repository again
4. Configure:
   - **Root Directory**: `backend`
   - **Framework Preset**: Other
   - **Build Command**: `npm run build`
   - **Output Directory**: `.` (leave default)

### Step 3: Add Environment Variables

Add these in Vercel:

```
DATABASE_URL=postgresql://postgres.cfvdbfdskzw:Paths2026!Dashboard@aws-0-eu-central-1.pooler.supabase.com:5432/postgres
NODE_ENV=production
JWT_SECRET=paths4ai-intern-management-jwt-secret-2026-production-key
JWT_EXPIRES_IN=7d
CORS_ORIGIN=https://your-frontend-url.vercel.app
UPLOAD_DIR=/tmp/uploads
MAX_FILE_SIZE=5242880
PORT=5000
```

**Important:** Replace `CORS_ORIGIN` with your actual frontend Vercel URL!

### Step 4: Deploy

Click **"Deploy"** and wait for it to complete!

---

## Note About File Uploads

File uploads in serverless have limitations:
- Files go to `/tmp` which is temporary
- Files are deleted after function execution
- For production, you'd want to use cloud storage (S3, Cloudinary, etc.)

For now, file upload feature will have limited functionality on Vercel.
