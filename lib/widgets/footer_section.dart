import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_theme.dart';
import '../utils/app_routes.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guideian',
                      style: AppTheme.heading3.copyWith(
                        color: Colors.white,
                        fontFamily: 'TenorSans',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Future Ready',
                      style: AppTheme.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: 'TenorSans',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your roadmap to a bright future. We help South African students navigate their educational journey from high school to university.',
                      style: AppTheme.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _buildSocialIcon(Icons.facebook),
                        const SizedBox(width: 16),
                        _buildSocialIcon(Icons.twitter),
                        const SizedBox(width: 16),
                        _buildSocialIcon(Icons.linkedin),
                        const SizedBox(width: 16),
                        _buildSocialIcon(Icons.instagram),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 64),
              
              // Quick Links Column
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Links',
                      style: AppTheme.heading4.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFooterLink(context, 'Home', AppRoutes.home),
                    _buildFooterLink(context, 'Services', AppRoutes.services),
                    _buildFooterLink(context, 'About Us', AppRoutes.about),
                    _buildFooterLink(context, 'Contact Us', AppRoutes.contact),
                    _buildFooterLink(context, 'Sign Up', AppRoutes.signup),
                  ],
                ),
              ),
              
              const SizedBox(width: 64),
              
              // Contact Column
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: AppTheme.heading4.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildContactInfo(Icons.location_on, 'Cape Town, South Africa'),
                    _buildContactInfo(Icons.email, 'guideian.help@gmail.com'),
                    _buildContactInfo(Icons.phone, '+27 81 487 5688'),
                  ],
                ),
              ),
              
              const SizedBox(width: 64),
              
              // CTA Column
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s start your journey now!',
                      style: AppTheme.heading4.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.signup),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        textStyle: AppTheme.buttonText,
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 64),
          const Divider(color: Colors.white24),
          const SizedBox(height: 24),
          
          // Copyright
          Text(
            'Copyright @ 2025 Guideian, All rights reserved.',
            style: AppTheme.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.6),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildFooterLink(BuildContext context, String text, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => context.go(route),
        child: Text(
          text,
          style: AppTheme.bodyMedium.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.6),
            size: 16,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
