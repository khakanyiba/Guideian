import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      color: const Color(0xFFE9E9E9),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 15 : 15,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Text(
                'Guideian, your roadmap to a bright future',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.96,
                  color: const Color(0xFF0D0D0D),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                'At Guideian, we\'re dedicated to simplifying your journey from high school to university. Our goal is to help you explore career paths that inspire you, choose courses that suit your ambitions, and apply to universities with ease and confidence. With expert guidance and tailored tools, we\'re here to ensure you\'re ready for a future that matches your potential.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  height: 1.5,
                  color: const Color(0xFF808080),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
