import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_theme.dart';
import '../utils/app_routes.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Row(
        children: [
          // Hero Content
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TAKE CHARGE OF YOUR FUTURE TODAY!',
                  style: AppTheme.heading1.copyWith(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Allow us to help you explore career paths that excite you and match your strengths. We\'ll guide you to find what fits you best, step by step. Get ready for university with confidence, all in one place.',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.signup),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                        textStyle: AppTheme.buttonText.copyWith(fontSize: 18),
                      ),
                      child: const Text('Get Started'),
                    ),
                    const SizedBox(width: 24),
                    OutlinedButton.icon(
                      onPressed: () => context.go(AppRoutes.about),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Learn More'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                        textStyle: AppTheme.buttonText.copyWith(
                          fontSize: 18,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Hero Image
          if (MediaQuery.of(context).size.width > 768)
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 500,
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: AppTheme.primaryGradient,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.school,
                            size: 120,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Overlay Image
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white.withOpacity(0.9),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.rocket_launch,
                            size: 80,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ),
                    ),

                    // Floating Elements
                    Positioned(
                      top: 40,
                      left: 40,
                      child: _buildFloatingCard(
                        icon: Icons.trending_up,
                        text: 'Career Growth',
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 120,
                      right: 60,
                      child: _buildFloatingCard(
                        icon: Icons.psychology,
                        text: 'Smart Guidance',
                        color: AppTheme.accentColor,
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      left: 60,
                      child: _buildFloatingCard(
                        icon: Icons.verified,
                        text: 'Expert Advice',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingCard({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: color == Colors.white ? AppTheme.primaryColor : Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTheme.bodySmall.copyWith(
              color:
                  color == Colors.white ? AppTheme.primaryColor : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
