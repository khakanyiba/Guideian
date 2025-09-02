import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuideianAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GuideianAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Row(
          children: [
            // Logo
            _buildLogo(),
            const Spacer(),
            // Navigation Links
            _buildNavigationLinks(context),
            const SizedBox(width: 22),
            // Auth Buttons
            _buildAuthButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        // Logo Image
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              '../assets/Logo.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guideian',
              style: TextStyle(
                fontFamily: 'Tenor Sans',
                fontSize: 26,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0D0D0D),
              ),
            ),
            Text(
              'Future Ready',
              style: TextStyle(
                fontFamily: 'Tenor Sans',
                fontSize: 13,
                color: Color(0xFF0D0D0D),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigationLinks(BuildContext context) {
    return Row(
      children: [
        _buildNavLink(context, 'Home', '/', true),
        const SizedBox(width: 20),
        _buildNavLink(context, 'Services', '/services', false),
        const SizedBox(width: 20),
        _buildNavLink(context, 'About Us', '/about', false),
        const SizedBox(width: 20),
        _buildNavLink(context, 'Contact us', '/contact', false),
      ],
    );
  }

  Widget _buildNavLink(
      BuildContext context, String text, String route, bool isActive) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? const Color(0xFF3328BF) : const Color(0xFF808080),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.go('/login'),
          child: const Text(
            'Log In',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3328BF),
            ),
          ),
        ),
        const SizedBox(width: 22),
        GestureDetector(
          onTap: () => context.go('/signup'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF3328BF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
