import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/auth_provider.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _testimonialAnimationController;
  late PageController _testimonialPageController;
  Timer? _testimonialTimer;
  bool _isVideoInitialized = false;
  bool _showTranscript = false;
  bool _isMonthly = true;
  int _currentTestimonialIndex = 0;
  final List<bool> _faqExpanded = [false, false, false, false, false, false];

  // Enhanced testimonials data
  final List<Map<String, String>> _testimonials = [
    {
      'name': 'Lebo M.',
      'role': 'Business Management Student',
      'text': 'This platform made my course application process so easy! Highly recommended!',
      'avatar': 'L'
    },
    {
      'name': 'Iviwe M',
      'role': 'Information Systems Student',
      'text': 'Guideian helped me navigate the complex world of university applications. # I am Guideian.',
      'avatar': 'I'
    },
    {
      'name': 'Busisiwe M',
      'role': 'Medical Student',
      'text': 'The career exploration tools opened my eyes to possibilities I never considered. Thanks to Guideian, I\'m now pursuing my dream.',
      'avatar': 'B'
    },
  ];

  // Demo transcript
  final String _demoTranscript = '''
Welcome to Guideian - Your roadmap to a bright future!

[00:00] Hello and welcome to our comprehensive platform demonstration.

[00:15] In this video, we'll explore how Guideian simplifies your journey from high school to university.

[00:30] First, let's look at our Assisted Subject Selection tool - helping you choose the right subjects that align with your career goals.

[00:45] Our High School Navigation feature provides step-by-step guidance through your academic journey, ensuring you stay on track.

[01:00] The Automated Application system streamlines university applications, making the process stress-free and efficient.

[01:15] Our Course Selection Assistance uses AI to match you with programs that fit your interests and strengths.

[01:30] We also provide comprehensive Bursary Application Support, connecting you with financial aid opportunities.

[01:45] The Progress Monitoring feature keeps you motivated and on track with personalized insights and recommendations.

[02:00] Finally, our Career Exploration Tools help you discover exciting career paths that match your potential.

[02:15] With partnerships across 26 universities and 76 TVET colleges, we're here to support your educational journey every step of the way.

[02:30] Thank you for watching! Ready to take charge of your future? Sign up today and let's build your bright future together.
  ''';

  // Enhanced FAQ data
  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I know which courses are right for me?',
      'answer': 'Our AI-powered Course Selection Assistance analyzes your interests, strengths, and career goals to recommend the best-fit programs. We also provide detailed course information and career outcome data to help you make informed decisions.'
    },
    {
      'question': 'Does Guideian handle university applications for me?',
      'answer': 'Yes! Our Automated Application system streamlines the entire process. We help you complete applications, track deadlines, and provide status updates. You maintain control while we handle the complex paperwork and submissions.'
    },
    {
      'question': 'How does Subject Selection Support work?',
      'answer': 'Our Assisted Subject Selection tool evaluates your career aspirations and academic strengths to recommend optimal subject combinations. We provide detailed explanations of how each subject contributes to your chosen career path.'
    },
    {
      'question': 'What bursaries and financial aid options are available?',
      'answer': 'We provide access to over 40 bursary opportunities including NSFAS, SETA funds, and private scholarships. Our system matches you with relevant funding options based on your academic profile and financial need.'
    },
    {
      'question': 'Can I change my career path after starting with Guideian?',
      'answer': 'Absolutely! Our Career Exploration Tools are designed to help you discover new possibilities at any stage. You can reassess your interests and goals, and we\'ll provide updated recommendations and guidance.'
    },
    {
      'question': 'How do you ensure my personal information is secure?',
      'answer': 'We use enterprise-grade encryption and follow strict data protection protocols. Your information is stored securely and never shared with third parties without your explicit consent. We comply with all relevant privacy regulations.'
    }
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _initializeTestimonials();
  }

  void _initializeVideo() {
    // Using a sample video URL - replace with your actual video
    _videoController = VideoPlayerController.network(
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    )..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
          });
        }
      }).catchError((error) {
        print('Video initialization error: $error');
      });
  }

  void _initializeTestimonials() {
    _testimonialAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _testimonialPageController = PageController();
    _startTestimonialTimer();
  }

  void _startTestimonialTimer() {
    _testimonialTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        _nextTestimonial();
      }
    });
  }

  void _nextTestimonial() {
    setState(() {
      _currentTestimonialIndex = (_currentTestimonialIndex + 1) % _testimonials.length;
    });
    _testimonialPageController.animateToPage(
      _currentTestimonialIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _previousTestimonial() {
    setState(() {
      _currentTestimonialIndex = (_currentTestimonialIndex - 1 + _testimonials.length) % _testimonials.length;
    });
    _testimonialPageController.animateToPage(
      _currentTestimonialIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _testimonialAnimationController.dispose();
    _testimonialPageController.dispose();
    _testimonialTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation Bar
            _buildNavbar(context),
            
            // Hero Section
            _buildHeroSection(context),
            
            // About Section
            _buildAboutSection(context),
            
            // Services Section
            _buildServicesSection(context),
            
            // Enhanced Demo Section with Video
            _buildEnhancedDemoSection(context),
            
            // Metrics Section
            _buildMetricsSection(context),
            
            // Enhanced Testimonial Section
            _buildEnhancedTestimonialSection(context),
            
            // Enhanced Pricing Section
            _buildEnhancedPricingSection(context),
            
            // Enhanced FAQ Section
            _buildEnhancedFaqSection(context),
            
            // Footer
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

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
                isActive: true,
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

  Widget _buildLogo() {
    return SizedBox(
      width: 217,
      height: 55,
      child: CustomPaint(
        painter: GuideianLogoPainter(),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FC),
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
      child: Row(
        children: [
          // Left Content
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TAKE CHARGE OF YOUR FUTURE TODAY!',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Allow us to help you explore career paths that excite you and match your strengths. We\'ll guide you to find what fits you best, step by step. Get ready for university with confidence, all in one place.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF666666),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3328BF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/about'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF666666),
                        side: const BorderSide(color: Colors.transparent),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const SizedBox(),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Learn More',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xFF666666),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 80),
          // Right Images
          Expanded(
            flex: 1,
            child: _buildHeroImages(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImages() {
    return SizedBox(
      height: 580,
      child: Column(
        children: [
          // Main image container
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/44e7185e2b48b74f76012dc3eeb654de7a73b86f?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE6E9FA),
                    child: const Center(
                      child: Icon(
                        Icons.school,
                        size: 100,
                        color: Color(0xFF3328BF),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 20), // spacing between them
          
          // Overlay image
          Container(
            width: double.infinity,
            height: 260,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/05f3f9e9a5c89bc728dc553d9e82845a78b9a6d7?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                    child: const Center(
                      child: Icon(
                        Icons.assignment_turned_in,
                        size: 60,
                        color: Color(0xFF3328BF),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
      child: Column(
        children: [
          Text(
            'Guideian, your roadmap to a bright future',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'At Guideian, we\'re dedicated to simplifying your journey from high school to university. Our goal is to help you explore career paths that inspire you, choose courses that suit your ambitions, and apply to universities with ease and confidence. With expert guidance and tailored tools, we\'re here to ensure you\'re ready for a future that matches your potential.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FC),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        children: [
          // First row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ServiceCard(
                icon: Icons.book_outlined,
                title: 'Assisted Subject Selection',
                description: 'Helping you navigate your educational journey with confidence.',
                buttonText: 'Try Now',
                onTap: () => context.go('/subject-selection'),
              ),
              _ServiceCard(
                icon: Icons.school_outlined,
                title: 'High School Navigation',
                description: 'Helping you navigate your educational journey with confidence.',
                buttonText: 'Try Now',
                onTap: () => context.go('/coming-soon'),
              ),
              _ServiceCard(
                icon: Icons.assignment_turned_in_outlined,
                title: 'Automated Application',
                description: 'Helping you navigate your educational journey with confidence.',
                buttonText: 'Try Now',
                onTap: () => context.go('/coming-soon'),
              ),
              _ServiceCard(
                icon: Icons.psychology_outlined,
                title: 'Course Selection\nAssistance',
                description: 'Helping you navigate your educational journey with confidence.',
                buttonText: 'Try Now',
                onTap: () => context.go('/coming-soon'),
              ),
            ],
          ),
          const SizedBox(height: 40),
          // Second row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ServiceCard(
                icon: Icons.monetization_on_outlined,
                title: 'Bursary Application Support',
                description: 'Helping you navigate your educational journey with confidence.',
                buttonText: 'Try Now',
                onTap: () => context.go('/coming-soon'),
              ),
              const SizedBox(width: 40),
              _ServiceCard(
                icon: Icons.trending_up_outlined,
                title: 'Progress Monitoring &\nMotivation',
                description: 'Helping you navigate your educational journey with confidence.',
                buttonText: 'Try Now',
                onTap: () => context.go('/coming-soon'),
              ),
              const SizedBox(width: 40),
              _ServiceCard(
                icon: Icons.explore_outlined,
                title: 'Career Exploration Tools',
                description: 'Helping you navigate your educational journey with confidence.',
                buttonText: 'Try Now',
                onTap: () => context.go('/coming-soon'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedDemoSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
      child: Column(
        children: [
          Text(
            'Experience Guideian',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Watch how our platform makes educational planning and university applications simple, intuitive, and effective. This is just the tip of the iceberg, sign up and explore it yourself!',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          // Video Player
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _isVideoInitialized
                  ? Stack(
                      children: [
                        VideoPlayer(_videoController),
                        // Custom video controls
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_videoController.value.isPlaying) {
                                        _videoController.pause();
                                      } else {
                                        _videoController.play();
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    _videoController.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: VideoProgressIndicator(
                                    _videoController,
                                    allowScrubbing: true,
                                    colors: const VideoProgressColors(
                                      playedColor: Color(0xFF3328BF),
                                      backgroundColor: Colors.white24,
                                      bufferedColor: Colors.white38,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${_formatDuration(_videoController.value.position)} / ${_formatDuration(_videoController.value.duration)}',
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Center play button when paused
                        if (!_videoController.value.isPlaying)
                          const Center(
                            child: Icon(
                              Icons.play_circle_filled,
                              size: 80,
                              color: Color(0xFF3328BF),
                            ),
                          ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF3328BF),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 24),
          // Transcript Section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _showTranscript = !_showTranscript;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3328BF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.text_snippet,
                            color: Color(0xFF3328BF),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'View Video Transcript',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1A1A1A),
                                ),
                              ),
                              Text(
                                'Read along with the video content',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          _showTranscript ? Icons.expand_less : Icons.expand_more,
                          color: const Color(0xFF666666),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_showTranscript)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _demoTranscript,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF1A1A1A),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  Widget _buildMetricsSection(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FC),
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          ),
          const SizedBox(height: 60),
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
    );
  }

  Widget _buildEnhancedTestimonialSection(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
    child: Column(
      children: [
        Text(
          'Testimonial',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3328BF),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Experiences Shared by Our Clients',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A1A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        // Animated testimonial slider
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous button
            IconButton(
              onPressed: _previousTestimonial,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF666666),
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Testimonial cards container
            SizedBox(
              width: 600,
              height: 200,
              child: PageView.builder(
                controller: _testimonialPageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentTestimonialIndex = index;
                  });
                },
                itemCount: _testimonials.length,
                itemBuilder: (context, index) {
                  final testimonial = _testimonials[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            testimonial['text'] ?? 'No testimonial text available',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF666666),
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3328BF),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  (testimonial['avatar'] ?? testimonial['name']?.substring(0, 1) ?? 'U').toUpperCase(),
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
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
                                    testimonial['name'] ?? 'Unknown User',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                  Text(
                                    testimonial['role'] ?? 'Client',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3328BF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.format_quote,
                                color: Color(0xFF3328BF),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 20),
            // Next button
            IconButton(
              onPressed: _nextTestimonial,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_testimonials.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentTestimonialIndex == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentTestimonialIndex == index
                    ? const Color(0xFF3328BF)
                    : const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

  Widget _buildEnhancedPricingSection(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FC),
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
      child: Column(
        children: [
          Text(
            'Choose your plan',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Unlock your potential with our flexible pricing options',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Monthly/Annual Toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _isMonthly = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: _isMonthly ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: _isMonthly
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      'Monthly',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _isMonthly ? const Color(0xFF1A1A1A) : const Color(0xFF666666),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isMonthly = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: !_isMonthly ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: !_isMonthly
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Annual',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: !_isMonthly ? const Color(0xFF1A1A1A) : const Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Save 20%',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _EnhancedPricingCard(
                planName: 'Free',
                price: _isMonthly ? 'R0' : 'R0',
                period: _isMonthly ? '/month' : '/year',
                originalPrice: '',
                features: [
                  _PricingFeature(text: 'Access to AI Chatbot', included: true),
                  _PricingFeature(text: 'Basic Calendar Features', included: true),
                  _PricingFeature(text: 'High School Navigation Guide', included: true),
                  _PricingFeature(text: 'Subject Selection Tool', included: false),
                  _PricingFeature(text: 'Course Exploration', included: false),
                  _PricingFeature(text: 'University Applications', included: false),
                ],
                buttonText: 'Current Plan',
                isPopular: false,
                buttonEnabled: false,
                onTap: () {},
              ),
              const SizedBox(width: 32),
              _EnhancedPricingCard(
                planName: 'Standard',
                price: _isMonthly ? 'R99.99' : 'R959.90',
                period: _isMonthly ? '/month' : '/year',
                originalPrice: _isMonthly ? '' : 'R1,199.88',
                features: [
                  _PricingFeature(text: 'Everything in Free', included: true),
                  _PricingFeature(text: 'Advanced AI Chatbot', included: true),
                  _PricingFeature(text: 'Full Calendar Integration', included: true),
                  _PricingFeature(text: 'Subject Selection Tool', included: true),
                  _PricingFeature(text: 'Course Exploration Tool', included: true),
                  _PricingFeature(text: 'Course Selection Assistance', included: true),
                  _PricingFeature(text: '5 Free Applications', included: true),
                  _PricingFeature(text: 'Email Support', included: true),
                ],
                buttonText: 'Get Started',
                isPopular: true,
                buttonEnabled: true,
                onTap: () {},
              ),
              const SizedBox(width: 32),
              _EnhancedPricingCard(
                planName: 'Premium',
                price: _isMonthly ? 'R199.99' : 'R1,919.90',
                period: _isMonthly ? '/month' : '/year',
                originalPrice: _isMonthly ? '' : 'R2,399.88',
                features: [
                  _PricingFeature(text: 'Everything in Standard', included: true),
                  _PricingFeature(text: 'Unlimited Applications', included: true),
                  _PricingFeature(text: 'Automated Application System', included: true),
                  _PricingFeature(text: 'Bursary Application Support', included: true),
                  _PricingFeature(text: 'Progress Monitoring', included: true),
                  _PricingFeature(text: 'Priority Support', included: true),
                  _PricingFeature(text: 'Career Counseling Sessions', included: true),
                  _PricingFeature(text: 'University Partner Discounts', included: true),
                ],
                buttonText: 'Go Premium',
                isPopular: false,
                buttonEnabled: true,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedFaqSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 80),
      child: Column(
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
            'Get answers to common questions about our platform and services. Can\'t find what you\'re looking for? Contact our support team.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FAQ Questions
              Expanded(
                flex: 2,
                child: Column(
                  children: List.generate(_faqs.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _faqExpanded[index] = !_faqExpanded[index];
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _faqs[index]['question']!,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1A1A1A),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: _faqExpanded[index]
                                            ? const Color(0xFF3328BF).withOpacity(0.1)
                                            : const Color(0xFFF8F9FC),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        _faqExpanded[index] ? Icons.remove : Icons.add,
                                        color: _faqExpanded[index]
                                            ? const Color(0xFF3328BF)
                                            : const Color(0xFF666666),
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (_faqExpanded[index])
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                child: Text(
                                  _faqs[index]['answer']!,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF666666),
                                    height: 1.6,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 60),
              // FAQ Image
              Expanded(
                flex: 1,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E9FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/081086675d11d3264868bdfbc306cb6ffb6311fd?placeholderIfAbsent=true&apiKey=f23ba570a18b45479194cf824b4200ba',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE6E9FA),
                          child: const Center(
                            child: Icon(
                              Icons.help_outline,
                              size: 80,
                              color: Color(0xFF3328BF),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          // Contact prompt
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Still have questions?',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Our friendly support team is here to help. Reach out and we\'ll get back to you as soon as possible.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                ElevatedButton.icon(
                  onPressed: () => context.go('/contact'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3328BF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.mail_outline, size: 20),
                  label: Text(
                    'Contact Support',
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
    );
  }

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
}

// Navigation Link Widget
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

// Service Card Widget
class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E9FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 40,
                    color: const Color(0xFF3328BF),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF666666),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF3328BF),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Metric Card Widget
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

// Pricing Feature Model
class _PricingFeature {
  final String text;
  final bool included;

  const _PricingFeature({
    required this.text,
    required this.included,
  });
}

// Enhanced Pricing Card Widget
class _EnhancedPricingCard extends StatelessWidget {
  final String planName;
  final String price;
  final String period;
  final String originalPrice;
  final List<_PricingFeature> features;
  final String buttonText;
  final bool isPopular;
  final bool buttonEnabled;
  final VoidCallback onTap;

  const _EnhancedPricingCard({
    required this.planName,
    required this.price,
    required this.period,
    required this.originalPrice,
    required this.features,
    required this.buttonText,
    required this.isPopular,
    required this.buttonEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isPopular
            ? Border.all(color: const Color(0xFF3328BF), width: 2)
            : Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isPopular ? 0.15 : 0.05),
            blurRadius: isPopular ? 20 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (isPopular)
            Positioned(
              top: -1,
              left: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF3328BF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  'Most Popular',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, isPopular ? 48 : 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  planName,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      period,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
                if (originalPrice.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'was $originalPrice',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF999999),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                // Features
                ...features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: feature.included
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFE5E7EB),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              feature.included ? Icons.check : Icons.close,
                              size: 14,
                              color: feature.included
                                  ? Colors.white
                                  : const Color(0xFF999999),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature.text,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: feature.included
                                    ? const Color(0xFF1A1A1A)
                                    : const Color(0xFF999999),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 24),
                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: buttonEnabled ? onTap : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonEnabled
                          ? (isPopular ? const Color(0xFF3328BF) : const Color(0xFF1A1A1A))
                          : const Color(0xFFE5E7EB),
                      foregroundColor: buttonEnabled
                          ? Colors.white
                          : const Color(0xFF9CA3AF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      buttonText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Footer Link Widget
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

// Social Media Icon Widget
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

// Custom painter for the Guideian logo
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