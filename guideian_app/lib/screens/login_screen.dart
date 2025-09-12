import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.login(_emailController.text, _passwordController.text);
      
      if (authProvider.isLoggedIn && mounted) {
        context.go('/subject-selection');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleDemoLogin() {
    setState(() {
      _emailController.text = 'user@example.com';
      _passwordController.text = 'Password123!';
    });
  }

  void _handleSocialLogin(String provider) {
    setState(() {
      _isLoading = true;
    });
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$provider login is not implemented yet'),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(screenWidth),
            _buildMainContent(screenWidth),
            _buildCTASection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: const Border(
          bottom: BorderSide(color: Color(0xFFF1F1F1), width: 1),
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: screenWidth > 768
            ? _buildDesktopHeader()
            : _buildMobileHeader(),
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 32),
          child: _buildLogo(),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavLink('Home', false, () => context.go('/')),
              const SizedBox(width: 32),
              _buildNavLink('Services', false, () => context.go('/services')),
              const SizedBox(width: 32),
              _buildNavLink('About Us', false, () => context.go('/about')),
              const SizedBox(width: 32),
              _buildNavLink('Contact us', false, () => context.go('/contact')),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 32),
          child: Row(
            children: [
              _buildAuthButton('Log In', true, () {}, active: true),
              const SizedBox(width: 12),
              _buildAuthButton('Sign Up', false, () => context.go('/signup')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Row(
      children: [
        _buildLogo(),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF212529)),
          onPressed: () {
            // Handle mobile menu
          },
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 217,
          height: 55,
          child: Stack(
            children: [
              const Positioned(
                left: 63,
                top: 0,
                child: Text(
                  'Guideian',
                  style: TextStyle(
                    fontFamily: 'Tenor Sans',
                    fontSize: 26,
                    color: Colors.black,
                    height: 1.0,
                  ),
                ),
              ),
              const Positioned(
                left: 64,
                top: 32,
                child: Text(
                  'Future Ready',
                  style: TextStyle(
                    fontFamily: 'Tenor Sans',
                    fontSize: 13,
                    color: Colors.black,
                    height: 1.0,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: CustomPaint(
                  size: const Size(60, 55),
                  painter: LogoPainter(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavLink(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? const Color(0xFF3328BF) : const Color(0xFF212529),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton(String text, bool isOutline, VoidCallback onTap, {bool active = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: isOutline || active ? Colors.transparent : const Color(0xFF3328BF),
          border: (isOutline || active) ? Border.all(color: const Color(0xFF3328BF), width: 1.5) : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            color: (isOutline || active) ? const Color(0xFF3328BF) : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(double screenWidth) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      height: 500,
      child: screenWidth > 992
          ? Row(
              children: [
                Expanded(child: _buildHeroSection()),
                Expanded(child: _buildAuthSection()),
              ],
            )
          : Column(
              children: [
                Expanded(child: _buildHeroSection()),
                const SizedBox(height: 20),
                Expanded(child: _buildAuthSection()),
              ],
            ),
    );
  }

  Widget _buildHeroSection() {
    final isDesktop = MediaQuery.of(context).size.width > 992;
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: isDesktop
            ? const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
            : BorderRadius.circular(8),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.7),
            ],
          ),
          borderRadius: isDesktop
              ? const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                )
              : BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Welcome Back to Guideian',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 768 ? 40 : 32,
                fontWeight: FontWeight.normal,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Continue your educational journey and access your personalized tools and resources.',
              style: TextStyle(
                fontSize: 17.6,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                _buildFeatureItem('Track your academic progress'),
                _buildFeatureItem('Access your applications'),
                _buildFeatureItem('Get personalized guidance'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthSection() {
    final isDesktop = MediaQuery.of(context).size.width > 992;
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isDesktop
            ? const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              )
            : BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAuthHeader(),
            const SizedBox(height: 30),
            _buildLoginForm(),
            const SizedBox(height: 30),
            _buildDemoSection(),
            const SizedBox(height: 20),
            _buildSignupLink(),
            const SizedBox(height: 30),
            _buildDivider(),
            const SizedBox(height: 30),
            _buildSocialLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthHeader() {
    return Column(
      children: [
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Your Journey Awaits',
          style: TextStyle(
            color: Color(0xFF6C757D),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: 'Email Address '),
                TextSpan(
                  text: '*',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'your.email@example.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCED4DA)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCED4DA)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF3328BF)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              fillColor: Colors.white,
              filled: true,
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
          const SizedBox(height: 20),
          
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: 'Password '),
                TextSpan(
                  text: '*',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: '••••••••',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCED4DA)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCED4DA)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF3328BF)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF6C757D),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Remember me',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Handle forgot password
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Color(0xFF3328BF),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3328BF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Want to try it out?',
            style: TextStyle(
              color: Color(0xFF6C757D),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _handleDemoLogin,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF3328BF), width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.transparent,
              ),
              child: const Text(
                'Use Demo Account',
                style: TextStyle(
                  color: Color(0xFF3328BF),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () => context.go('/signup'),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Color(0xFF3328BF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFCED4DA),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Or continue with',
            style: TextStyle(
              color: Color(0xFF6C757D),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFCED4DA),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        _buildSocialButton(
          'Log in with Google',
          FontAwesomeIcons.google,
          const Color(0xFF4285F4),
          () => _handleSocialLogin('Google'),
        ),
        const SizedBox(height: 15),
        _buildSocialButton(
          'Continue with Facebook',
          FontAwesomeIcons.facebookF,
          const Color(0xFF1877F2),
          () => _handleSocialLogin('Facebook'),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String text, IconData icon, Color iconColor, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFCED4DA)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: iconColor,
              size: 19.2,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF212529),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTASection() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              "Let's start your journey now!",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 768 ? 40 : 32,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF212529),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.go('/signup'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3328BF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 768) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLogo(),
                            const SizedBox(height: 20),
                            const Text(
                              'Your roadmap to a bright future. We help South African students navigate their educational journey from high school to university.',
                              style: TextStyle(
                                color: Color(0xFF666666),
                                height: 1.7,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildSocialIcons(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      _buildFooterLinks('Quick Links', [
                        'Home', 'Services', 'About Us', 'Contact Us', 'Sign Up'
                      ]),
                      const SizedBox(width: 40),
                      _buildFooterLinks('Resources', [
                        'University Guide', 'Scholarships', 'Career Paths', 'Blog', 'FAQs'
                      ]),
                      const SizedBox(width: 40),
                      _buildContactSection(),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLogo(),
                      const SizedBox(height: 20),
                      const Text(
                        'Your roadmap to a bright future. We help South African students navigate their educational journey from high school to university.',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildFooterLinks('Quick Links', [
                        'Home', 'Services', 'About Us', 'Contact Us', 'Sign Up'
                      ]),
                      const SizedBox(height: 30),
                      _buildFooterLinks('Resources', [
                        'University Guide', 'Scholarships', 'Career Paths', 'Blog', 'FAQs'
                      ]),
                      const SizedBox(height: 30),
                      _buildContactSection(),
                      const SizedBox(height: 20),
                      _buildSocialIcons(),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFDDDDDD)),
                ),
              ),
              child: const Text(
                'Copyright © 2025 Guideian, All rights reserved.',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 14.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterLinks(String title, List<String> links) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19.2,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          ...links.map((link) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                // Handle navigation
              },
              child: Text(
                link,
                style: const TextStyle(
                  color: Color(0xFF212529),
                  fontSize: 16,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 19.2,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          _buildContactItem(Icons.location_on, 'Cape Town, South Africa'),
          _buildContactItem(Icons.email, 'guideian.help@gmail.com'),
          _buildContactItem(Icons.phone, '+27 81 487 5688'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF3328BF),
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    final socialIcons = [
      FontAwesomeIcons.facebookF,
      FontAwesomeIcons.twitter,
      FontAwesomeIcons.instagram,
      FontAwesomeIcons.linkedinIn,
    ];

    return Row(
      children: socialIcons.map((icon) => Container(
        margin: const EdgeInsets.only(right: 15),
        child: GestureDetector(
          onTap: () {
            // Handle social media links
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF333333)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF333333),
              size: 16,
            ),
          ),
        ),
      )).toList(),
    );
  }
}

// Custom painter for the logo to match the exact SVG from HTML
class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Recreate the concentric curved paths from the SVG
    // Outermost path
    final path1 = Path();
    path1.moveTo(55.0188, 1);
    path1.lineTo(25.0188, 1);
    path1.quadraticBezierTo(0.518789, 1, 1.01882, 28);
    path1.quadraticBezierTo(1.51886, 53, 25.0188, 53);
    path1.lineTo(54.0188, 53);
    path1.lineTo(54.0188, 28);
    canvas.drawPath(path1, paint);

    // Second path
    final path2 = Path();
    path2.moveTo(55.0188, 5);
    path2.lineTo(26.5188, 5);
    path2.quadraticBezierTo(5.0188, 5, 5.0188, 28);
    path2.quadraticBezierTo(5.0188, 49, 27.0188, 49);
    path2.lineTo(50.0188, 49);
    path2.lineTo(50.0188, 28);
    canvas.drawPath(path2, paint);

    // Third path
    final path3 = Path();
    path3.moveTo(55.0188, 9);
    path3.lineTo(25.9207, 9);
    path3.quadraticBezierTo(9.0188, 9, 9.0188, 28);
    path3.quadraticBezierTo(9.0188, 45.5, 26.0188, 45.5);
    path3.lineTo(46.0188, 45.5);
    path3.lineTo(46.0188, 28);
    canvas.drawPath(path3, paint);

    // Fourth path
    final path4 = Path();
    path4.moveTo(55.0188, 13);
    path4.lineTo(26.2633, 13);
    path4.quadraticBezierTo(13.0188, 13, 13.0188, 27.5);
    path4.quadraticBezierTo(13.0188, 41.5, 26.5188, 41.5);
    path4.lineTo(42.0188, 41.5);
    path4.lineTo(42.0188, 28);
    canvas.drawPath(path4, paint);

    // Fifth path
    final path5 = Path();
    path5.moveTo(55.0189, 17);
    path5.lineTo(28.0738, 17);
    path5.quadraticBezierTo(16.5189, 17, 17.0189, 28);
    path5.quadraticBezierTo(17.5189, 37.5, 28.0738, 37.5);
    path5.lineTo(38.0189, 37.5);
    path5.lineTo(38.0189, 28);
    canvas.drawPath(path5, paint);

    // Innermost path
    final path6 = Path();
    path6.moveTo(55.0188, 21);
    path6.lineTo(27.1858, 21);
    path6.quadraticBezierTo(21.0188, 21, 21.0188, 27.1518);
    path6.quadraticBezierTo(21.0188, 34, 27.1858, 34);
    path6.lineTo(34.0188, 34);
    path6.lineTo(34.0188, 28);
    canvas.drawPath(path6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}