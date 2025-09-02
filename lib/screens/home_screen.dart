import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/guideian_app_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/services_section.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/pricing_section.dart';
import '../widgets/faq_section.dart';
import '../widgets/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize auth provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 80,
            floating: true,
            pinned: true,
            backgroundColor: AppTheme.backgroundColor,
            elevation: 0,
            flexibleSpace: const GuideianAppBar(),
          ),

          // Hero Section
          const SliverToBoxAdapter(
            child: HeroSection(),
          ),

          // About Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                children: [
                  Text(
                    'Guideian, your roadmap to a bright future',
                    style: AppTheme.heading2.copyWith(
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'At Guideian, we\'re dedicated to simplifying your journey from high school to university. Our goal is to help you explore career paths that inspire you, choose courses that suit your ambitions, and apply to universities with ease and confidence. With expert guidance and tailored tools, we\'re here to ensure you\'re ready for a future that matches your potential.',
                    style: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textSecondary,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Services Section
          const SliverToBoxAdapter(
            child: ServicesSection(),
          ),

          // Demo Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                children: [
                  Text(
                    'Experience Guideian',
                    style: AppTheme.heading2.copyWith(
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Watch how our platform makes educational planning and university applications simple, intuitive, and effective. This is just the tip of the iceberg, sign up and explore it yourself!',
                    style: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textSecondary,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.surfaceColor,
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: 64,
                            color: AppTheme.secondaryColor,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Demo Video Coming Soon',
                            style: AppTheme.heading4,
                          ),
                        ],
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: Column(
                children: [
                  Text(
                    'Working with Institutions Nationwide',
                    style: AppTheme.heading2.copyWith(
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'We\'ve partnered with all 26 universities and 50 TVET colleges nationwide to drive our mission of advancing education and skills. These collaborations enhance access, resource-sharing, and innovation.',
                    style: AppTheme.bodyLarge.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMetricCard('26', 'Public Universities'),
                      _buildMetricCard('76', 'TVET Colleges'),
                      _buildMetricCard('8K+', 'Total Courses'),
                      _buildMetricCard('40', 'Bursaries'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Testimonials Section
          const SliverToBoxAdapter(
            child: TestimonialsSection(),
          ),

          // Pricing Section
          const SliverToBoxAdapter(
            child: PricingSection(),
          ),

          // FAQ Section
          const SliverToBoxAdapter(
            child: FAQSection(),
          ),

          // Footer
          const SliverToBoxAdapter(
            child: FooterSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: AppTheme.heading1.copyWith(
            color: Colors.white,
            fontSize: 48,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(
            color: Colors.white.withOpacity(0.9),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
