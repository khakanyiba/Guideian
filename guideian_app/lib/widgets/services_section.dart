import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: Column(
        children: [
          // First row of services
          Row(
            children: [
              Expanded(
                  child: _buildServiceCard(
                imagePath: '../assets/selective.png',
                title: 'Assisted Subject Selection',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: '/subject-selection',
              )),
              const SizedBox(width: 24),
              Expanded(
                  child: _buildServiceCard(
                imagePath: '../assets/career guidance.png',
                title: 'High School Navigation',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: '/coming-soon',
              )),
              const SizedBox(width: 24),
              Expanded(
                  child: _buildServiceCard(
                imagePath: '../assets/Expert-help.png',
                title: 'Automated Application',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: '/coming-soon',
              )),
              const SizedBox(width: 24),
              Expanded(
                  child: _buildServiceCard(
                imagePath: '../assets/Easy-to-use.png',
                title: 'Course Selection\nAssistance',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: '/coming-soon',
              )),
            ],
          ),
          const SizedBox(height: 24),
          // Second row of services
          Row(
            children: [
              Expanded(
                  child: _buildServiceCard(
                imagePath: '../assets/quick-response.png',
                title: 'Bursary Application Support',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: '/coming-soon',
              )),
              const SizedBox(width: 24),
              Expanded(
                  child: _buildServiceCard(
                imagePath: '../assets/time-management.png',
                title: 'Progress Monitoring &\nMotivation',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: '/coming-soon',
              )),
              const SizedBox(width: 24),
              Expanded(
                  child: _buildServiceCard(
                imagePath: '../assets/service image.png',
                title: 'Career Exploration Tools',
                description:
                    'Helping you navigate your educational journey with confidence.',
                route: '/coming-soon',
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String imagePath,
    required String title,
    required String description,
    required String route,
  }) {
    return Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE9ECEF)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D0D0D),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF666666),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => GoRouter.of(context).go(route),
              child: const Text(
                'Try Now',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3328BF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
