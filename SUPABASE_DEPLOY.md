# Vercel + Supabase Deployment Guide (100% FREE!)

## 🎉 Why This Combo?

- **Vercel**: Free hosting for frontend + serverless API
- **Supabase**: Free PostgreSQL database (500MB storage, unlimited API requests)
- **No credit card required for either!**
- **Auto-deploy on git push**

---

## Part 1: Set Up Supabase Database (5 minutes)

### Step 1: Create Supabase Account

1. Go to **https://supabase.com**
2. Click **"Start your project"**
3. Sign up with **GitHub** (no card needed!)
4. Click **"New project"**

### Step 2: Create Your Project

1. **Organization**: Create new or select existing
2. **Name**: `paths-dashboard`
3. **Database Password**: Create a strong password (SAVE THIS!)
   - Example: `Paths2026!Dashboard`
4. **Region**: Choose closest to you (e.g., US East, Europe West)
5. **Plan**: **Free tier** (already selected)
6. Click **"Create new project"**

Wait ~2 minutes for the database to provision...

### Step 3: Set Up Database Schema

Once your project is ready:

1. Click **"SQL Editor"** in the left sidebar
2. Click **"+ New query"**
3. **Copy and paste this SQL** (I'll provide it in the next step)
4. Click **"Run"** or press `Ctrl+Enter`

### Step 4: Get Database Connection String

1. Click **"Settings"** (gear icon in sidebar) → **"Database"**
2. Scroll to **"Connection string"**
3. Select **"URI"** tab
4. Copy the connection string
5. **Replace `[YOUR-PASSWORD]`** with your database password

Keep this handy - we'll need it!

---

## Part 2: Deploy Backend to Vercel (7 minutes)

Since Vercel's serverless functions have some limitations for your backend (file uploads, complex routing), let's use **Vercel + Supabase Edge Functions** OR **keep the backend simple on Vercel**.

Actually, for simplicity, let's deploy your Express backend to **Koyeb** (free, no card needed) and frontend to Vercel.

Wait - let me check which free platforms are truly no-card-required...

Actually, **Vercel CAN host your backend** using serverless functions, but we need to adapt it slightly.

### Quick Decision:

**Option A**: Adapt backend to Vercel Serverless (more work, fully integrated)
**Option B**: Use Koyeb for backend (free, no card, easier)

Which would you prefer? 

For now, let me give you the **simpler Option B** setup:

---

## Simplified Plan: Supabase + Koyeb + Vercel

- **Database**: Supabase (PostgreSQL)
- **Backend**: Koyeb (Express API - Free)
- **Frontend**: Vercel (React app - Free)

### First, let's complete Supabase setup!

**In Supabase SQL Editor, run this:**

```sql
-- I'll provide the schema in next message
```

Are you ready to start with Supabase? Let me know when you've created your account and project!
