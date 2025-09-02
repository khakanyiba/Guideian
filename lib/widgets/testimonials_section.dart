import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          // Section Header
          Text(
            'Testimonial',
            style: AppTheme.caption.copyWith(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Experiences Shared by Our Clients',
            style: AppTheme.heading2.copyWith(
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          
          // Testimonial Card
          Container(
            maxWidth: 800,
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Quote Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.format_quote,
                    size: 32,
                    color: AppTheme.secondaryColor,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Testimonial Text
                Text(
                  'This platform made my course application process so easy! Everything was clear, and I got instant updates on my application status. Highly recommended!',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textSecondary,
                    textAlign: TextAlign.center,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Author Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Author Avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Author Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lebo M.',
                          style: AppTheme.heading4.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Business Management Student',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
