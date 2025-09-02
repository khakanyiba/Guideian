import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  int _currentIndex = 0;

  final List<Map<String, String>> _testimonials = [
    {
      'name': 'Sarah Johnson',
      'role': 'Grade 12 Student',
      'content': 'Guideian helped me discover my passion for computer science. The subject selection process was so easy and personalized!',
      'image': 'assets/images/testimonial1.jpg',
    },
    {
      'name': 'Michael Chen',
      'role': 'University Freshman',
      'content': 'Thanks to Guideian, I got accepted into my dream university. The application guidance was invaluable.',
      'image': 'assets/images/testimonial2.jpg',
    },
    {
      'name': 'Emily Rodriguez',
      'role': 'High School Graduate',
      'content': 'The career guidance tools helped me understand what I really wanted to study. Highly recommended!',
      'image': 'assets/images/testimonial3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          // Header
          Text(
            'What Our Students Say',
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Hear from students who have transformed their educational journey with Guideian.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              height: 1.5,
              color: const Color(0xFF808080),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // Testimonial Card
          isMobile ? _buildMobileTestimonial() : _buildDesktopTestimonial(),
        ],
      ),
    );
  }

  Widget _buildDesktopTestimonial() {
    return Row(
      children: [
        // Navigation Arrow
        IconButton(
          onPressed: () {
            setState(() {
              _currentIndex = (_currentIndex - 1 + _testimonials.length) % _testimonials.length;
            });
          },
          icon: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF3328BF),
            ),
          ),
        ),
        const SizedBox(width: 40),

        // Testimonial Content
        Expanded(
          child: _buildTestimonialCard(_testimonials[_currentIndex]),
        ),

        const SizedBox(width: 40),

        // Navigation Arrow
        IconButton(
          onPressed: () {
            setState(() {
              _currentIndex = (_currentIndex + 1) % _testimonials.length;
            });
          },
          icon: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Color(0xFF3328BF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTestimonial() {
    return Column(
      children: [
        _buildTestimonialCard(_testimonials[_currentIndex]),
        const SizedBox(height: 32),
        
        // Navigation Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _testimonials.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? const Color(0xFF3328BF)
                      : const Color(0xFFD6D6D6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          // Quote Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF3328BF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.format_quote,
              color: Color(0xFF3328BF),
              size: 32,
            ),
          ),
          const SizedBox(height: 32),

          // Testimonial Text
          Text(
            testimonial['content']!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              height: 1.6,
              color: const Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Author Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9E9E9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF3328BF),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Name and Role
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial['name']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0D0D0D),
                    ),
                  ),
                  Text(
                    testimonial['role']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color(0xFF808080),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
