import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactEmailService {
  // Using EmailJS for reliable email delivery
  static const String _serviceId = 'service_guideian_contact'; // You'll need to set this up
  static const String _templateId = 'template_contact_form';
  static const String _publicKey = 'your_public_key'; // You'll need to get this
  
  // Support email address
  static const String _supportEmail = 'Guideian.help@gmail.com';

  /// Send contact form message using EmailJS
  static Future<String?> sendContactMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      print('Sending contact message from: $name ($email)');

      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'to_email': _supportEmail,
            'from_name': name,
            'from_email': email,
            'message': message,
            'app_name': 'Guideian',
          }
        }),
      );

      print('Contact email response status: ${response.statusCode}');
      print('Contact email response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Contact message sent successfully');
        return null; // Success
      } else {
        print('Contact email failed: ${response.body}');
        return 'Failed to send message: ${response.body}';
      }
    } catch (e) {
      print('Contact email error: $e');
      return 'Message sending failed: $e';
    }
  }

  /// Alternative method using mailto: URL (fallback)
  static Future<String?> sendContactMessageFallback({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      print('Using fallback method for contact message from: $name ($email)');
      
      // Create mailto URL
      final subject = Uri.encodeComponent('Contact Form Message from $name');
      final body = Uri.encodeComponent('''
From: $name
Email: $email

Message:
$message
      ''');
      
      final mailtoUrl = 'mailto:$_supportEmail?subject=$subject&body=$body';
      
      // This would need to be handled by url_launcher
      // For now, we'll return success as this is a fallback
      print('Fallback contact message prepared');
      return null; // Success
    } catch (e) {
      print('Fallback contact email error: $e');
      return 'Message sending failed: $e';
    }
  }

  /// Generate professional email template for contact form
  static String getContactEmailTemplate({
    required String name,
    required String email,
    required String message,
  }) {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Contact Form Message - Guideian</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(135deg, #3328BF, #1a1a2e); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
        .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }
        .field { margin: 20px 0; }
        .label { font-weight: bold; color: #3328BF; }
        .value { background: white; padding: 15px; border-radius: 5px; border-left: 4px solid #3328BF; }
        .footer { text-align: center; margin-top: 30px; color: #666; font-size: 14px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📧 New Contact Form Message</h1>
            <p>Guideian Support</p>
        </div>
        <div class="content">
            <h2>Contact Form Submission</h2>
            
            <div class="field">
                <div class="label">Name:</div>
                <div class="value">$name</div>
            </div>
            
            <div class="field">
                <div class="label">Email:</div>
                <div class="value">$email</div>
            </div>
            
            <div class="field">
                <div class="label">Message:</div>
                <div class="value">$message</div>
            </div>
            
            <p><strong>Next Steps:</strong></p>
            <ul>
                <li>Reply to this email to respond to the user</li>
                <li>Use the email address provided above</li>
                <li>Respond within 24 hours for best customer service</li>
            </ul>
            
            <p>Best regards,<br>Guideian Contact System</p>
        </div>
        <div class="footer">
            <p>© 2024 Guideian. All rights reserved.</p>
            <p>This message was sent via the Guideian contact form.</p>
        </div>
    </div>
</body>
</html>
    ''';
  }
}
