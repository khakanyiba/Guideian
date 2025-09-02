import 'package:flutter/material.dart';

class DemoSection extends StatelessWidget {
  const DemoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: isMobile ? 40 : 46, horizontal: isMobile ? 20 : 80),
      child: Column(
        children: [
          Text(
            'Experience Guideian',
            style: TextStyle(
              fontSize: isMobile ? 24 : 31,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0D0D0D),
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            'Watch how our platform make educational planning and university applications simple, intuitive, and effective. This is just the tip of the iceberg, sign up and explore it yourself!',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF4B5563),
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Container(
            width: double.infinity,
            height: isMobile ? 250 : 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFE9E9E9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Color(0xFF3328BF),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Demo Video Coming Soon',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D0D0D),
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



