import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: "PrinceMohlomi");
  final _emailController = TextEditingController(text: "princemohlomi@gmail.com");
  final _messageController = TextEditingController();
  
  List<bool> faqExpanded = [false, false, false];
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _launchSocial(String url) async {
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
            // Navigation Bar (identical to home screen)
            _buildNavbar(context),
            
            // Page Title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'Contact Us',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            // Contact Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Info Left Side
                  Expanded(
                    flex: 1,
                    child: _buildContactInfo(),
                  ),
                  
                  const SizedBox(width: 80),
                  
                  // Contact Form Right Side
                  Expanded(
                    flex: 1,
                    child: _buildContactForm(),
                  ),
                ],
              ),
            ),
            
            // FAQ Section
            _buildFAQSection(),
            
            // Footer (identical to home screen)
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // Identical navbar from home screen
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
                onTap: () => context.go('/about'),
              ),
              _NavLink(
                text: 'Contact us',
                isActive: true,
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

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reach Our Customer Service Team',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 40),
        
        // Address
        _buildContactDetail(
          icon: Icons.location_on_outlined,
          title: 'Address',
          content: 'Cape Town, Robert Sobukwe Rd',
        ),
        
        const SizedBox(height: 32),
        
        // Phone
        _buildContactDetail(
          icon: Icons.phone_outlined,
          title: 'Contact Details',
          content: '081-487-5688',
        ),
        
        const SizedBox(height: 32),
        
        // Email
        _buildContactDetail(
          icon: Icons.email_outlined,
          title: 'Email Us',
          content: 'gguideian@gmail.com',
        ),
        
        const SizedBox(height: 48),
        
        // Social Media
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Follow Us :',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSocialIcon(Icons.facebook, 'https://www.facebook.com/guideian.2025/'),
                const SizedBox(width: 12),
                _buildSocialIcon(Icons.camera_alt, 'https://www.instagram.com/guideian/'),
                const SizedBox(width: 12),
                _buildSocialIcon(Icons.business, 'https://za.linkedin.com/company/guideian'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactDetail({required IconData icon, required String title, required String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF3328BF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF3328BF),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: const Color(0xFF666666),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launchSocial(url),
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
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Name',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    color: const Color(0xFF1A1A1A),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF3328BF)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Email Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Email',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    color: const Color(0xFF1A1A1A),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF3328BF)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Message Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Message',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _messageController,
                  maxLines: 5,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    color: const Color(0xFF1A1A1A),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write to here...',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF9CA3AF),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF3328BF)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Send Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3328BF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Sending...',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send Message',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.send,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
      color: const Color(0xFFF8F9FC),
      child: Column(
        children: [
          // FAQ Header
          Column(
            children: [
              Text(
                'Frequently Asked Questions',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'We hope this FAQ section has addressed some of your common questions.\nIf you have any further queries, please don\'t hesitate to reach out to us.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  color: const Color(0xFF666666),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          
          const SizedBox(height: 60),
          
          // FAQ Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FAQ Questions
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildFAQItem(
                      'How do I know which courses are right for me?',
                      0,
                    ),
                    const SizedBox(height: 16),
                    _buildFAQItem(
                      'Does Guideian handle university applications for me?',
                      1,
                    ),
                    const SizedBox(height: 16),
                    _buildFAQItem(
                      'How does Subject Selection Support work?',
                      2,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 60),
              
              // FAQ Image
              Expanded(
                flex: 1,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFE6E9FA),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.help_outline,
                      size: 80,
                      color: Color(0xFF3328BF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            faqExpanded[index] = !faqExpanded[index];
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  Icon(
                    faqExpanded[index] ? Icons.expand_less : Icons.expand_more,
                    color: const Color(0xFF666666),
                  ),
                ],
              ),
              if (faqExpanded[index]) ...[
                const SizedBox(height: 16),
                Text(
                  _getFAQAnswer(index),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    color: const Color(0xFF666666),
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getFAQAnswer(int index) {
    switch (index) {
      case 0:
        return 'Our personalized course finder tool analyzes your interests, strengths, and career goals to recommend the most suitable courses and universities for your future success.';
      case 1:
        return 'Yes, we provide comprehensive university application support, including assistance with application forms, documentation, and guidance throughout the entire application process.';
      case 2:
        return 'Our subject selection support helps you choose the right high school subjects based on your career aspirations and university requirements, ensuring you meet all prerequisites for your desired courses.';
      default:
        return '';
    }
  }

  // Identical footer from home screen
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
                          onTap: () => _launchSocial('https://www.facebook.com/guideian.2025/'),
                        ),
                        const SizedBox(width: 12),
                        _SocialMediaIcon(
                          icon: Icons.camera_alt, // Instagram
                          onTap: () => _launchSocial('https://www.instagram.com/guideian/'),
                        ),
                        const SizedBox(width: 12),
                        _SocialMediaIcon(
                          icon: Icons.business, // LinkedIn
                          onTap: () => _launchSocial('https://za.linkedin.com/company/guideian'),
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
                      'gguideian@gmail.com',
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

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate form submission
      await Future.delayed(const Duration(seconds: 1));
      
      print('Contact form submitted:');
      print('Name: ${_nameController.text.trim()}');
      print('Email: ${_emailController.text.trim()}');
      print('Message: ${_messageController.text.trim()}');

      setState(() => _isLoading = false);

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Message sent successfully! We\'ll get back to you within 24 hours.',
              style: GoogleFonts.plusJakartaSans(),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      
      // Clear the message field only
      _messageController.clear();
    } catch (e) {
      setState(() => _isLoading = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'An error occurred. Please try again later.',
              style: GoogleFonts.plusJakartaSans(),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }
}

// Navigation Link Widget (from home screen)
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

// Footer Link Widget (from home screen)
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

// Social Media Icon Widget (from home screen)
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

// Custom painter for the Guideian logo (from home screen)
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