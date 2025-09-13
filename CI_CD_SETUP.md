# CI/CD Pipeline Setup for Guideian

This document explains how to set up and use the Continuous Integration/Continuous Deployment pipeline for your Guideian Flutter app.

## Overview

The CI/CD pipeline includes:
- **Automated Testing** - Unit tests, integration tests, and code quality checks
- **Automated Building** - Web, Android, and iOS builds
- **Automated Deployment** - Deploy to GitHub Pages, Vercel, or Firebase Hosting
- **Code Quality** - Linting, formatting, and security checks
- **Performance Testing** - Automated performance validation

## Setup Instructions

### 1. GitHub Actions Workflows

The following workflows are configured:

#### **Main CI/CD Pipeline** (`.github/workflows/flutter_ci_cd.yml`)
- Runs on every push and pull request
- Includes: Testing, Building, Security checks, Performance tests
- **Triggers:** Push to `main` or `recover-commit` branches, Pull requests

#### **Quick Test Pipeline** (`.github/workflows/flutter_test.yml`)
- Lightweight testing for faster feedback
- Includes: Format check, Analyze, Unit tests
- **Triggers:** Every push and pull request

#### **Deployment Pipeline** (`.github/workflows/deploy.yml`)
- Deploys to web hosting platforms
- **Triggers:** Push to `main` branch, Manual dispatch

### 2. Required GitHub Secrets

To enable deployment, add these secrets to your GitHub repository:

#### For GitHub Pages:
```
GITHUB_TOKEN (automatically available)
```

#### For Vercel:
```
VERCEL_TOKEN=your_vercel_token
ORG_ID=your_org_id
PROJECT_ID=your_project_id
```

#### For Firebase Hosting:
```
FIREBASE_SERVICE_ACCOUNT_GUIDEIAN_B5EB4=your_service_account_json
```

### 3. Setting Up Secrets

1. **Go to your GitHub repository**
2. **Click Settings → Secrets and variables → Actions**
3. **Click "New repository secret"**
4. **Add the required secrets above**

## Workflow Features

### Code Quality Checks
- **Formatting:** Ensures consistent code formatting
- **Linting:** Catches potential issues and enforces best practices
- **Analysis:** Static analysis for bugs and performance issues
- **Security:** Dependency vulnerability scanning

### Automated Testing
- **Unit Tests:** All `test/` directory tests
- **Integration Tests:** End-to-end testing (when configured)
- **Coverage:** Code coverage reporting

### Multi-Platform Building
- **Web:** Optimized web build for deployment
- **Android:** APK generation for Android devices
- **iOS:** iOS build (when running on macOS runners)

### Deployment Options

#### Option 1: GitHub Pages
```yaml
# Automatically deploys to GitHub Pages
# Access at: https://yourusername.github.io/Guideian
```

#### Option 2: Vercel
```yaml
# Deploy to Vercel with custom domain
# Requires VERCEL_TOKEN, ORG_ID, PROJECT_ID secrets
```

#### Option 3: Firebase Hosting
```yaml
# Deploy to Firebase Hosting
# Requires FIREBASE_SERVICE_ACCOUNT_GUIDEIAN_B5EB4 secret
```

## Monitoring and Notifications

### GitHub Actions Dashboard
- View all workflow runs in the **Actions** tab
- See detailed logs for each step
- Monitor build status and deployment history

### Branch Protection Rules (Recommended)
1. **Go to Settings → Branches**
2. **Add rule for `main` branch**
3. **Enable:**
   - Require status checks to pass before merging
   - Require branches to be up to date before merging
   - Select "test" and "build-web" checks

### Slack/Discord Notifications (Optional)
Add webhook notifications for build status:

```yaml
- name: Notify Slack
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

## Local Development

### Pre-commit Hooks
Install pre-commit hooks for local quality checks:

```bash
# Install pre-commit
pip install pre-commit

# Install hooks
pre-commit install

# Run on all files
pre-commit run --all-files
```

### Manual Testing
```bash
# Run tests locally
cd guideian_app
flutter test

# Check formatting
flutter format --dry-run --set-exit-if-changed .

# Analyze code
flutter analyze

# Build web app
flutter build web --release
```

##Performance Monitoring

### Lighthouse CI (Optional)
Add Lighthouse performance testing:

```yaml
- name: Lighthouse CI
  uses: treosh/lighthouse-ci-action@v9
  with:
    urls: |
      https://your-app-url.com
    uploadArtifacts: true
    temporaryPublicStorage: true
```

## Customization

### Environment-Specific Builds
```yaml
- name: Build for environment
  run: |
    cd guideian_app
    flutter build web --release --dart-define=ENV=production
```

### Custom Test Commands
```yaml
- name: Run specific tests
  run: |
    cd guideian_app
    flutter test test/widget_test.dart
    flutter test test/integration_test.dart
```

### Multiple Deployment Targets
```yaml
- name: Deploy to staging
  if: github.ref == 'refs/heads/develop'
  
- name: Deploy to production
  if: github.ref == 'refs/heads/main'
```

## Troubleshooting

### Common Issues

1. **Build Failures:**
   - Check Flutter version compatibility
   - Verify all dependencies are up to date
   - Review error logs in Actions tab

2. **Deployment Issues:**
   - Verify secrets are correctly set
   - Check domain configuration
   - Ensure proper permissions

3. **Test Failures:**
   - Run tests locally first
   - Check for environment-specific issues
   - Verify test dependencies

### Debug Commands
```bash
# Check Flutter version
flutter --version

# Verify dependencies
flutter pub deps

# Clean build
flutter clean && flutter pub get
```

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/ci)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Vercel Documentation](https://vercel.com/docs)
- [Firebase Hosting Documentation](https://firebase.google.com/docs/hosting)

## Success!

Once set up, your CI/CD pipeline will:
- Automatically test every code change
- Build and deploy on successful tests
- Maintain code quality standards
- Provide fast feedback on issues
- Enable reliable, repeatable deployments

Guideian is now ready for professional development workflows
