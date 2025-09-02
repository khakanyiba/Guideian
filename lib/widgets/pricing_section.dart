import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          Text(
            'Choose your plan',
            style: AppTheme.heading2.copyWith(
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPricingCard(
                title: 'Free',
                price: 'R0',
                features: [
                  'Access to Chatbot',
                  'Access to Calendar',
                  'High school Navigation',
                ],
                excludedFeatures: [
                  'Subject Selection',
                  'Limited access to Guideian Resources',
                  '2 Free Applications',
                ],
                isPopular: false,
                buttonText: 'Already Using',
                onPressed: () {},
              ),
              const SizedBox(width: 24),
              _buildPricingCard(
                title: 'Standard',
                price: 'R99.99',
                features: [
                  'Access to Chatbot',
                  'Access to Calendar',
                  'High school Navigation',
                  'Subject Selection',
                  'Course Exploration tool',
                  'Course Selection',
                ],
                excludedFeatures: [
                  '2 Free Applications',
                  'Limited access to Guideian Resources',
                ],
                isPopular: true,
                buttonText: 'Get Now',
                onPressed: () {},
              ),
              const SizedBox(width: 24),
              _buildPricingCard(
                title: 'Premium',
                price: 'R199.99',
                features: [
                  'Access to Chatbot',
                  'Access to Calendar',
                  'High school Navigation',
                  'Subject Selection',
                  'Course Exploration tool',
                ],
                excludedFeatures: [
                  'Course Selection',
                  'Automated Application',
                  'Limited access to Guideian Resources',
                ],
                isPopular: false,
                buttonText: 'Get Now',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard({
    required String title,
    required String price,
    required List<String> features,
    required List<String> excludedFeatures,
    required bool isPopular,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isPopular ? AppTheme.primaryColor : AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: isPopular 
            ? Border.all(color: AppTheme.secondaryColor, width: 3)
            : Border.all(color: AppTheme.surfaceColor, width: 1),
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
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Most popular',
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (isPopular) const SizedBox(height: 16),
          
          // Title
          Text(
            title,
            style: AppTheme.heading3.copyWith(
              color: isPopular ? Colors.white : AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Price
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: AppTheme.heading1.copyWith(
                  fontSize: 48,
                  color: isPopular ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              Text(
                '/mo',
                style: AppTheme.bodyMedium.copyWith(
                  color: isPopular ? Colors.white.withOpacity(0.8) : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Features
          ...features.map((feature) => _buildFeatureItem(
            feature,
            isIncluded: true,
            isPopular: isPopular,
          )),
          
          ...excludedFeatures.map((feature) => _buildFeatureItem(
            feature,
            isIncluded: false,
            isPopular: isPopular,
          )),
          
          const SizedBox(height: 32),
          
          // Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isPopular ? Colors.white : AppTheme.primaryColor,
                foregroundColor: isPopular ? AppTheme.primaryColor : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: AppTheme.buttonText,
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature, {required bool isIncluded, required bool isPopular}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check_circle : Icons.cancel,
            color: isIncluded 
                ? (isPopular ? Colors.white : AppTheme.successColor)
                : (isPopular ? Colors.white.withOpacity(0.5) : AppTheme.errorColor),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: AppTheme.bodyMedium.copyWith(
                color: isPopular 
                    ? (isIncluded ? Colors.white : Colors.white.withOpacity(0.5))
                    : (isIncluded ? AppTheme.textPrimary : AppTheme.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
