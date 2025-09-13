import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/auth_provider.dart';
import '../widgets/password_strength_indicator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;
  bool _isLoading = false;
  String _selectedGrade = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms and conditions')),
      );
      return;
    }

    if (_selectedGrade.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your grade')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final error = await authProvider.signup(
      _emailController.text.trim(),
      _passwordController.text,
      _fullNameController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (error == null) {
      if (mounted) {
        context.go('/');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  Future<void> _handleGoogleSignup() async {
    setState(() => _isLoading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final error = await authProvider.signInWithGoogle();

    setState(() => _isLoading = false);

    if (error == null) {
      if (mounted) {
        context.go('/');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                // Logo
                CustomPaint(
                  size: const Size(217, 55),
                  painter: GuideianLogoPainter(),
                ),
                const Spacer(),
                // Navigation links
                Row(
                  children: [
                    _NavLink(text: 'Home', onTap: () => context.go('/')),
                    _NavLink(text: 'Services', onTap: () => context.go('/services')),
                    _NavLink(text: 'About Us', onTap: () => context.go('/about')),
                    _NavLink(text: 'Contact us', onTap: () => context.go('/contact')),
                  ],
                ),
                const Spacer(),
                // Auth buttons
                Row(
                  children: [
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFF3328BF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3328BF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextButton(
                        onPressed: () => context.go('/signup'),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Signup Form
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              // Form Header
                              const Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Join Guideian',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Start your educational journey today',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF4B5563),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Full Name Field
                              _buildFormField(
                                controller: _fullNameController,
                                label: 'Full Name',
                                hint: 'Your full name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your full name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              // Email Field
                              _buildFormField(
                                controller: _emailController,
                                label: 'Email Address',
                                hint: 'your.email@example.com',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              // Password Field
                              _buildPasswordField(
                                controller: _passwordController,
                                label: 'Password',
                                hint: '••••••••',
                                isConfirmPassword: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              // Password Strength Indicator
                              ValueListenableBuilder<TextEditingValue>(
                                valueListenable: _passwordController,
                                builder: (context, value, child) {
                                  return PasswordStrengthIndicator(
                                    password: value.text,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              // Confirm Password Field
                              _buildPasswordField(
                                controller: _confirmPasswordController,
                                label: 'Confirm Password',
                                hint: '••••••••',
                                isConfirmPassword: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              // Grade Selection
                              _buildGradeSelector(),
                              const SizedBox(height: 20),
                              // Terms Agreement
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _agreeTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        _agreeTerms = value ?? false;
                                      });
                                    },
                                    activeColor: const Color(0xFF3328BF),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF4B5563),
                                          ),
                                          children: [
                                            TextSpan(text: 'I agree to the '),
                                            TextSpan(
                                              text: 'Terms of Service',
                                              style: TextStyle(
                                                color: Color(0xFF3328BF),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(text: ' and '),
                                            TextSpan(
                                              text: 'Privacy Policy',
                                              style: TextStyle(
                                                color: Color(0xFF3328BF),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(text: ' *'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Sign Up Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _handleSignup,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3328BF),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              // Divider
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Or sign up with',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4B5563),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Social Login
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: OutlinedButton.icon(
                                  onPressed: _isLoading ? null : _handleGoogleSignup,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.google,
                                    size: 20,
                                    color: Color(0xFF3328BF),
                                  ),
                                  label: const Text(
                                    'Sign up with Google',
                                    style: TextStyle(
                                      color: Color(0xFF111827),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Login Link
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF111827),
                                    ),
                                    children: [
                                      const TextSpan(text: 'Already have an account? '),
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap: () => context.go('/login'),
                                          child: const Text(
                                            'Log In',
                                            style: TextStyle(
                                              color: Color(0xFF3328BF),
                                              fontWeight: FontWeight.w500,
                                            ),
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
                        ),
                      ),
                    ),
                    // Hero Content
                    Expanded(
                      child: Container(
                        height: 500,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Colors.black.withOpacity(0.7),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Begin Your Journey with Guideian',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Join thousands of South African students who are using our platform to navigate their educational path with confidence.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Feature List
                              Column(
                                children: [
                                  _buildFeatureItem('Personalized subject selection guidance'),
                                  const SizedBox(height: 15),
                                  _buildFeatureItem('Track your academic progress'),
                                  const SizedBox(height: 15),
                                  _buildFeatureItem('Simplified university application process'),
                                  const SizedBox(height: 15),
                                  _buildFeatureItem('Expert support from educational advisors'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFF3328BF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3328BF), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isConfirmPassword,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isConfirmPassword ? _obscureConfirmPassword : _obscurePassword,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3328BF), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            suffixIcon: IconButton(
              icon: Icon(
                (isConfirmPassword ? _obscureConfirmPassword : _obscurePassword) 
                    ? Icons.visibility_off 
                    : Icons.visibility,
                color: const Color(0xFF9CA3AF),
              ),
              onPressed: () {
                setState(() {
                  if (isConfirmPassword) {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  } else {
                    _obscurePassword = !_obscurePassword;
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current Grade *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedGrade.isEmpty ? null : _selectedGrade,
          decoration: InputDecoration(
            hintText: 'Select your grade',
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3328BF), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
          items: const [
            DropdownMenuItem(value: '9', child: Text('Grade 9')),
            DropdownMenuItem(value: '10', child: Text('Grade 10')),
            DropdownMenuItem(value: '11', child: Text('Grade 11')),
            DropdownMenuItem(value: '12', child: Text('Grade 12')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedGrade = value ?? '';
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your grade';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _NavLink({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class GuideianLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw the curved lines from the SVG
    final path1 = Path()
      ..moveTo(55.0188, 1)
      ..cubicTo(55.0188, 1, 40.0187, 1, 25.0188, 1)
      ..cubicTo(10.0189, 1, 0.518789, 17, 1.01882, 28)
      ..cubicTo(1.51886, 39, 9.01882, 52.7638, 25.0188, 53)
      ..cubicTo(41.0188, 53.2362, 54.0188, 53, 54.0188, 53)
      ..lineTo(54.0188, 28);
    canvas.drawPath(path1, paint);

    final path2 = Path()
      ..moveTo(55.0188, 5)
      ..cubicTo(55.0188, 5, 38.0188, 5, 26.5188, 5)
      ..cubicTo(15.0188, 5, 5.0188, 14.3256, 5.0188, 28)
      ..cubicTo(5.0188, 41.6744, 16.0323, 49, 27.0188, 49)
      ..cubicTo(38.0053, 49, 50.0188, 49, 50.0188, 49)
      ..lineTo(50.0188, 40)
      ..lineTo(50.0188, 28);
    canvas.drawPath(path2, paint);

    final path3 = Path()
      ..moveTo(55.0188, 9)
      ..cubicTo(55.0188, 9, 33.473, 9, 25.9207, 9)
      ..cubicTo(18.3683, 9, 9.0188, 17.1554, 9.0188, 28)
      ..cubicTo(9.0188, 38.8446, 17.2723, 45.5, 26.0188, 45.5)
      ..cubicTo(34.7653, 45.5, 46.0188, 45.5, 46.0188, 45.5)
      ..lineTo(46.0188, 37.5)
      ..lineTo(46.0188, 28);
    canvas.drawPath(path3, paint);

    final path4 = Path()
      ..moveTo(55.0188, 13)
      ..cubicTo(55.0188, 13, 32.2727, 13, 26.2633, 13)
      ..cubicTo(20.2539, 13, 13.0188, 18.9385, 13.0188, 27.5)
      ..cubicTo(13.0188, 36.0615, 20.0188, 41, 26.5188, 41.5)
      ..cubicTo(33.0188, 42, 42.0188, 41.5, 42.0188, 41.5)
      ..lineTo(42.0188, 28);
    canvas.drawPath(path4, paint);

    final path5 = Path()
      ..moveTo(55.0189, 17)
      ..cubicTo(55.0189, 17, 35.6287, 17, 28.0738, 17)
      ..cubicTo(20.5189, 17, 16.5189, 21.5, 17.0189, 28)
      ..cubicTo(17.5189, 34.5, 23.1612, 37.5, 28.0738, 37.5)
      ..cubicTo(32.9865, 37.5, 38.0189, 37.5, 38.0189, 37.5)
      ..lineTo(38.0189, 28);
    canvas.drawPath(path5, paint);

    final path6 = Path()
      ..moveTo(55.0188, 21)
      ..cubicTo(55.0188, 21, 29.7875, 21, 27.1858, 21)
      ..cubicTo(24.5841, 21, 21.0188, 23.4418, 21.0188, 27.1518)
      ..cubicTo(21.0188, 30.8618, 23.5188, 34, 27.1858, 34)
      ..cubicTo(30.8529, 34, 34.0188, 34, 34.0188, 34)
      ..lineTo(34.0188, 28);
    canvas.drawPath(path6, paint);

    // Add text "Guideian"
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Guideian',
        style: TextStyle(
          color: Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.normal,
          fontFamily: 'Tenor Sans',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      const Offset(63, 25.71 - 26), // Adjust for text baseline
    );

    // Add text "Future Ready"
    final subtitlePainter = TextPainter(
      text: const TextSpan(
        text: 'Future Ready',
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.normal,
          fontFamily: 'Tenor Sans',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    subtitlePainter.layout();
    subtitlePainter.paint(
      canvas,
      const Offset(64, 45.855 - 13), // Adjust for text baseline
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}