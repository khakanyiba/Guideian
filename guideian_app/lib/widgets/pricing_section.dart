import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Choose your plan',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          Row(
            children: [
              Expanded(
                  child: _buildPricingCard(
                planName: 'Free',
                price: 'R0',
                isPopular: false,
                features: [
                  _PricingFeature('Access to Chatbot', true),
                  _PricingFeature('Access to Calendar', true),
                  _PricingFeature('High school Navigation', true),
                  _PricingFeature('Subject Selection', false),
                  _PricingFeature('Limited access to Guidian Resourses', false),
                  _PricingFeature('2 Free Applications', false),
                ],
                buttonText: 'Already Using',
                buttonColor: const Color(0xFFE9ECEF),
                textColor: const Color(0xFF666666),
              )),
              const SizedBox(width: 24),
              Expanded(
                  child: _buildPricingCard(
                planName: 'Standard',
                price: 'R99.99',
                isPopular: true,
                features: [
                  _PricingFeature('Access to Chatbot', true),
                  _PricingFeature('Access to Calendar', true),
                  _PricingFeature('High school Navigation', true),
                  _PricingFeature('Subject Selection', true),
                  _PricingFeature('Course Exploration tool', true),
                  _PricingFeature('Course Selection', true),
                  _PricingFeature('2 Free Applications', false),
                  _PricingFeature('Limited access to Guidian Resourses', false),
                ],
                buttonText: 'Get Now',
                buttonColor: const Color(0xFF3328BF),
                textColor: Colors.white,
              )),
              const SizedBox(width: 24),
              Expanded(
                  child: _buildPricingCard(
                planName: 'Premium',
                price: 'R199.99',
                isPopular: false,
                features: [
                  _PricingFeature('Access to Chatbot', true),
                  _PricingFeature('Access to Calendar', true),
                  _PricingFeature('High school Navigation', true),
                  _PricingFeature('Subject Selection', true),
                  _PricingFeature('Course Exploration tool', true),
                  _PricingFeature('Course Selection', false),
                  _PricingFeature('Automated Application', false),
                  _PricingFeature('Limited access to Guidian Resourses', false),
                ],
                buttonText: 'Get Now',
                buttonColor: const Color(0xFF3328BF),
                textColor: Colors.white,
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard({
    required String planName,
    required String price,
    required bool isPopular,
    required List<_PricingFeature> features,
    required String buttonText,
    required Color buttonColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPopular ? const Color(0xFF3328BF) : const Color(0xFFE9ECEF),
          width: isPopular ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (isPopular)
            Positioned(
              top: -12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3328BF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Most popular',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isPopular ? 20 : 0),
              // Plan name and price
              Text(
                planName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0D0D0D),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0D0D0D),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '/mo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Features list
              ...features.map((feature) => _buildFeatureItem(feature)),
              const SizedBox(height: 32),
              // Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(_PricingFeature feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            feature.isIncluded ? Icons.check_circle : Icons.cancel,
            size: 20,
            color: feature.isIncluded
                ? const Color(0xFF3328BF)
                : const Color(0xFF666666),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature.text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PricingFeature {
  final String text;
  final bool isIncluded;

  _PricingFeature(this.text, this.isIncluded);
}
