import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/auth_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static void _launchSocial(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation Bar (identical to home_screen.dart)
            _buildNavbar(context),
            
            // Hero Banner Section
            _buildHeroBanner(),
            
            // Mission Section
            _buildMissionSection(),
            
            // Vision Section
            _buildVisionSection(context),
            
            // Founder Section
            _buildFounderSection(),
            
            // Institutions Section
            _buildInstitutionsSection(),
            
            // Footer (identical to home_screen.dart)
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // Navbar - Identical to home_screen.dart
  Widget _buildNavbar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
      child: Row(
        children: [
          // Logo
          _buildLogo(),
          const Spacer(),
          // Navigation Links
          Row(
            children: [
              _NavLink(
                text: 'Home',
                isActive: false,
                onTap: () => context.go('/'),
              ),
              _NavLink(
                text: 'Services',
                onTap: () => context.go('/services'),
              ),
              _NavLink(
                text: 'About Us',
                isActive: true,
                onTap: () => context.go('/about'),
              ),
              _NavLink(
                text: 'Contact us',
                onTap: () => context.go('/contact'),
              ),
            ],
          ),
          const Spacer(),
          // Auth Buttons or User Profile
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (authProvider.isLoggedIn) {
                return _buildUserProfile(context, authProvider);
              } else {
                return _buildAuthButtons(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 217,
      height: 55,
      child: CustomPaint(
        painter: GuideianLogoPainter(),
      ),
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => context.go('/login'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            'Log In',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF3328BF),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () => context.go('/signup'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3328BF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            'Sign Up',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfile(BuildContext context, AuthProvider authProvider) {
    return Row(
      children: [
        // User Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF3328BF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              authProvider.userName?.isNotEmpty == true 
                ? authProvider.userName![0].toUpperCase()
                : 'U',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // User Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              authProvider.userName ?? 'User',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF1A1A1A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              authProvider.userEmail ?? '',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF666666),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        // Dropdown Menu
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF666666),
            size: 20,
          ),
          onSelected: (value) {
            if (value == 'logout') {
              authProvider.logout();
            } else if (value == 'profile') {
              // Navigate to profile page when created
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile page coming soon!')),
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'profile',
              child: Row(
                children: [
                  const Icon(Icons.person_outline, size: 20, color: Color(0xFF666666)),
                  const SizedBox(width: 12),
                  Text(
                    'Profile',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                children: [
                  const Icon(Icons.logout, size: 20, color: Color(0xFF666666)),
                  const SizedBox(width: 12),
                  Text(
                    'Logout',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://cdn.builder.io/api/v1/image/assets/TEMP/3389e4a98353f873d3d682f38f9f462c45bd9110?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba'
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.6),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'About Us',
                style: GoogleFonts.tenorSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                constraints: const BoxConstraints(maxWidth: 800),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Re-writing the Reality of South Africa Through Knowledge and Opportunity',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tenorSans(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMissionSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 768) {
                // Mobile layout
                return Column(
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/999a5e06911c8ded7ca5978bddc59ca42a00b0f8?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba'
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildMissionText(),
                  ],
                );
              } else {
                // Desktop layout
                return Row(
                  children: [
                    // Image Column
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://cdn.builder.io/api/v1/image/assets/TEMP/999a5e06911c8ded7ca5978bddc59ca42a00b0f8?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                    // Text Column
                    Expanded(
                      flex: 1,
                      child: _buildMissionText(),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMissionText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Mission',
          style: GoogleFonts.tenorSans(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0D0D0D),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'At Guideian, we\'re on a mission to change the story for South African high school students. Too many finish school but never step into universityâ€"not because they lack potential, but because they lack the knowledge and tools to apply. We\'re here to bridge that gap with personalized guidance, expert support, and a seamless application process, ensuring every student can unlock their future.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            color: const Color(0xFF808080),
            height: 1.6,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildVisionSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: const Color(0xFFFAFAFA),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Vision Content Row
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 768) {
                    // Mobile layout
                    return Column(
                      children: [
                        _buildVisionText(),
                        const SizedBox(height: 40),
                        Container(
                          height: 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://cdn.builder.io/api/v1/image/assets/TEMP/7785e07cc3da8c7247663ef5236250aac8646ce1?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Desktop layout
                    return Row(
                      children: [
                        // Text Column
                        Expanded(
                          flex: 1,
                          child: _buildVisionText(),
                        ),
                        const SizedBox(width: 60),
                        // Image Column
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://cdn.builder.io/api/v1/image/assets/TEMP/7785e07cc3da8c7247663ef5236250aac8646ce1?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba'
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 80),
              
              // What We Offer Section
              Text(
                'What We Offer',
                textAlign: TextAlign.center,
                style: GoogleFonts.tenorSans(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0D0D0D),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  'Guideian starts with grade 9 subject selection, showing students how their choices open university doors, and continues through high school with motivation to excel and clear career paths. Our automated application system takes the confusion out of applying, submitting to students\' desired universities for courses they love, while our insights into job trends ensure their education leads to real opportunities. From start to finish, we\'re here to make the journey simple, informed, and inspiring.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    color: const Color(0xFF808080),
                    height: 1.6,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Sign Up Button
              ElevatedButton(
                onPressed: () => context.go('/signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3328BF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVisionText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Vision',
          style: GoogleFonts.tenorSans(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0D0D0D),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'We dream of a South Africa where every child who completes high school moves confidently to university and, ultimately, into a career they\'re passionate about. By helping students choose the right subjects, maintain strong marks, and apply to institutions that match their goals, we aim to build a nation where education leads to employment and where potential isn\'t wasted but transformed into purpose. Guideian isn\'t just a tool; it\'s a step toward a brighter, more empowered future for our youth.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            color: const Color(0xFF808080),
            height: 1.6,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildFounderSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 768) {
                // Mobile layout
                return Column(
                  children: [
                    Container(
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/1a57635f2265e1e9090137300c6e933781fd5400?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba'
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildFounderQuote(),
                  ],
                );
              } else {
                // Desktop layout
                return Row(
                  children: [
                    // Image Column
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://cdn.builder.io/api/v1/image/assets/TEMP/1a57635f2265e1e9090137300c6e933781fd5400?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                    // Quote Column
                    Expanded(
                      flex: 1,
                      child: _buildFounderQuote(),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFounderQuote() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"I grew up in a community where finishing high school was a win, but university felt like a distant dream. My peers were bright and talented, but most never pursued higher education, not because they didn\'t want to, but because they didn\'t know how. I watched their potential fade into dead end jobs or unemployment, and it drove me to create Guideian, a tool to ensure no South African student misses out on their chance to shine."',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              color: const Color(0xFF0D0D0D),
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sonwabise Gcolotela',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0D0D0D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Founder',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: const Color(0xFF808080),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstitutionsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: const Color(0xFFF8F9FC),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Header Section
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 768) {
                    // Mobile layout
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Working with Institutions Nation wide',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A1A),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'We\'ve partnered with all 26 universities and 50 TVET colleges nationwide to drive our mission of advancing education and skills. These collaborations enhance access, resource-sharing, and innovation. Bursaries like NSFAS and SETA funds provide essential financial support, removing barriers to tuition and living costs, ensuring broader participation and amplifying our impact.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF666666),
                            height: 1.6,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Desktop layout
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Column
                        Expanded(
                          child: Text(
                            'Working with Institutions Nation wide',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A1A),
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 60),
                        // Description Column
                        Expanded(
                          child: Text(
                            'We\'ve partnered with all 26 universities and 50 TVET colleges nationwide to drive our mission of advancing education and skills. These collaborations enhance access, resource-sharing, and innovation. Bursaries like NSFAS and SETA funds provide essential financial support, removing barriers to tuition and living costs, ensuring broader participation and amplifying our impact.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF666666),
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 60),
              
              // Stats Cards - identical to home_screen.dart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MetricCard(number: '26', label: 'Public Universities'),
                  _MetricCard(number: '76', label: 'TVET Colleges'),
                  _MetricCard(number: '8K+', label: 'Total Courses'),
                  _MetricCard(number: '40', label: 'Bursaries'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Footer - Identical to home_screen.dart
  Widget _buildFooter(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAFF),
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 60),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo with the same design as navbar
                    SizedBox(
                      width: 217,
                      height: 55,
                      child: CustomPaint(
                        painter: GuideianLogoPainter(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your roadmap to a bright future. We help South African students navigate their educational journey from high school to university.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Social media icons
                    Row(
                      children: [
                        _SocialMediaIcon(
                          icon: Icons.facebook,
                          onTap: () => AboutScreen._launchSocial('https://www.facebook.com/guideian.2025/'),
                        ),
                        const SizedBox(width: 12),
                        _SocialMediaIcon(
                          icon: Icons.camera_alt, // Instagram
                          onTap: () => AboutScreen._launchSocial('https://www.instagram.com/guideian/'),
                        ),
                        const SizedBox(width: 12),
                        _SocialMediaIcon(
                          icon: Icons.business, // LinkedIn
                          onTap: () => AboutScreen._launchSocial('https://za.linkedin.com/company/guideian'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              // Links column
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Links',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _FooterLink(text: 'Home', onTap: () => context.go('/')),
                    _FooterLink(text: 'Services', onTap: () => context.go('/services')),
                    _FooterLink(text: 'About Us', onTap: () => context.go('/about')),
                    _FooterLink(text: 'Contact Us', onTap: () => context.go('/contact')),
                    _FooterLink(text: 'Sign Up', onTap: () => context.go('/signup')),
                  ],
                ),
              ),
              // Contact column
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Cape Town, South Africa',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'guideian.help@gmail.com',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '+27 81 487 5688',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              // CTA column
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s start your journey now!',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/signup'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3328BF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.plusJakartaSans(
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
          const SizedBox(height: 40),
          Container(
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(height: 24),
          Text(
            'Copyright @ 2025 Guideian, All rights reserved.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Navigation Link Widget - identical to home_screen.dart
class _NavLink extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.text,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            color: isActive ? const Color(0xFF3328BF) : const Color(0xFF666666),
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Metric Card Widget - identical to home_screen.dart
class _MetricCard extends StatelessWidget {
  final String number;
  final String label;

  const _MetricCard({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF3328BF),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF666666),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Footer Link Widget - identical to home_screen.dart
class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF999999),
            height: 1.6,
          ),
        ),
      ),
    );
  }
}

// Social Media Icon Widget - identical to home_screen.dart
class _SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialMediaIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF3328BF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3328BF).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Custom painter for the Guideian logo - identical to home_screen.dart
class GuideianLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw the curved paths from the SVG
    final path1 = Path()
      ..moveTo(55.0, 1.0)
      ..lineTo(25.0, 1.0)
      ..quadraticBezierTo(0.5, 1.0, 1.0, 28.0)
      ..quadraticBezierTo(1.5, 53.0, 25.0, 53.0)
      ..lineTo(54.0, 53.0)
      ..lineTo(54.0, 28.0);

    final path2 = Path()
      ..moveTo(55.0, 5.0)
      ..lineTo(26.5, 5.0)
      ..quadraticBezierTo(5.0, 5.0, 5.0, 28.0)
      ..quadraticBezierTo(5.0, 49.0, 27.0, 49.0)
      ..lineTo(50.0, 49.0)
      ..lineTo(50.0, 28.0);

    final path3 = Path()
      ..moveTo(55.0, 9.0)
      ..lineTo(25.9, 9.0)
      ..quadraticBezierTo(9.0, 9.0, 9.0, 28.0)
      ..quadraticBezierTo(9.0, 45.5, 26.0, 45.5)
      ..lineTo(46.0, 45.5)
      ..lineTo(46.0, 28.0);

    final path4 = Path()
      ..moveTo(55.0, 13.0)
      ..lineTo(26.3, 13.0)
      ..quadraticBezierTo(13.0, 13.0, 13.0, 27.5)
      ..quadraticBezierTo(13.0, 41.5, 26.5, 41.5)
      ..lineTo(42.0, 41.5)
      ..lineTo(42.0, 28.0);

    final path5 = Path()
      ..moveTo(55.0, 17.0)
      ..lineTo(28.1, 17.0)
      ..quadraticBezierTo(16.5, 17.0, 17.0, 28.0)
      ..quadraticBezierTo(17.5, 37.5, 28.1, 37.5)
      ..lineTo(38.0, 37.5)
      ..lineTo(38.0, 28.0);

    final path6 = Path()
      ..moveTo(55.0, 21.0)
      ..lineTo(27.2, 21.0)
      ..quadraticBezierTo(21.0, 21.0, 21.0, 27.2)
      ..quadraticBezierTo(21.0, 34.0, 27.2, 34.0)
      ..lineTo(34.0, 34.0)
      ..lineTo(34.0, 28.0);

    // Draw all paths
    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
    canvas.drawPath(path3, paint);
    canvas.drawPath(path4, paint);
    canvas.drawPath(path5, paint);
    canvas.drawPath(path6, paint);

    // Draw the text
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Guideian',
        style: GoogleFonts.tenorSans(
          fontSize: 26,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, const Offset(63, 10));

    final subTextPainter = TextPainter(
      text: TextSpan(
        text: 'Future Ready',
        style: GoogleFonts.tenorSans(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    subTextPainter.paint(canvas, const Offset(64, 35));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}