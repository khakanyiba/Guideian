import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String selectedFilter = 'All Services';
  
  final List<String> filters = [
    'All Services',
    'Profile',
    'Messaging',
    'Calendar',
    'Progress',
    'Applications',
    'Pathfinder',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation Bar - exactly from home screen
            _buildNavbar(context),
            
            // Services Section
            _buildServicesSection(),
            
            // Benefits Section
            _buildBenefitsSection(),
            
            // Footer - exactly from home screen
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // Navbar exactly from home screen
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
                isActive: true, // Services is active on this page
                onTap: () => context.go('/services'),
              ),
              _NavLink(
                text: 'About Us',
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

  // Logo exactly from home screen
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

  Widget _buildServicesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      color: Colors.white,
      child: Column(
        children: [
          // Section Header
          Column(
            children: [
              Text(
                'Guideian Services',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0D0D0D),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Tools to Shape Your Tomorrow',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  color: const Color(0xFF666666),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          
          const SizedBox(height: 48),
          
          // Filter Buttons
          _buildFilterButtons(),
          
          const SizedBox(height: 56),
          
          // Services Grid
          _buildServicesGrid(),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: filters.map((filter) {
        final isSelected = selectedFilter == filter;
        return GestureDetector(
          onTap: () => setState(() => selectedFilter = filter),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF3328BF) : Colors.transparent,
              border: Border.all(
                color: isSelected ? const Color(0xFF3328BF) : const Color(0xFFE5E5E5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              filter,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF666666),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildServicesGrid() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // First section: How It Works (left) and Service Cards Grid (right)
              SizedBox(
                height: 600, // Fixed height matching HTML
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // How It Works - takes up about 40% of width (2 columns out of 5)
                    SizedBox(
                      width: constraints.maxWidth * 0.4,
                      child: _buildHowItWorksCard(),
                    ),
                    const SizedBox(width: 24),
                    // Service Cards Grid - takes up remaining width
                    Expanded(
                      child: Column(
                        children: [
                          // First row: Profile, Messaging, Calendar (horizontal)
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildServiceCard(
                                    title: 'Profile',
                                    description: 'Create and manage your academic profile with personal details, achievements, and goals to track your educational journey.',
                                    icon: _buildProfileIcon(),
                                    onTap: () => context.go('/profile'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildServiceCard(
                                    title: 'Messaging',
                                    description: 'Connect with educational advisors and fellow students to get advice, share experiences, and build your network.',
                                    icon: _buildMessagingIcon(),
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildServiceCard(
                                    title: 'Calendar',
                                    description: 'Stay organized with important dates, deadlines, and events related to your studies and university applications.',
                                    icon: _buildCalendarIcon(),
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Second row: Progress, Applications, Pathfinder (horizontal)
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildServiceCard(
                                    title: 'Progress',
                                    description: 'Upload marks, see visual graphs of your performance, and get personalized tips to improve and reach your academic goals.',
                                    icon: _buildProgressIcon(),
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildServiceCard(
                                    title: 'Applications',
                                    description: 'Streamline your university application process with our automated system that matches you with suitable programs and institutions.',
                                    icon: _buildApplicationsIcon(),
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildServiceCard(
                                    title: 'Pathfinder',
                                    description: 'Get guidance on subject selection based on your interests, strengths, and career aspirations to set yourself up for success.',
                                    icon: _buildPathfinderIcon(),
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHowItWorksCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How It Works',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0D0D0D),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Steps
          Expanded(
            child: Column(
              children: [
                _buildStep(
                  number: '1',
                  title: 'Sign up for an account',
                  description: 'Create your profile and customize it to your liking',
                ),
                const SizedBox(height: 24),
                _buildStep(
                  number: '2',
                  title: 'Fill out required fields',
                  description: 'Ensure all your details and documents are captured',
                ),
                const SizedBox(height: 24),
                _buildStep(
                  number: '3',
                  title: 'Use our tools',
                  description: 'Make use of tools like subject selection tool, course finder and progress tracker',
                ),
                const SizedBox(height: 24),
                _buildStep(
                  number: '4',
                  title: 'Succeed in your goals',
                  description: 'Achieve your educational aspirations with our support',
                ),
                
                const Spacer(),
                
                // Help Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7FF), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need Help?',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0D0D0D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Our team is here to assist you with any questions about our services.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: const Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => context.go('/contact'),
                        child: Text(
                          'Contact our Support Team',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF3328BF),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF3328BF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0D0D0D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: const Color(0xFF666666),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service header with icon and title
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: icon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0D0D0D),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Expanded(
              child: Text(
                description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: const Color(0xFF666666),
                  height: 1.4,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Explore button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF3328BF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Explore',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      color: const Color(0xFFF5F5FA),
      child: Column(
        children: [
          Text(
            'Benefits of Using Guideian',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0D0D0D),
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 56),
          
          // Benefits grid - exactly 3 columns like HTML
          Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = (constraints.maxWidth - 48) / 3; // 3 columns with gaps
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: _buildBenefitCard(
                        title: 'Simplified Decision Making',
                        description: 'Our tools help you make informed decisions about subjects, careers, and tertiary education options.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildBenefitCard(
                        title: 'Time-Saving Automation',
                        description: 'Automate repetitive tasks like university applications, saving you time to focus on your studies.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildBenefitCard(
                        title: 'Personalized Guidance',
                        description: 'Receive tailored recommendations based on your unique profile, interests, and academic performance.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildBenefitCard(
                        title: 'Progress Visualization',
                        description: 'See your academic journey visualized with clear graphs and metrics to track improvement.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildBenefitCard(
                        title: 'Expert Support',
                        description: 'Access to educational advisors who can provide guidance and answer your questions.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildBenefitCard(
                        title: 'Comprehensive Resources',
                        description: 'Access a wealth of educational resources, tips, and strategies to help you succeed.',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitCard({
    required String title,
    required String description,
  }) {
    return Container(
      height: 200, // Fixed height for consistent layout
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Check icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: _buildCheckIcon(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0D0D0D),
            ),
          ),
          
          const SizedBox(height: 8),
          
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF666666),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Footer exactly from home screen
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
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _SocialMediaIcon(
                          icon: Icons.alternate_email, // Twitter/X
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _SocialMediaIcon(
                          icon: Icons.camera_alt, // Instagram
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _SocialMediaIcon(
                          icon: Icons.work, // LinkedIn
                          onTap: () {},
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

  // Icon widgets - exactly matching HTML SVG paths
  Widget _buildProfileIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: ProfileIconPainter(),
    );
  }

  Widget _buildMessagingIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: MessagingIconPainter(),
    );
  }

  Widget _buildCalendarIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: CalendarIconPainter(),
    );
  }

  Widget _buildProgressIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: ProgressIconPainter(),
    );
  }

  Widget _buildApplicationsIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: ApplicationsIconPainter(),
    );
  }

  Widget _buildPathfinderIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: PathfinderIconPainter(),
    );
  }

  Widget _buildCheckIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: CheckIconPainter(),
    );
  }
}

// Navigation Link Widget - exactly from home screen
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

// Footer Link Widget - exactly from home screen
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

// Social Media Icon Widget - exactly from home screen
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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Custom painter for the Guideian logo - exactly from home screen
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

// Custom painters for exact icon recreation
class ProfileIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3328BF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // User head circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.29), 
      size.width * 0.17, 
      paint
    );
    
    // User body path
    final bodyPath = Path();
    bodyPath.moveTo(size.width * 0.79, size.height * 0.875);
    bodyPath.lineTo(size.width * 0.79, size.height * 0.79);
    bodyPath.cubicTo(
      size.width * 0.79, size.height * 0.745,
      size.width * 0.776, size.height * 0.701,
      size.width * 0.744, size.height * 0.672
    );
    bodyPath.cubicTo(
      size.width * 0.712, size.height * 0.643,
      size.width * 0.673, size.height * 0.625,
      size.width * 0.625, size.height * 0.625
    );
    bodyPath.lineTo(size.width * 0.375, size.height * 0.625);
    bodyPath.cubicTo(
      size.width * 0.327, size.height * 0.625,
      size.width * 0.288, size.height * 0.643,
      size.width * 0.256, size.height * 0.672
    );
    bodyPath.cubicTo(
      size.width * 0.224, size.height * 0.701,
      size.width * 0.208, size.height * 0.745,
      size.width * 0.208, size.height * 0.79
    );
    bodyPath.lineTo(size.width * 0.208, size.height * 0.875);
    
    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MessagingIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3328BF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Chat bubble path
    final bubblePath = Path();
    bubblePath.moveTo(size.width * 0.875, size.height * 0.625);
    bubblePath.cubicTo(
      size.width * 0.875, size.height * 0.647,
      size.width * 0.858, size.height * 0.667,
      size.width * 0.833, size.height * 0.68
    );
    bubblePath.cubicTo(
      size.width * 0.806, size.height * 0.694,
      size.width * 0.773, size.height * 0.708,
      size.width * 0.8, size.height * 0.708
    );
    bubblePath.lineTo(size.width * 0.302, size.height * 0.708);
    bubblePath.lineTo(size.width * 0.135, size.height * 0.875);
    bubblePath.lineTo(size.width * 0.135, size.height * 0.208);
    bubblePath.cubicTo(
      size.width * 0.135, size.height * 0.186,
      size.width * 0.152, size.height * 0.167,
      size.width * 0.177, size.height * 0.153
    );
    bubblePath.cubicTo(
      size.width * 0.202, size.height * 0.14,
      size.width * 0.235, size.height * 0.125,
      size.width * 0.219, size.height * 0.125
    );
    bubblePath.lineTo(size.width * 0.8, size.height * 0.125);
    bubblePath.cubicTo(
      size.width * 0.823, size.height * 0.125,
      size.width * 0.844, size.height * 0.14,
      size.width * 0.869, size.height * 0.153
    );
    bubblePath.cubicTo(
      size.width * 0.894, size.height * 0.167,
      size.width * 0.875, size.height * 0.186,
      size.width * 0.875, size.height * 0.208
    );
    bubblePath.close();
    
    canvas.drawPath(bubblePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CalendarIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3328BF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Date lines at top
    canvas.drawLine(
      Offset(size.width * 0.36, size.height * 0.083),
      Offset(size.width * 0.36, size.height * 0.25),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.69, size.height * 0.083),
      Offset(size.width * 0.69, size.height * 0.25),
      paint,
    );

    // Calendar body
    final rect = RRect.fromLTRBR(
      size.width * 0.819, 
      size.height * 0.167, 
      size.width * 0.902, 
      size.height * 0.917,
      Radius.circular(size.width * 0.042)
    );
    canvas.drawRRect(rect, paint);

    // Horizontal line separator
    canvas.drawLine(
      Offset(size.width * 0.152, size.height * 0.417),
      Offset(size.width * 0.902, size.height * 0.417),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ProgressIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3328BF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Bar 1
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.833),
      Offset(size.width * 0.5, size.height * 0.417),
      paint,
    );
    
    // Bar 2
    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.833),
      Offset(size.width * 0.75, size.height * 0.167),
      paint,
    );
    
    // Bar 3
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.833),
      Offset(size.width * 0.25, size.height * 0.667),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ApplicationsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3328BF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Document outline
    final docPath = Path();
    docPath.moveTo(size.width * 0.635, size.height * 0.083);
    docPath.lineTo(size.width * 0.26, size.height * 0.083);
    docPath.cubicTo(
      size.width * 0.24, size.height * 0.083,
      size.width * 0.224, size.height * 0.096,
      size.width * 0.218, size.height * 0.115
    );
    docPath.cubicTo(
      size.width * 0.213, size.height * 0.135,
      size.width * 0.177, size.height * 0.167,
      size.width * 0.177, size.height * 0.167
    );
    docPath.lineTo(size.width * 0.177, size.height * 0.833);
    docPath.cubicTo(
      size.width * 0.177, size.height * 0.854,
      size.width * 0.188, size.height * 0.873,
      size.width * 0.208, size.height * 0.885
    );
    docPath.cubicTo(
      size.width * 0.229, size.height * 0.896,
      size.width * 0.255, size.height * 0.917,
      size.width * 0.26, size.height * 0.917
    );
    docPath.lineTo(size.width * 0.76, size.height * 0.917);
    docPath.cubicTo(
      size.width * 0.781, size.height * 0.917,
      size.width * 0.8, size.height * 0.906,
      size.width * 0.812, size.height * 0.885
    );
    docPath.cubicTo(
      size.width * 0.823, size.height * 0.865,
      size.width * 0.844, size.height * 0.854,
      size.width * 0.844, size.height * 0.833
    );
    docPath.lineTo(size.width * 0.844, size.height * 0.292);
    docPath.lineTo(size.width * 0.635, size.height * 0.083);
    
    canvas.drawPath(docPath, paint);
    
    // Corner fold
    final cornerPath = Path();
    cornerPath.moveTo(size.width * 0.594, size.height * 0.083);
    cornerPath.lineTo(size.width * 0.594, size.height * 0.25);
    cornerPath.cubicTo(
      size.width * 0.594, size.height * 0.271,
      size.width * 0.604, size.height * 0.29,
      size.width * 0.625, size.height * 0.302
    );
    cornerPath.cubicTo(
      size.width * 0.646, size.height * 0.313,
      size.width * 0.672, size.height * 0.333,
      size.width * 0.677, size.height * 0.333
    );
    cornerPath.lineTo(size.width * 0.844, size.height * 0.333);
    
    canvas.drawPath(cornerPath, paint);
    
    // Lines on document
    canvas.drawLine(
      Offset(size.width * 0.427, size.height * 0.375),
      Offset(size.width * 0.344, size.height * 0.375),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.677, size.height * 0.542),
      Offset(size.width * 0.344, size.height * 0.542),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.677, size.height * 0.708),
      Offset(size.width * 0.344, size.height * 0.708),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PathfinderIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3328BF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Compass needle path
    final needlePath = Path();
    needlePath.moveTo(size.width * 0.703, size.height * 0.323);
    needlePath.lineTo(size.width * 0.625, size.height * 0.563);
    needlePath.cubicTo(
      size.width * 0.615, size.height * 0.593,
      size.width * 0.599, size.height * 0.62,
      size.width * 0.573, size.height * 0.635
    );
    needlePath.cubicTo(
      size.width * 0.547, size.height * 0.651,
      size.width * 0.516, size.height * 0.656,
      size.width * 0.484, size.height * 0.651
    );
    needlePath.lineTo(size.width * 0.349, size.height * 0.677);
    needlePath.lineTo(size.width * 0.422, size.height * 0.448);
    needlePath.cubicTo(
      size.width * 0.432, size.height * 0.419,
      size.width * 0.448, size.height * 0.391,
      size.width * 0.474, size.height * 0.375
    );
    needlePath.cubicTo(
      size.width * 0.5, size.height * 0.36,
      size.width * 0.531, size.height * 0.354,
      size.width * 0.563, size.height * 0.359
    );
    needlePath.close();
    
    canvas.drawPath(needlePath, paint);
    
    // Compass circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.417,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CheckIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3328BF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Check mark path
    final checkPath = Path();
    checkPath.moveTo(size.width * 0.833, size.height * 0.25);
    checkPath.lineTo(size.width * 0.375, size.height * 0.708);
    checkPath.lineTo(size.width * 0.167, size.height * 0.5);
    
    canvas.drawPath(checkPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}