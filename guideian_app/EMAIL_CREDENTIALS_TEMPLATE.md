# 📧 Email Service Credentials Template

## 🔑 Your EmailJS Credentials

After setting up EmailJS, update these values in `guideian_app/lib/services/contact_email_service.dart`:

```dart
// Replace these placeholder values with your actual EmailJS credentials
static const String _serviceId = 'service_xxxxxxxxx'; // Your Service ID from EmailJS
static const String _templateId = 'template_xxxxxxxxx'; // Your Template ID from EmailJS  
static const String _publicKey = 'xxxxxxxxxxxxxxxx'; // Your Public Key from EmailJS
```

## 📝 Where to Find These Values

### Service ID
- Go to EmailJS Dashboard → Email Services
- Find your Gmail service
- Copy the Service ID (starts with `service_`)

### Template ID  
- Go to EmailJS Dashboard → Email Templates
- Find your contact form template
- Copy the Template ID (starts with `template_`)

### Public Key
- Go to EmailJS Dashboard → Account → API Keys
- Copy your Public Key (long string of letters/numbers)

## ✅ Quick Checklist

- [ ] Created EmailJS account with gguideian@gmail.com
- [ ] Connected Gmail service
- [ ] Created email template
- [ ] Copied Service ID
- [ ] Copied Template ID  
- [ ] Copied Public Key
- [ ] Updated contact_email_service.dart
- [ ] Tested contact form
- [ ] Received test email at gguideian@gmail.com

## 🚨 Important Notes

- Keep these credentials secure
- Don't commit them to public repositories
- The email service will send to: **gguideian@gmail.com**
- Free plan includes 200 emails/month

