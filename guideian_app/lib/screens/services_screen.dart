import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/navbar.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

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
                    'Our Services',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D0D0D),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Comprehensive educational guidance and support services',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF808080),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  _buildServicesGrid(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {
        'title': 'Subject Selection',
        'description': 'Get personalized recommendations for your academic subjects based on your interests and goals.',
        'icon': Icons.school,
        'route': '/subject-selection',
        'available': true,
      },
      {
        'title': 'Course Finder',
        'description': 'Discover courses and programs that align with your career aspirations.',
        'icon': Icons.search,
        'route': '/coming-soon',
        'available': false,
      },
      {
        'title': 'Career Guidance',
        'description': 'Explore career paths and get advice on how to achieve your professional goals.',
        'icon': Icons.work,
        'route': '/coming-soon',
        'available': false,
      },
      {
        'title': 'Study Planning',
        'description': 'Create effective study schedules and learning strategies tailored to your needs.',
        'icon': Icons.calendar_today,
        'route': '/coming-soon',
        'available': false,
      },
      {
        'title': 'University Prep',
        'description': 'Prepare for university applications and entrance requirements.',
        'icon': Icons.account_balance,
        'route': '/coming-soon',
        'available': false,
      },
      {
        'title': 'Skill Assessment',
        'description': 'Evaluate your strengths and identify areas for improvement.',
        'icon': Icons.assessment,
        'route': '/coming-soon',
        'available': false,
      },
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.2,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          final isAvailable = service['available'] as bool;

          return Card(
            elevation: 2,
            child: InkWell(
              onTap: isAvailable
                  ? () => context.go(service['route'] as String)
                  : () => context.go('/coming-soon'),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Icon(
                          service['icon'] as IconData,
                          size: 48,
                          color: isAvailable 
                              ? const Color(0xFF3328BF) 
                              : Colors.grey.shade400,
                        ),
                        if (!isAvailable)
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Soon',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange.shade700,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      service['title'] as String,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isAvailable 
                            ? const Color(0xFF0D0D0D) 
                            : Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['description'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: isAvailable 
                            ? const Color(0xFF808080) 
                            : Colors.grey.shade500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}