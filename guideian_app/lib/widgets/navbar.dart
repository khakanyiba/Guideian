import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onServicesTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onContactTap;
  final VoidCallback? onLoginTap;
  final VoidCallback? onSignupTap;

  const Navbar({
    super.key,
    this.onHomeTap,
    this.onServicesTap,
    this.onAboutTap,
    this.onContactTap,
    this.onLoginTap,
    this.onSignupTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      height: 96,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 70),
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
      child: isMobile ? _buildMobileNavbar() : _buildDesktopNavbar(),
    );
  }

  Widget _buildDesktopNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        GestureDetector(
          onTap: onHomeTap,
          child: Row(
            children: [
              // Custom Logo SVG
              CustomPaint(
                size: const Size(55, 55),
                painter: LogoPainter(),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guideian',
                    style: GoogleFonts.tenorSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0D0D0D),
                    ),
                  ),
                  Text(
                    'Future Ready',
                    style: GoogleFonts.tenorSans(
                      fontSize: 13,
                      color: const Color(0xFF0D0D0D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Navigation Links
        Row(
          children: [
            _buildNavLink('Home', true, onHomeTap),
            _buildNavLink('Services', false, onServicesTap),
            _buildNavLink('About Us', false, onAboutTap),
            _buildNavLink('Contact us', false, onContactTap),
          ],
        ),

        // Auth Buttons
        Row(
          children: [
            TextButton(
              onPressed: onLoginTap,
              child: Text(
                'Log In',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF3328BF),
                ),
              ),
            ),
            const SizedBox(width: 22),
            ElevatedButton(
              onPressed: onSignupTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3328BF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Sign Up',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        GestureDetector(
          onTap: onHomeTap,
          child: Row(
            children: [
              CustomPaint(
                size: const Size(40, 40),
                painter: LogoPainter(),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guideian',
                    style: GoogleFonts.tenorSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0D0D0D),
                    ),
                  ),
                  Text(
                    'Future Ready',
                    style: GoogleFonts.tenorSans(
                      fontSize: 10,
                      color: const Color(0xFF0D0D0D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Menu Button
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.menu,
            color: Color(0xFF3328BF),
            size: 24,
          ),
          onSelected: (value) {
            switch (value) {
              case 'home':
                onHomeTap?.call();
                break;
              case 'services':
                onServicesTap?.call();
                break;
              case 'about':
                onAboutTap?.call();
                break;
              case 'contact':
                onContactTap?.call();
                break;
              case 'login':
                onLoginTap?.call();
                break;
              case 'signup':
                onSignupTap?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'home',
              child: Text('Home'),
            ),
            const PopupMenuItem(
              value: 'services',
              child: Text('Services'),
            ),
            const PopupMenuItem(
              value: 'about',
              child: Text('About Us'),
            ),
            const PopupMenuItem(
              value: 'contact',
              child: Text('Contact Us'),
            ),
            const PopupMenuItem(
              value: 'login',
              child: Text('Log In'),
            ),
            const PopupMenuItem(
              value: 'signup',
              child: Text('Sign Up'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavLink(String text, bool isActive, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? const Color(0xFF3328BF) : const Color(0xFF808080),
          ),
        ),
      ),
    );
  }
}

// Logo Painter for the custom SVG - exact replica of the original
class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0D0D0D)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw the curved lines (exact replica of the original SVG paths)
    final path1 = Path();
    path1.moveTo(55, 1);
    path1.quadraticBezierTo(40, 1, 25, 1);
    path1.quadraticBezierTo(0.5, 17, 1, 28);
    path1.quadraticBezierTo(1.5, 39, 9, 52.8);
    path1.quadraticBezierTo(25, 53, 41, 53.2);
    path1.lineTo(54, 53);
    path1.lineTo(54, 28);
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(55, 5);
    path2.quadraticBezierTo(38, 5, 26.5, 5);
    path2.quadraticBezierTo(15, 5, 5, 14.3256);
    path2.quadraticBezierTo(5, 41.6744, 5, 28);
    path2.quadraticBezierTo(16.0323, 49, 27, 49);
    path2.quadraticBezierTo(38.0053, 49, 50, 49);
    path2.lineTo(50, 40);
    path2.lineTo(50, 28);
    canvas.drawPath(path2, paint);

    final path3 = Path();
    path3.moveTo(55, 9);
    path3.quadraticBezierTo(33.473, 9, 25.9207, 9);
    path3.quadraticBezierTo(18.3683, 9, 9, 17.1554);
    path3.quadraticBezierTo(9, 38.8446, 9, 28);
    path3.quadraticBezierTo(17.2723, 45.5, 26, 45.5);
    path3.quadraticBezierTo(34.7653, 45.5, 46, 45.5);
    path3.lineTo(46, 37.5);
    path3.lineTo(46, 28);
    canvas.drawPath(path3, paint);

    final path4 = Path();
    path4.moveTo(55, 13);
    path4.quadraticBezierTo(32.2727, 13, 26.2633, 13);
    path4.quadraticBezierTo(20.2539, 13, 13, 18.9385);
    path4.quadraticBezierTo(13, 36.0615, 13, 27.5);
    path4.quadraticBezierTo(20, 41, 26.5, 41.5);
    path4.quadraticBezierTo(33, 42, 42, 41.5);
    path4.lineTo(42, 28);
    canvas.drawPath(path4, paint);

    final path5 = Path();
    path5.moveTo(55, 17);
    path5.quadraticBezierTo(35.6287, 17, 28.0738, 17);
    path5.quadraticBezierTo(20.5189, 17, 16.5189, 21.5);
    path5.quadraticBezierTo(17.5189, 34.5, 17.5189, 28);
    path5.quadraticBezierTo(23.1612, 37.5, 28.0738, 37.5);
    path5.quadraticBezierTo(32.9865, 37.5, 38, 37.5);
    path5.lineTo(38, 28);
    canvas.drawPath(path5, paint);

    final path6 = Path();
    path6.moveTo(55, 21);
    path6.quadraticBezierTo(29.7875, 21, 27.1858, 21);
    path6.quadraticBezierTo(24.5841, 21, 21, 23.4418);
    path6.quadraticBezierTo(21, 30.8618, 21, 27.1518);
    path6.quadraticBezierTo(23.5188, 34, 27.1858, 34);
    path6.quadraticBezierTo(30.8529, 34, 34, 34);
    path6.lineTo(34, 28);
    canvas.drawPath(path6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
