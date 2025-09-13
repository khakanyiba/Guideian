import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final double width;
  final double height;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.width = double.infinity,
    this.height = 8,
  });

  PasswordStrength _calculateStrength(String password) {
    if (password.isEmpty) return PasswordStrength.none;
    
    int score = 0;
    
    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    
    // Character variety checks
    if (password.contains(RegExp(r'[a-z]'))) score++; // lowercase
    if (password.contains(RegExp(r'[A-Z]'))) score++; // uppercase
    if (password.contains(RegExp(r'[0-9]'))) score++; // numbers
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++; // special chars
    
    // Additional length bonus
    if (password.length >= 16) score++;
    
    if (score <= 2) return PasswordStrength.weak;
    if (score <= 4) return PasswordStrength.fair;
    if (score <= 6) return PasswordStrength.good;
    return PasswordStrength.strong;
  }

  @override
  Widget build(BuildContext context) {
    final strength = _calculateStrength(password);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Password strength bar
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Row(
            children: [
              Expanded(
                flex: _getStrengthValue(strength),
                child: Container(
                  decoration: BoxDecoration(
                    color: _getStrengthColor(strength),
                    borderRadius: BorderRadius.circular(height / 2),
                  ),
                ),
              ),
              Expanded(
                flex: 4 - _getStrengthValue(strength),
                child: Container(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Strength text
        Text(
          _getStrengthText(strength),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _getStrengthColor(strength),
          ),
        ),
        // Requirements checklist
        if (password.isNotEmpty) ...[
          const SizedBox(height: 8),
          _buildRequirementsList(password),
        ],
      ],
    );
  }

  Widget _buildRequirementsList(String password) {
    final requirements = [
      {
        'text': 'At least 8 characters',
        'met': password.length >= 8,
      },
      {
        'text': 'Contains uppercase letter',
        'met': password.contains(RegExp(r'[A-Z]')),
      },
      {
        'text': 'Contains lowercase letter',
        'met': password.contains(RegExp(r'[a-z]')),
      },
      {
        'text': 'Contains number',
        'met': password.contains(RegExp(r'[0-9]')),
      },
      {
        'text': 'Contains special character',
        'met': password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: requirements.map((req) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Icon(
              req['met'] as bool ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 16,
              color: req['met'] as bool 
                ? Colors.green 
                : Colors.grey[400],
            ),
            const SizedBox(width: 8),
            Text(
              req['text'] as String,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: req['met'] as bool 
                  ? Colors.green 
                  : Colors.grey[600],
                fontWeight: req['met'] as bool 
                  ? FontWeight.w500 
                  : FontWeight.w400,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  int _getStrengthValue(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.none:
        return 0;
      case PasswordStrength.weak:
        return 1;
      case PasswordStrength.fair:
        return 2;
      case PasswordStrength.good:
        return 3;
      case PasswordStrength.strong:
        return 4;
    }
  }

  Color _getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.none:
        return Colors.grey[400]!;
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.fair:
        return Colors.orange;
      case PasswordStrength.good:
        return Colors.blue;
      case PasswordStrength.strong:
        return Colors.green;
    }
  }

  String _getStrengthText(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.none:
        return 'Enter a password';
      case PasswordStrength.weak:
        return 'Weak password';
      case PasswordStrength.fair:
        return 'Fair password';
      case PasswordStrength.good:
        return 'Good password';
      case PasswordStrength.strong:
        return 'Strong password';
    }
  }
}

enum PasswordStrength {
  none,
  weak,
  fair,
  good,
  strong,
}
