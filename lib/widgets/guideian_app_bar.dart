import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/app_theme.dart';
import '../utils/app_routes.dart';

class GuideianAppBar extends StatelessWidget {
  const GuideianAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Logo
          Expanded(
            child: Row(
              children: [
                _buildLogo(),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guideian',
                      style: AppTheme.heading4.copyWith(
                        fontFamily: 'TenorSans',
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      'Future Ready',
                      style: AppTheme.caption.copyWith(
                        fontFamily: 'TenorSans',
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Navigation Menu (Desktop)
          if (MediaQuery.of(context).size.width > 768)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNavLink(context, 'Home', AppRoutes.home, true),
                  _buildNavLink(context, 'Services', AppRoutes.services, false),
                  _buildNavLink(context, 'About Us', AppRoutes.about, false),
                  _buildNavLink(context, 'Contact us', AppRoutes.contact, false),
                ],
              ),
            ),
          
          // Auth Buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.isAuthenticated) {
                      return Row(
                        children: [
                          Text(
                            'Welcome, ${authProvider.user?.name ?? "User"}',
                            style: AppTheme.bodyMedium,
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton(
                            onPressed: () => context.go(AppRoutes.profile),
                            child: const Text('Profile'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              await authProvider.signOut();
                              if (context.mounted) {
                                context.go(AppRoutes.home);
                              }
                            },
                            child: const Text('Sign Out'),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          TextButton(
                            onPressed: () => context.go(AppRoutes.login),
                            child: const Text('Log In'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () => context.go(AppRoutes.signup),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      );
                    }
                  },
                ),
                
                // Mobile Menu Button
                if (MediaQuery.of(context).size.width <= 768)
                  IconButton(
                    onPressed: () => _showMobileMenu(context),
                    icon: const Icon(Icons.menu),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        painter: LogoPainter(),
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String text, String route, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () => context.go(route),
        style: TextButton.styleFrom(
          foregroundColor: isActive ? AppTheme.secondaryColor : AppTheme.textPrimary,
          textStyle: AppTheme.bodyMedium.copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        child: Text(text),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileNavLink(context, 'Home', AppRoutes.home),
            _buildMobileNavLink(context, 'Services', AppRoutes.services),
            _buildMobileNavLink(context, 'About Us', AppRoutes.about),
            _buildMobileNavLink(context, 'Contact us', AppRoutes.contact),
            const Divider(),
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                if (authProvider.isAuthenticated) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('Profile'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go(AppRoutes.profile);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: Text('Sign Out'),
                        onTap: () async {
                          Navigator.pop(context);
                          await authProvider.signOut();
                          if (context.mounted) {
                            context.go(AppRoutes.home);
                          }
                        },
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.login),
                        title: Text('Log In'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go(AppRoutes.login);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_add),
                        title: Text('Sign Up'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go(AppRoutes.signup);
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavLink(BuildContext context, String text, String route) {
    return ListTile(
      title: Text(text),
      onTap: () {
        Navigator.pop(context);
        context.go(route);
      },
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw the curved lines that make up the Guideian logo
    final path1 = Path();
    path1.moveTo(5, 5);
    path1.quadraticBezierTo(15, 5, 25, 5);
    path1.quadraticBezierTo(35, 5, 45, 5);
    path1.quadraticBezierTo(50, 15, 50, 25);
    path1.quadraticBezierTo(50, 35, 45, 45);
    path1.quadraticBezierTo(35, 50, 25, 50);
    path1.quadraticBezierTo(15, 50, 5, 50);
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(5, 10);
    path2.quadraticBezierTo(20, 10, 30, 10);
    path2.quadraticBezierTo(40, 10, 45, 10);
    path2.quadraticBezierTo(48, 20, 48, 30);
    path2.quadraticBezierTo(48, 40, 45, 45);
    path2.quadraticBezierTo(35, 48, 25, 48);
    path2.quadraticBezierTo(15, 48, 5, 48);
    canvas.drawPath(path2, paint);

    final path3 = Path();
    path3.moveTo(5, 15);
    path3.quadraticBezierTo(25, 15, 35, 15);
    path3.quadraticBezierTo(42, 15, 45, 15);
    path3.quadraticBezierTo(47, 25, 47, 35);
    path3.quadraticBezierTo(47, 42, 45, 45);
    path3.quadraticBezierTo(35, 47, 25, 47);
    path3.quadraticBezierTo(15, 47, 5, 47);
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
