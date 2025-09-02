import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          Text(
            'Frequently Asked Questions',
            style: AppTheme.heading2.copyWith(
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'We hope this FAQ section has addressed some of your common questions. If you have any further queries, please don\'t hesitate to reach out to us.',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.textSecondary,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          
          Row(
            children: [
              // FAQ Questions
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildFAQItem(
                      question: 'How do I know which courses are right for me?',
                      answer: 'Our intelligent course matching system analyzes your interests, academic performance, and career goals to recommend the best courses for your future.',
                    ),
                    _buildFAQItem(
                      question: 'Does Guideian handle university applications for me?',
                      answer: 'We provide comprehensive guidance and tools to help you with your applications, but the final submission is done by you to ensure accuracy.',
                    ),
                    _buildFAQItem(
                      question: 'How does Subject Selection Support work?',
                      answer: 'Our subject selection tool uses your interests, strengths, and career aspirations to recommend the optimal subject combination for your educational journey.',
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 64),
              
              // FAQ Image
              if (MediaQuery.of(context).size.width > 768)
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppTheme.surfaceColor,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.help_outline,
                        size: 120,
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 64),
          
          // Contact Prompt
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Still have questions?',
                        style: AppTheme.heading3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please write to our friendly support team.',
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    textStyle: AppTheme.buttonText.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  child: const Text('Send Mail'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: AppTheme.heading4.copyWith(
          fontSize: 18,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
