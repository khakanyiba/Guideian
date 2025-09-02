import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Navbar
          SliverAppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            title: Row(
              children: [
                // Logo
                CustomPaint(
                  size: const Size(217, 55),
                  painter: GuideianLogoPainter(),
                ),
                const Spacer(),
                // Navigation links
                Row(
                  children: [
                    _NavLink(text: 'Home', isActive: true, onTap: () {}),
                    _NavLink(text: 'Services', onTap: () => context.go('/services')),
                    _NavLink(text: 'About Us', onTap: () => context.go('/about')),
                    _NavLink(text: 'Contact us', onTap: () => context.go('/contact')),
                  ],
                ),
                const Spacer(),
                // Auth buttons
                Row(
                  children: [
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFF3328BF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/signup'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3328BF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Hero Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
              color: const Color(0xFFF8F9FC),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TAKE CHARGE OF YOUR FUTURE TODAY!',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Allow us to help you explore career paths that excite you and '
                          'match your strengths. We\'ll guide you to find what fits you '
                          'best, step by step. Get ready for university with confidence, '
                          'all in one place.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF666666),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => context.go('/signup'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3328BF),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton(
                              onPressed: () => context.go('/about'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF3328BF),
                                side: const BorderSide(color: Color(0xFF3328BF)),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Text('Learn More'),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, size: 18),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 60),
                  // Hero image
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6E9FA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.school,
                            size: 100,
                            color: Color(0xFF3328BF),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Container(
                            width: 200,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.assignment_turned_in,
                              size: 60,
                              color: Color(0xFF3328BF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // About Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 120),
              child: const Column(
                children: [
                  Text(
                    'Guideian, your roadmap to a bright future',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'At Guideian, we\'re dedicated to simplifying your journey from high '
                    'school to university. Our goal is to help you explore career paths '
                    'that inspire you, choose courses that suit your ambitions, and apply '
                    'to universities with ease and confidence. With expert guidance and '
                    'tailored tools, we\'re here to ensure you\'re ready for a future that '
                    'matches your potential.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF666666),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // Services Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              color: const Color(0xFFF8F9FC),
              child: Column(
                children: [
                  // First row of services
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ServiceCard(
                        icon: Icons.subject,
                        title: 'Assisted Subject Selection',
                        description: 'Helping you navigate your educational journey with confidence.',
                        onTap: () => context.go('/subject-selection'),
                      ),
                      _ServiceCard(
                        icon: Icons.school,
                        title: 'High School Navigation',
                        description: 'Helping you navigate your educational journey with confidence.',
                        onTap: () => context.go('/coming-soon'),
                      ),
                      _ServiceCard(
                        icon: Icons.send,
                        title: 'Automated Application',
                        description: 'Helping you navigate your educational journey with confidence.',
                        onTap: () => context.go('/coming-soon'),
                      ),
                      _ServiceCard(
                        icon: Icons.menu_book,
                        title: 'Course Selection Assistance',
                        description: 'Helping you navigate your educational journey with confidence.',
                        onTap: () => context.go('/coming-soon'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Second row of services
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ServiceCard(
                        icon: Icons.attach_money,
                        title: 'Bursary Application Support',
                        description: 'Helping you navigate your educational journey with confidence.',
                        onTap: () => context.go('/coming-soon'),
                      ),
                      _ServiceCard(
                        icon: Icons.trending_up,
                        title: 'Progress Monitoring & Motivation',
                        description: 'Helping you navigate your educational journey with confidence.',
                        onTap: () => context.go('/coming-soon'),
                      ),
                      _ServiceCard(
                        icon: Icons.explore,
                        title: 'Career Exploration Tools',
                        description: 'Helping you navigate your educational journey with confidence.',
                        onTap: () => context.go('/coming-soon'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Demo Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 120),
              child: Column(
                children: [
                  const Text(
                    'Experience Guideian',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Watch how our platform make educational planning and university '
                    'applications simple, intuitive, and effective. This is just the tip of '
                    'the iceberg, sign up and explore it yourself!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF666666),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6E9FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 80,
                        color: Color(0xFF3328BF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Metrics Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 120),
              color: const Color(0xFFF8F9FC),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Working with Institutions Nation wide',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      const SizedBox(width: 60),
                      const Expanded(
                        child: Text(
                          'We\'ve partnered with all 26 universities and 50 TVET colleges '
                          'nationwide to drive our mission of advancing education and '
                          'skills. These collaborations enhance access, resource-sharing, '
                          'and innovation. Bursaries like NSFAS and SETA funds provide '
                          'essential financial support, removing barriers to tuition and '
                          'living costs, ensuring broader participation and amplifying our '
                          'impact.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF666666),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _MetricCard(number: '26', label: 'Public Universities'),
                      _MetricCard(number: '76', label: 'TVET Colleges'),
                      _MetricCard(number: '8K+', label: 'Total Courses'),
                      _MetricCard(number: '40', label: 'Bursaries'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Testimonial Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 120),
              child: const Column(
                children: [
                  Text(
                    'Testimonial',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3328BF),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Experiences Shared by Our Clients',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Testimonial card would go here
                ],
              ),
            ),
          ),
          // Footer
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 120),
              color: const Color(0xFF1A1A1A),
              child: Column(
                children: [
                  // Footer content would go here
                  const SizedBox(height: 40),
                  const Divider(color: Colors.white30),
                  const SizedBox(height: 20),
                  const Text(
                    'Copyright @ 2025 Guideian, All rights reserved.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
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
}

// Navigation Link Widget
class _NavLink extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.text,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? const Color(0xFF3328BF) : const Color(0xFF666666),
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// Service Card Widget
class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                icon,
                size: 48,
                color: const Color(0xFF3328BF),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: onTap,
                child: const Text(
                  'Try Now',
                  style: TextStyle(
                    color: Color(0xFF3328BF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Metric Card Widget
class _MetricCard extends StatelessWidget {
  final String number;
  final String label;

  const _MetricCard({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3328BF),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}

// Custom painter for the Guideian logo
class GuideianLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw the curved lines
    final paths = [
      Path()
        ..moveTo(55.0, 1.0)
        ..cubicTo(55.0, 1.0, 40.0, 1.0, 25.0, 1.0)
        ..cubicTo(10.0, 1.0, 0.5, 17.0, 1.0, 28.0)
        ..cubicTo(1.5, 39.0, 9.0, 52.8, 25.0, 53.0)
        ..cubicTo(41.0, 53.2, 54.0, 53.0, 54.0, 53.0)
        ..lineTo(54.0, 28.0),
      // Add other paths similarly...
    ];

    for (final path in paths) {
      canvas.drawPath(path, paint);
    }

    // Draw the text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Guideian',
        style: TextStyle(
          fontFamily: 'Tenor Sans',
          fontSize: 26,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, const Offset(63, 10));

    final subTextPainter = TextPainter(
      text: const TextSpan(
        text: 'Future Ready',
        style: TextStyle(
          fontFamily: 'Tenor Sans',
          fontSize: 13,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    subTextPainter.paint(canvas, const Offset(64, 40));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}