import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_theme.dart';
import '../utils/app_routes.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          // Section Title
          Text(
            'Our Services',
            style: AppTheme.heading2.copyWith(
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tools to Shape Your Tomorrow',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.textSecondary,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),

          // Services Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 768 ? 4 : 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.8,
            children: [
              _buildServiceCard(
                context,
                icon: Icons.subject,
                title: 'Assisted Subject Selection',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: AppRoutes.subjectSelection,
                isAvailable: true,
              ),
              _buildServiceCard(
                context,
                icon: Icons.school,
                title: 'High School Navigation',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: AppRoutes.home,
                isAvailable: false,
              ),
              _buildServiceCard(
                context,
                icon: Icons.auto_awesome,
                title: 'Automated Application',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: AppRoutes.home,
                isAvailable: false,
              ),
              _buildServiceCard(
                context,
                icon: Icons.search,
                title: 'Course Selection Assistance',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: AppRoutes.courseFinder,
                isAvailable: true,
              ),
              _buildServiceCard(
                context,
                icon: Icons.monetization_on,
                title: 'Bursary Application Support',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: AppRoutes.home,
                isAvailable: false,
              ),
              _buildServiceCard(
                context,
                icon: Icons.trending_up,
                title: 'Progress Monitoring & Motivation',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: AppRoutes.home,
                isAvailable: false,
              ),
              _buildServiceCard(
                context,
                icon: Icons.explore,
                title: 'Career Exploration Tools',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: AppRoutes.home,
                isAvailable: false,
              ),
              _buildServiceCard(
                context,
                icon: Icons.chat,
                title: 'AI Chatbot Support',
                description:
                    'Get instant answers to your questions about education and careers.',
                route: AppRoutes.home,
                isAvailable: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String route,
    required bool isAvailable,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isAvailable
              ? AppTheme.primaryGradient
              : LinearGradient(
                  colors: [
                    AppTheme.surfaceColor,
                    AppTheme.surfaceColor,
                  ],
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isAvailable ? Colors.white : AppTheme.textLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 32,
                color: isAvailable
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: AppTheme.heading4.copyWith(
                color: isAvailable ? Colors.white : AppTheme.textPrimary,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              description,
              style: AppTheme.bodySmall.copyWith(
                color: isAvailable
                    ? Colors.white.withOpacity(0.9)
                    : AppTheme.textSecondary,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            // Action Button
            if (isAvailable)
              ElevatedButton(
                onPressed: () => context.go(route),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: AppTheme.buttonText.copyWith(
                    color: AppTheme.primaryColor,
                    fontSize: 14,
                  ),
                ),
                child: const Text('Try Now'),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.textLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Coming Soon',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
