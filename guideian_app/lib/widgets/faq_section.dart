import 'package:flutter/material.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Frequently Asked Questions',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3328BF),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Find answers to common questions about our services',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          _buildFAQList(context),
        ],
      ),
    );
  }

  Widget _buildFAQList(BuildContext context) {
    final faqs = [
      {
        'question': 'How does the course finder work?',
        'answer': 'Our course finder uses advanced algorithms to match your interests, skills, and career goals with the most suitable academic programs and courses available.',
      },
      {
        'question': 'Is the basic plan really free?',
        'answer': 'Yes! Our basic plan provides access to fundamental features including course recommendations and community access at no cost.',
      },
      {
        'question': 'How qualified are your mentors?',
        'answer': 'All our mentors are industry professionals with years of experience in their respective fields. They undergo a rigorous selection process.',
      },
      {
        'question': 'Can I change my plan later?',
        'answer': 'Absolutely! You can upgrade or downgrade your plan at any time. Changes take effect immediately.',
      },
      {
        'question': 'Do you offer refunds?',
        'answer': 'Yes, we offer a 30-day money-back guarantee for all paid plans if you\'re not completely satisfied.',
      },
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        children: faqs.asMap().entries.map((entry) {
          final index = entry.key;
          final faq = entry.value;
          return _buildFAQItem(context, faq, index);
        }).toList(),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, Map<String, String> faq, int index) {
    final isExpanded = expandedIndex == index;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExpansionTile(
          title: Text(
            faq['question']!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C3E50),
            ),
          ),
          trailing: Icon(
            isExpanded ? Icons.remove : Icons.add,
            color: const Color(0xFF3328BF),
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              expandedIndex = expanded ? index : null;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                faq['answer']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}