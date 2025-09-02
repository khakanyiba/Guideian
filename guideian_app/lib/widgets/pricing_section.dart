import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Choose Your Plan',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3328BF),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Flexible pricing options to suit your needs',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          _buildPricingCards(context),
        ],
      ),
    );
  }

  Widget _buildPricingCards(BuildContext context) {
    final plans = [
      {
        'name': 'Basic',
        'price': 'Free',
        'period': '',
        'features': [
          'Course recommendations',
          'Basic career guidance',
          'Community access',
          'Limited mentor sessions',
        ],
        'isPopular': false,
        'color': Colors.grey[100],
      },
      {
        'name': 'Premium',
        'price': '\$29',
        'period': '/month',
        'features': [
          'Everything in Basic',
          'Unlimited mentor sessions',
          'Priority support',
          'Advanced analytics',
          'Custom study plans',
        ],
        'isPopular': true,
        'color': const Color(0xFF3328BF).withOpacity(0.1),
      },
      {
        'name': 'Pro',
        'price': '\$59',
        'period': '/month',
        'features': [
          'Everything in Premium',
          '1-on-1 career coaching',
          'Industry partnerships',
          'Exclusive events',
          'Job placement assistance',
        ],
        'isPopular': false,
        'color': Colors.grey[100],
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1000 ? 3 : 1;
        
        if (crossAxisCount == 1) {
          return Column(
            children: plans.map((plan) => 
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: _buildPricingCard(context, plan),
              ),
            ).toList(),
          );
        }
        
        return Row(
          children: plans.map((plan) => 
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildPricingCard(context, plan),
              ),
            ),
          ).toList(),
        );
      },
    );
  }

  Widget _buildPricingCard(BuildContext context, Map<String, dynamic> plan) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: plan['color'] as Color?,
        borderRadius: BorderRadius.circular(16),
        border: plan['isPopular'] as bool
            ? Border.all(color: const Color(0xFF3328BF), width: 2)
            : Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: plan['isPopular'] as bool
            ? [
                BoxShadow(
                  color: const Color(0xFF3328BF).withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          if (plan['isPopular'] as bool)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3328BF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Most Popular',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          if (plan['isPopular'] as bool) const SizedBox(height: 20),
          Text(
            plan['name'] as String,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan['price'] as String,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3328BF),
                ),
              ),
              Text(
                plan['period'] as String,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Column(
            children: (plan['features'] as List<String>).map((feature) =>
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF27AE60),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).toList(),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: plan['isPopular'] as bool
                    ? const Color(0xFF3328BF)
                    : Colors.white,
                foregroundColor: plan['isPopular'] as bool
                    ? Colors.white
                    : const Color(0xFF3328BF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: plan['isPopular'] as bool
                      ? BorderSide.none
                      : const BorderSide(color: Color(0xFF3328BF)),
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}