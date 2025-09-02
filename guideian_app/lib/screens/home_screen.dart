import 'package:flutter/material.dart';
import '../widgets/guideian_app_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/services_section.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/pricing_section.dart';
import '../widgets/faq_section.dart';
import '../widgets/footer_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GuideianAppBar(),
            const HeroSection(),
            _buildAboutSection(),
            const ServicesSection(),
            _buildDemoSection(),
            _buildMetricsSection(),
            const TestimonialsSection(),
            const PricingSection(),
            const FAQSection(),
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: const Column(
        children: [
          Text(
            'Guideian, your roadmap to a bright future',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D0D0D),
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Text(
            'At Guideian, we\'re dedicated to simplifying your journey from high school to university. Our goal is to help you explore career paths that inspire you, choose courses that suit your ambitions, and apply to universities with ease and confidence. With expert guidance and tailored tools, we\'re here to ensure you\'re ready for a future that matches your potential.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDemoSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          const Text(
            'Experience Guideian',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'Watch how our platform make educational planning and university applications simple, intuitive, and effective. This is just the tip of the iceberg, sign up and explore it yourself!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.asset(
                    '../assets/kickstart image.png',
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        size: 40,
                        color: Color(0xFF3328BF),
                      ),
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

  Widget _buildMetricsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Working with Institutions Nation wide',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D0D0D),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'We\'ve partnered with all 26 universities and 50 TVET colleges nationwide to drive our mission of advancing education and skills. These collaborations enhance access, resource-sharing, and innovation. Bursaries like NSFAS and SETA funds provide essential financial support, removing barriers to tuition and living costs, ensuring broader participation and amplifying our impact.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF666666),
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 80),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard('26', 'Public Universities'),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildMetricCard('76', 'TVET Colleges'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard('8K+', 'Total Courses'),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildMetricCard('40', 'Bursaries'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String number, String label) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3328BF),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
