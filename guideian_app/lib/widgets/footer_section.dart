import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: const Color(0xFF2C3E50),
      child: Column(
        children: [
          _buildFooterContent(context),
          const Divider(
            color: Colors.grey,
            height: 60,
            thickness: 1,
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildFooterContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        
        if (isMobile) {
          return Column(
            children: [
              _buildCompanyInfo(context),
              const SizedBox(height: 40),
              _buildQuickLinks(context),
              const SizedBox(height: 40),
              _buildSocialLinks(context),
            ],
          );
        }
        
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildCompanyInfo(context)),
            Expanded(child: _buildQuickLinks(context)),
            Expanded(child: _buildSocialLinks(context)),
          ],
        );
      },
    );
  }

  Widget _buildCompanyInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Guideian',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Your trusted partner in educational and career guidance. We help students and professionals find their perfect path to success.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[400],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    final links = [
      {'title': 'Home', 'route': '/'},
      {'title': 'Services', 'route': '/services'},
      {'title': 'About', 'route': '/about'},
      {'title': 'Contact', 'route': '/contact'},
      {'title': 'Privacy Policy', 'route': '/privacy'},
      {'title': 'Terms of Service', 'route': '/terms'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) =>
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () {
                // Navigation logic here
              },
              child: Text(
                link['title']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Us',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialIcon(Icons.alternate_email), // Twitter replacement
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.business), // LinkedIn replacement
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.camera_alt), // Instagram replacement
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Column(
      children: [
        Text(
          '© 2024 Guideian. All rights reserved.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[500],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Made with ❤️ for students worldwide',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}