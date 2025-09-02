import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: const Center(
        child: Text(
          'Services Screen - Coming Soon',
          style: AppTheme.heading3,
        ),
      ),
    );
  }
}
