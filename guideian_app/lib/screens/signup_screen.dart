import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/navbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _selectedGrade = '';
  double _passwordStrength = 0.0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength(String password) {
    double strength = 0.0;
    if (password.length >= 8) strength += 0.2;
    if (password.length >= 12) strength += 0.2;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[a-z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.1;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) strength += 0.1;
    
    setState(() {
      _passwordStrength = strength;
    });
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms and conditions')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.signup(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      
      if (authProvider.isLoggedIn && mounted) {
        context.go('/subject-selection');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${e.toString()}')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Navbar(
            onHomeTap: () => context.go('/'),
            onServicesTap: () => context.go('/services'),
            onAboutTap: () => context.go('/about'),
            onContactTap: () => context.go('/contact'),
            onLoginTap: () => context.go('/login'),
            onSignupTap: () => context.go('/signup'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: const EdgeInsets.all(40),
                child: Row(
                  children: [
                    // Signup Form Section
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormHeader(),
                              const SizedBox(height: 30),
                              _buildSignupForm(),
                              const SizedBox(height: 20),
                              _buildTermsCheckbox(),
                              const SizedBox(height: 20),
                              _buildSignupButton(),
                              const SizedBox(height: 20),
                              _buildDivider(),
                              const SizedBox(height: 20),
                              _buildSocialLogin(),
                              const SizedBox(height: 20),
                              _buildLoginLink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Hero Section
                    Expanded(
                      child: Container(
                        height: 600,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              _buildFeatureItem(Icons.check, 'Personalized subject selection guidance'),
                              _buildFeatureItem(Icons.check, 'Track your academic progress'),
                              _buildFeatureItem(Icons.check, 'Simplified university application process'),
                              _buildFeatureItem(Icons.check, 'Expert support from educational advisors'),
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

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF3328BF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 14,
              color: Colors.white,
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
      ),
    );
  }

  Widget _buildFormHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Join Guideian',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D0D0D),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Start your educational journey today',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            prefixIcon: const Icon(Icons.person_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3328BF)),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            if (value.length < 2) {
              return 'Name must be at least 2 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email Address',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3328BF)),
            ),
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
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          onChanged: _updatePasswordStrength,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3328BF)),
            ),
          ),
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
        const SizedBox(height: 8),
        _buildPasswordStrengthIndicator(),
        const SizedBox(height: 20),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3328BF)),
            ),
          ),
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
        DropdownButtonFormField<String>(
          value: _selectedGrade.isEmpty ? null : _selectedGrade,
          decoration: InputDecoration(
            labelText: 'Current Grade',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3328BF)),
            ),
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

  Widget _buildPasswordStrengthIndicator() {
    Color strengthColor;
    String strengthText;
    
    if (_passwordStrength <= 0.2) {
      strengthColor = Colors.red;
      strengthText = 'Weak - try adding more characters, numbers, or symbols';
    } else if (_passwordStrength <= 0.4) {
      strengthColor = Colors.orange;
      strengthText = 'Moderate - could be stronger';
    } else if (_passwordStrength <= 0.6) {
      strengthColor = Colors.yellow;
      strengthText = 'Strong - good password';
    } else {
      strengthColor = Colors.green;
      strengthText = 'Very strong - excellent password';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _passwordStrength,
            child: Container(
              decoration: BoxDecoration(
                color: strengthColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          strengthText,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: const Color(0xFF3328BF),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: 'I agree to the ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    color: Color(0xFF3328BF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: Color(0xFF3328BF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignup,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3328BF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Or sign up with',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // Handle Google signup
            },
            icon: const Icon(Icons.g_mobiledata, color: Color(0xFF4285F4)),
            label: const Text('Sign up with Google'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // Handle Facebook signup
            },
            icon: const Icon(Icons.facebook, color: Color(0xFF1877F2)),
            label: const Text('Continue with Facebook'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 15,
          ),
        ),
        TextButton(
          onPressed: () => context.go('/login'),
          child: const Text(
            'Log In',
            style: TextStyle(
              color: Color(0xFF3328BF),
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}