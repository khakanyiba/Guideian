import 'package:flutter/material.dart';

class FAQSection extends StatelessWidget {
  final VoidCallback? onSendMailTap;

  const FAQSection({
    super.key,
    this.onSendMailTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: isMobile ? 60 : 80, horizontal: isMobile ? 20 : 80),
      child: Column(
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.96,
              color: const Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'We hope this FAQ section has addressed some of your common questions. If you have any further queries, please don\'t hesitate to reach out to us.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Color(0xFF808080),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          if (isMobile) ...[
            // Mobile FAQ - single column
            Column(
              children: [
                _buildFAQItem('How do I know which courses are right for me?'),
                const SizedBox(height: 20),
                _buildFAQItem(
                    'Does Guideian handle university applications for me?'),
                const SizedBox(height: 20),
                _buildFAQItem('How does Subject Selection Support work?'),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFE9E9E9),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.support_agent,
                      size: 60,
                      color: Color(0xFF3328BF),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            // Desktop FAQ - row layout
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildFAQItem(
                          'How do I know which courses are right for me?'),
                      const SizedBox(height: 20),
                      _buildFAQItem(
                          'Does Guideian handle university applications for me?'),
                      const SizedBox(height: 20),
                      _buildFAQItem('How does Subject Selection Support work?'),
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFE9E9E9),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.support_agent,
                        size: 80,
                        color: Color(0xFF3328BF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Still have question?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D0D0D),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please write to our friendly support team.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF808080),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: onSendMailTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3328BF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Send Mail',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0D0D0D),
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF3328BF),
          ),
        ],
      ),
    );
  }
}
