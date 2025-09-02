import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/navbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Navbar(
            onHomeTap: () => context.go('/'),
            onServicesTap: () => context.go('/services'),
            onAboutTap: () => context.go('/about'),
            onContactTap: () => context.go('/contact'),
            onLoginTap: () => context.go('/login'),
            onSignupTap: () => context.go('/signup'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const Text(
                    'About Guideian',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D0D0D),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your roadmap to a bright future',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF808080),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  _buildMissionSection(),
                  const SizedBox(height: 48),
                  _buildValuesSection(),
                  const SizedBox(height: 48),
                  _buildTeamSection(),
                  const SizedBox(height: 48),
                  _buildStatsSection(context), // Pass context here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF3328BF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.lightbulb,
                  size: 64,
                  color: const Color(0xFF3328BF),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Our Mission',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0D0D0D),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'At Guideian, we believe every student deserves personalized guidance to unlock their full potential. We\'re dedicated to making quality educational counseling accessible to all, helping students make informed decisions about their academic journey and future career paths.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF808080),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection() {
    final values = [
      {
        'icon': Icons.school,
        'title': 'Educational Excellence',
        'description': 'We strive to provide the highest quality guidance based on current educational standards and industry trends.',
      },
      {
        'icon': Icons.person,
        'title': 'Personalized Approach',
        'description': 'Every student is unique, and our recommendations are tailored to individual interests, strengths, and goals.',
      },
      {
        'icon': Icons.accessibility,
        'title': 'Accessibility',
        'description': 'Quality educational guidance should be available to everyone, regardless of background or circumstances.',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Future-Ready',
        'description': 'We focus on preparing students for the careers and challenges of tomorrow, not just today.',
      },
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Column(
        children: [
          const Text(
            'Our Core Values',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.3,
            ),
            itemCount: values.length,
            itemBuilder: (context, index) {
              final value = values[index];
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      value['icon'] as IconData,
                      size: 40,
                      color: const Color(0xFF3328BF),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      value['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0D0D0D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      value['description'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF808080),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          const Text(
            'Meet Our Team',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'Our team consists of experienced educators, career counselors, and technology experts who are passionate about helping students succeed. We combine decades of educational experience with cutting-edge technology to provide the best possible guidance.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF808080),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTeamMember('Education Specialists', Icons.school),
              _buildTeamMember('Career Counselors', Icons.work),
              _buildTeamMember('Tech Experts', Icons.code),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String role, IconData icon) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF3328BF).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 36,
            color: const Color(0xFF3328BF),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          role,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D0D0D),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) { // Accept context as parameter
    final stats = [
      {'number': '1000+', 'label': 'Students Guided'},
      {'number': '50+', 'label': 'Subjects Covered'},
      {'number': '95%', 'label': 'Success Rate'},
      {'number': '24/7', 'label': 'Support Available'},
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        children: [
          const Text(
            'Our Impact',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: stats.map((stat) {
              return Column(
                children: [
                  Text(
                    stat['number']!,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3328BF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    stat['label']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF808080),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.go('/contact'), // Now context is available
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3328BF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}