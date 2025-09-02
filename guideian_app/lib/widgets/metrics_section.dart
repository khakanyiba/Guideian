import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MetricsSection extends StatelessWidget {
  const MetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          // Header
          Text(
            'Why Choose Guideian?',
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Join thousands of students who have found their path with our comprehensive guidance platform.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              height: 1.5,
              color: const Color(0xFF808080),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // Metrics Grid
          isMobile ? _buildMobileMetrics() : _buildDesktopMetrics(),
        ],
      ),
    );
  }

  Widget _buildDesktopMetrics() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            '10,000+',
            'Students Helped',
            'We\'ve guided thousands of students through their educational journey.',
            Icons.people_outline,
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _buildMetricCard(
            '95%',
            'Success Rate',
            'Our students achieve their academic and career goals with confidence.',
            Icons.trending_up_outlined,
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _buildMetricCard(
            '50+',
            'Universities',
            'Partnerships with top universities across the country.',
            Icons.school_outlined,
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _buildMetricCard(
            '24/7',
            'Support',
            'Round-the-clock assistance whenever you need guidance.',
            Icons.support_agent_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMetrics() {
    return Column(
      children: [
        _buildMetricCard(
          '10,000+',
          'Students Helped',
          'We\'ve guided thousands of students through their educational journey.',
          Icons.people_outline,
        ),
        const SizedBox(height: 24),
        _buildMetricCard(
          '95%',
          'Success Rate',
          'Our students achieve their academic and career goals with confidence.',
          Icons.trending_up_outlined,
        ),
        const SizedBox(height: 24),
        _buildMetricCard(
          '50+',
          'Universities',
          'Partnerships with top universities across the country.',
          Icons.school_outlined,
        ),
        const SizedBox(height: 24),
        _buildMetricCard(
          '24/7',
          'Support',
          'Round-the-clock assistance whenever you need guidance.',
          Icons.support_agent_outlined,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String number, String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF3328BF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF3328BF),
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            number,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3328BF),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              height: 1.5,
              color: const Color(0xFF808080),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
