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
          child: SizedBox(
            width: 217,
            height: 55,
            child: CustomPaint(
              painter: GuideianLogoPainter(),
            ),
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
          child: SizedBox(
            width: 120,
            height: 30,
            child: CustomPaint(
              painter: GuideianLogoPainter(),
            ),
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

// Guideian Logo Painter - exact replica of the HTML SVG
class GuideianLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF000000)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Draw the text "Guideian"
    textPainter.text = TextSpan(
      text: 'Guideian',
      style: TextStyle(
        fontFamily: 'Tenor Sans',
        fontSize: 26,
        color: const Color(0xFF000000),
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(63, 0.71));

    // Draw the text "Future Ready"
    textPainter.text = TextSpan(
      text: 'Future Ready',
      style: TextStyle(
        fontFamily: 'Tenor Sans',
        fontSize: 13,
        color: const Color(0xFF000000),
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(64, 28));

    // Draw the curved lines (exact replica of the original SVG paths)
    final path1 = Path();
    path1.moveTo(55.0188, 1);
    path1.quadraticBezierTo(40.0187, 1, 25.0188, 1);
    path1.quadraticBezierTo(10.0189, 1, 0.518789, 17);
    path1.quadraticBezierTo(1.01882, 28, 1.51886, 39);
    path1.quadraticBezierTo(9.01882, 52.7638, 25.0188, 53);
    path1.quadraticBezierTo(41.0188, 53.2362, 54.0188, 53);
    path1.lineTo(54.0188, 28);
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(55.0188, 5);
    path2.quadraticBezierTo(38.0188, 5, 26.5188, 5);
    path2.quadraticBezierTo(15.0188, 5, 5.0188, 14.3256);
    path2.quadraticBezierTo(5.0188, 28, 5.0188, 41.6744);
    path2.quadraticBezierTo(16.0323, 49, 27.0188, 49);
    path2.quadraticBezierTo(38.0053, 49, 50.0188, 49);
    path2.lineTo(50.0188, 40);
    path2.lineTo(50.0188, 28);
    canvas.drawPath(path2, paint);

    final path3 = Path();
    path3.moveTo(55.0188, 9);
    path3.quadraticBezierTo(33.473, 9, 25.9207, 9);
    path3.quadraticBezierTo(18.3683, 9, 9.0188, 17.1554);
    path3.quadraticBezierTo(9.0188, 28, 9.0188, 38.8446);
    path3.quadraticBezierTo(17.2723, 45.5, 26.0188, 45.5);
    path3.quadraticBezierTo(34.7653, 45.5, 46.0188, 45.5);
    path3.lineTo(46.0188, 37.5);
    path3.lineTo(46.0188, 28);
    canvas.drawPath(path3, paint);

    final path4 = Path();
    path4.moveTo(55.0188, 13);
    path4.quadraticBezierTo(32.2727, 13, 26.2633, 13);
    path4.quadraticBezierTo(20.2539, 13, 13.0188, 18.9385);
    path4.quadraticBezierTo(13.0188, 27.5, 13.0188, 36.0615);
    path4.quadraticBezierTo(20.0188, 41, 26.5188, 41.5);
    path4.quadraticBezierTo(33.0188, 42, 42.0188, 41.5);
    path4.lineTo(42.0188, 28);
    canvas.drawPath(path4, paint);

    final path5 = Path();
    path5.moveTo(55.0189, 17);
    path5.quadraticBezierTo(35.6287, 17, 28.0738, 17);
    path5.quadraticBezierTo(20.5189, 17, 16.5189, 21.5);
    path5.quadraticBezierTo(17.5189, 28, 17.5189, 34.5);
    path5.quadraticBezierTo(23.1612, 37.5, 28.0738, 37.5);
    path5.quadraticBezierTo(32.9865, 37.5, 38.0189, 37.5);
    path5.lineTo(38.0189, 28);
    canvas.drawPath(path5, paint);

    final path6 = Path();
    path6.moveTo(55.0188, 21);
    path6.quadraticBezierTo(29.7875, 21, 27.1858, 21);
    path6.quadraticBezierTo(24.5841, 21, 21.0188, 23.4418);
    path6.quadraticBezierTo(21.0188, 27.1518, 21.0188, 30.8618);
    path6.quadraticBezierTo(23.5188, 34, 27.1858, 34);
    path6.quadraticBezierTo(30.8529, 34, 34.0188, 34);
    path6.lineTo(34.0188, 28);
    canvas.drawPath(path6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
