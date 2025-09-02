import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: const Center(
        child: Text(
          'Contact Us Screen - Coming Soon',
          style: AppTheme.heading3,
        ),
      ),
    );
  }
}
