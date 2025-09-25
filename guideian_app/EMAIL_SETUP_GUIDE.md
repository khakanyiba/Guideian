# 📧 Complete Email Setup Guide for Guideian

This guide will walk you through setting up the email service for your Guideian contact form step by step.

## 🎯 What We're Setting Up

Your contact form will send emails to: **gguideian@gmail.com**

## 📋 Step-by-Step Setup

### Step 1: Create EmailJS Account (5 minutes)

1. **Go to EmailJS Website:**
   - Visit: https://www.emailjs.com/
   - Click "Sign Up" in the top right corner

2. **Create Your Account:**
   - Enter your email: `gguideian@gmail.com`
   - Create a password
   - Verify your email address

3. **Complete Setup:**
   - Choose "Personal" plan (free)
   - You get 200 emails/month for free

### Step 2: Add Gmail Service (3 minutes)

1. **Go to Email Services:**
   - In your EmailJS dashboard, click "Email Services"
   - Click "Add New Service"

2. **Select Gmail:**
   - Choose "Gmail" from the list
   - Click "Connect Account"

3. **Connect Your Gmail:**
   - Sign in with `gguideian@gmail.com`
   - Allow EmailJS to send emails on your behalf
   - Give your service a name: `guideian_contact`

4. **Note Your Service ID:**
   - Copy the Service ID (looks like: `service_xxxxxxxxx`)
   - You'll need this later

### Step 3: Create Email Template (5 minutes)

1. **Go to Email Templates:**
   - Click "Email Templates" in the sidebar
   - Click "Create New Template"

2. **Template Settings:**
   - **Template Name:** `contact_form_template`
   - **Subject:** `New Contact Form Message from {{from_name}}`

3. **Template Content:**
   Copy and paste this exact content:

   ```
   You have received a new message from the Guideian contact form:

   Name: {{from_name}}
   Email: {{from_email}}

   Message:
   {{message}}

   ---
   Please respond to this email to reply to the user.

   Best regards,
   Guideian Contact System
   ```

4. **Save Template:**
   - Click "Save"
   - Note your Template ID (looks like: `template_xxxxxxxxx`)

### Step 4: Get Your Public Key (2 minutes)

1. **Go to Account:**
   - Click "Account" in the sidebar
   - Scroll down to "API Keys"

2. **Copy Public Key:**
   - Copy your Public Key (looks like: `xxxxxxxxxxxxxxxx`)

### Step 5: Update Your Code (3 minutes)

1. **Open the Email Service File:**
   - Navigate to: `guideian_app/lib/services/contact_email_service.dart`

2. **Update the Credentials:**
   Replace these lines:
   ```dart
   static const String _serviceId = 'service_guideian_contact'; // You'll need to set this up
   static const String _templateId = 'template_contact_form';
   static const String _publicKey = 'your_public_key'; // You'll need to get this
   ```

   With your actual values:
   ```dart
   static const String _serviceId = 'service_xxxxxxxxx'; // Your actual service ID
   static const String _templateId = 'template_xxxxxxxxx'; // Your actual template ID
   static const String _publicKey = 'xxxxxxxxxxxxxxxx'; // Your actual public key
   ```

3. **Save the File:**
   - Save the changes
   - The email service is now configured!

### Step 6: Test the Contact Form (2 minutes)

1. **Run Your App:**
   - Start your Flutter app
   - Navigate to the Contact page

2. **Fill Out the Form:**
   - Enter your name
   - Enter your email
   - Write a test message

3. **Send the Message:**
   - Click "Send Message"
   - Wait for the success message

4. **Check Your Email:**
   - Check `gguideian@gmail.com`
   - You should receive the test message!

## 🔧 Troubleshooting

### If Emails Don't Send:

1. **Check Console Logs:**
   - Look for error messages in your app's console
   - Common issues: wrong service ID, template ID, or public key

2. **Verify EmailJS Settings:**
   - Make sure your Gmail account is properly connected
   - Check that the template exists and is active

3. **Check Spam Folder:**
   - Sometimes emails go to spam initially
   - Mark as "Not Spam" to improve delivery

### If You Get "Invalid Service" Error:

- Double-check your Service ID
- Make sure the service is active in EmailJS dashboard

### If You Get "Invalid Template" Error:

- Double-check your Template ID
- Make sure the template is saved and active

### If You Get "Invalid Public Key" Error:

- Double-check your Public Key
- Make sure you copied it correctly

## 📊 EmailJS Limits

- **Free Plan:** 200 emails per month
- **Paid Plans:** Start at $15/month for 1,000 emails
- **Upgrade:** When you need more emails, upgrade in your EmailJS dashboard

## 🎉 Success!

Once you complete these steps:

✅ **Contact form sends real emails**  
✅ **Professional email templates**  
✅ **Emails delivered to gguideian@gmail.com**  
✅ **Users get confirmation messages**  
✅ **You can reply directly to users**  

## 📞 Support

If you need help:
1. Check the troubleshooting section above
2. EmailJS has excellent documentation: https://www.emailjs.com/docs/
3. Contact EmailJS support if needed

Your contact form is now fully functional! 🚀
