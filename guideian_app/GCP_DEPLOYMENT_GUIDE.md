# Guideian Flutter Web App - GCP Deployment Guide

This guide will walk you through deploying your Flutter web app to Google Cloud Platform (GCP) using Cloud Run and GitHub Actions.

## 🚀 Quick Start

### Prerequisites

1. **Google Cloud Account**: Sign up at [Google Cloud Console](https://console.cloud.google.com/)
2. **GitHub Account**: Your code should be in a GitHub repository
3. **Flutter SDK**: Installed locally (for testing)

### Option 1: Cloud Run Deployment (Recommended)

Cloud Run is a fully managed serverless platform that's perfect for Flutter web apps.

#### Step 1: Set up GCP Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Note your **Project ID** (you'll need this later)

#### Step 2: Enable Required APIs

```bash
# Enable Cloud Run API
gcloud services enable run.googleapis.com

# Enable Container Registry API
gcloud services enable containerregistry.googleapis.com

# Enable Cloud Build API
gcloud services enable cloudbuild.googleapis.com
```

#### Step 3: Create Service Account

1. Go to **IAM & Admin** > **Service Accounts**
2. Click **Create Service Account**
3. Name: `github-actions-deploy`
4. Description: `Service account for GitHub Actions deployment`
5. Grant the following roles:
   - **Cloud Run Admin**
   - **Storage Admin**
   - **Service Account User**
   - **Cloud Build Editor**

#### Step 4: Generate Service Account Key

1. Click on the created service account
2. Go to **Keys** tab
3. Click **Add Key** > **Create New Key**
4. Choose **JSON** format
5. Download the key file (keep it secure!)

#### Step 5: Configure GitHub Secrets

In your GitHub repository, go to **Settings** > **Secrets and variables** > **Actions** and add:

- `GCP_PROJECT_ID`: Your GCP project ID
- `GCP_SA_KEY`: Contents of the JSON key file you downloaded

#### Step 6: Deploy

Simply push to your `main` branch! The GitHub Actions workflow will automatically:

1. ✅ Run tests
2. 🏗️ Build your Flutter web app
3. 🐳 Create a Docker container
4. 🚀 Deploy to Cloud Run
5. 🌐 Make your app accessible via HTTPS

### Option 2: App Engine Deployment

For more traditional hosting with more configuration options.

#### Step 1: Install Google Cloud SDK

```bash
# Windows (PowerShell)
(New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe")
& $env:Temp\GoogleCloudSDKInstaller.exe

# macOS
brew install google-cloud-sdk

# Linux
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
```

#### Step 2: Initialize and Authenticate

```bash
gcloud init
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

#### Step 3: Enable App Engine

```bash
gcloud app create --region=us-central
```

#### Step 4: Deploy

```bash
cd guideian_app
gcloud app deploy
```

Your app will be available at: `https://YOUR_PROJECT_ID.appspot.com`

## 🔧 Configuration Details

### Environment Variables

The following environment variables are automatically set:

- `FLUTTER_WEB_CANVASKIT_URL`: CanvasKit WebAssembly URL for better performance
- `FLUTTER_WEB_AUTO_DETECT`: Enables automatic WebAssembly detection

### Custom Domain Setup

1. Go to **Cloud Run** in the GCP Console
2. Select your service
3. Click **Manage Custom Domains**
4. Add your domain
5. Follow the DNS configuration instructions

### SSL Certificate

Cloud Run automatically provides SSL certificates for all deployments. Your app will be accessible via HTTPS by default.

## 📊 Monitoring and Logging

### View Logs

```bash
# Cloud Run logs
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=guideian-web" --limit 50

# App Engine logs
gcloud app logs tail
```

### Monitor Performance

1. Go to **Cloud Run** > **Monitoring** tab
2. View metrics like:
   - Request count
   - Response latency
   - Error rate
   - Memory and CPU usage

## 💰 Cost Optimization

### Cloud Run Pricing

- **Free tier**: 2 million requests/month, 400,000 GB-seconds of memory
- **Pay per use**: Only pay when requests are being processed
- **Auto-scaling**: Scales to zero when not in use

### Cost Estimation

For a typical Flutter web app:
- **Low traffic** (< 1000 users/day): ~$0-5/month
- **Medium traffic** (1000-10000 users/day): ~$5-20/month
- **High traffic** (> 10000 users/day): ~$20+/month

## 🛠️ Troubleshooting

### Common Issues

1. **Build fails**: Check Flutter version compatibility
2. **Deployment fails**: Verify service account permissions
3. **App doesn't load**: Check browser console for errors
4. **Slow loading**: Enable compression in nginx config

### Debug Commands

```bash
# Check build logs
gcloud builds log --stream

# Test locally
flutter build web --release
python -m http.server 8000 -d build/web

# Check service status
gcloud run services describe guideian-web --region=us-central1
```

## 🔄 CI/CD Pipeline

The included GitHub Actions workflow provides:

- ✅ **Automated Testing**: Runs Flutter tests on every push
- 🏗️ **Automated Building**: Builds web app with optimal settings
- 🚀 **Automated Deployment**: Deploys to Cloud Run
- 🔍 **Pull Request Previews**: Deploys preview versions for PRs
- 📊 **Deployment Status**: Comments with deployment URLs

### Manual Deployment

If you need to deploy manually:

```bash
# Build locally
flutter build web --release --web-renderer canvaskit

# Deploy using gcloud
gcloud run deploy guideian-web \
  --source . \
  --region us-central1 \
  --allow-unauthenticated
```

## 📱 Mobile App Deployment

For Android/iOS deployment to Google Play/App Store, see the `android/` and `ios/` directories in your project.

## 🔐 Security Best Practices

1. **Environment Variables**: Never commit sensitive data
2. **HTTPS**: Always use HTTPS in production
3. **CORS**: Configure CORS properly for API calls
4. **Content Security Policy**: Implement CSP headers
5. **Dependencies**: Keep dependencies updated

## 📞 Support

- **GCP Documentation**: [Cloud Run Docs](https://cloud.google.com/run/docs)
- **Flutter Web Docs**: [Flutter Web Guide](https://flutter.dev/web)
- **GitHub Issues**: Create an issue in your repository

---

## 🎉 You're All Set!

Your Flutter web app is now ready for production deployment on Google Cloud Platform. The automated CI/CD pipeline will handle building and deploying your app every time you push changes to the main branch.

**Next Steps:**
1. Set up your custom domain
2. Configure monitoring and alerts
3. Set up staging environment
4. Implement analytics and error tracking
