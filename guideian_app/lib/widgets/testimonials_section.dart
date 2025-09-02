import 'package:flutter/material.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          Text(
            'What Our Students Say',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3328BF),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: _buildTestimonialsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsList() {
    final testimonials = [
      {
        'name': 'Sarah Johnson',
        'role': 'Computer Science Student',
        'content': 'Guideian helped me find the perfect university program. The guidance was invaluable!',
        'rating': 5,
      },
      {
        'name': 'Michael Chen',
        'role': 'Engineering Graduate',
        'content': 'The career advice I received changed my perspective completely. Highly recommended!',
        'rating': 5,
      },
      {
        'name': 'Emily Davis',
        'role': 'Business Student',
        'content': 'Amazing platform with excellent mentors. Found my dream course through Guideian.',
        'rating': 5,
      },
    ];

    return Column(
      children: testimonials.map((testimonial) => 
        _buildTestimonialCard(testimonial)).toList(),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(
              testimonial['rating'] as int,
              (index) => const Icon(
                Icons.star,
                color: Color(0xFFF39C12),
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '"${testimonial['content']}"',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Color(0xFF2C3E50),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            testimonial['name'] as String,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3328BF),
            ),
          ),
          Text(
            testimonial['role'] as String,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}