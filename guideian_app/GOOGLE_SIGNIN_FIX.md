# 🔧 Google Sign-In Fix Guide

## The Problem
You're getting "invalid credentials" error when trying to sign in with Google.

## Quick Fix Steps

### Step 1: Enable Google Sign-In in Firebase Console
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: `guideian-b5eb4`
3. Go to **Authentication** → **Sign-in method**
4. Find **Google** and click on it
5. **Enable** Google Sign-In
6. Set **Project support email** to `gguideian@gmail.com`
7. Click **Save**

### Step 2: Configure OAuth Consent Screen
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select project: `guideian-b5eb4`
3. Go to **APIs & Services** → **OAuth consent screen**
4. Make sure it's configured as **External** (unless you have Google Workspace)
5. Add your email `gguideian@gmail.com` as a test user
6. Add these scopes:
   - `../auth/userinfo.email`
   - `../auth/userinfo.profile`
   - `openid`

### Step 3: Add Authorized Domains
1. In Firebase Console → **Authentication** → **Settings** → **Authorized domains**
2. Add these domains:
   - `localhost` (for development)
   - `guideian-b5eb4.firebaseapp.com`
   - Your production domain (when you deploy)

### Step 4: Test the Fix
1. Run your app: `flutter run -d edge`
2. Try Google Sign-In again
3. Check the browser console for any errors

## Common Issues

### Issue: "Error 400: redirect_uri_mismatch"
**Solution:** Make sure `localhost` is in your authorized domains

### Issue: "Error 403: access_denied"
**Solution:** Check OAuth consent screen configuration

### Issue: "Error 400: invalid_client"
**Solution:** Verify the client ID in `web/index.html` matches Firebase

## Current Configuration
- **Client ID:** `723263641111-cf6ee50tgv17gsi1c6v4ds4v9u8jd2kn.apps.googleusercontent.com`
- **Project ID:** `guideian-b5eb4`
- **Auth Domain:** `guideian-b5eb4.firebaseapp.com`

## Test After Each Step
After completing each step, test the Google Sign-In to see if the error changes. This will help identify which step fixed the issue.

## Still Not Working?
If it still doesn't work after these steps, check:
1. Browser console for specific error messages
2. Network tab for failed requests
3. Make sure you're testing in the same browser where you're logged into Google

The most common fix is **Step 1** - enabling Google Sign-In in Firebase Console!

