import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/subject_selection_provider.dart';
import '../widgets/navbar.dart';

class SubjectSelectionScreen extends StatelessWidget {
  const SubjectSelectionScreen({super.key});

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
            child: Consumer<SubjectSelectionProvider>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Text(
                        'Assisted Subject Selection',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D0D0D),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildStepIndicator(provider.currentStep),
                      const SizedBox(height: 32),
                      _buildStepContent(context, provider),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int currentStep) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 4; i++) ...[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: i <= currentStep ? const Color(0xFF3328BF) : Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (i < 3)
            Container(
              width: 60,
              height: 2,
              color: i < currentStep ? const Color(0xFF3328BF) : Colors.grey,
            ),
        ],
      ],
    );
  }

  Widget _buildStepContent(
      BuildContext context, SubjectSelectionProvider provider) {
    switch (provider.currentStep) {
      case 0:
        return _buildStep1(context, provider);
      case 1:
        return _buildStep2(context, provider);
      case 2:
        return _buildStep3(context, provider);
      case 3:
        return _buildStep4(context, provider);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1(BuildContext context, SubjectSelectionProvider provider) {
    final interests = [
      'Technology',
      'Business',
      'Arts',
      'Languages',
      'Sciences',
      'Humanities',
      'Sports',
    ];

    return Column(
      children: [
        const Text(
          'What are your interests?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Select all that apply to help us recommend the best subjects for you.',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF808080),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: interests.map((interest) {
            final selectedInterests =
                provider.userData['interests'] ?? <String>[];
            final isSelected = selectedInterests.contains(interest);

            return FilterChip(
              label: Text(interest),
              selected: isSelected,
              onSelected: (selected) {
                final currentInterests = List<String>.from(selectedInterests);
                if (selected) {
                  currentInterests.add(interest);
                } else {
                  currentInterests.remove(interest);
                }
                provider.updateUserData('interests', currentInterests);
              },
              selectedColor: const Color(0xFF3328BF).withOpacity(0.2),
              checkmarkColor: const Color(0xFF3328BF),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            ElevatedButton(
              onPressed: (provider.userData['interests'] ?? []).isNotEmpty
                  ? () => provider.nextStep()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3328BF),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2(BuildContext context, SubjectSelectionProvider provider) {
    return Column(
      children: [
        const Text(
          'Language Preferences',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'What additional languages would you like to study?',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF808080),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        DropdownButtonFormField<String>(
          initialValue: provider.userData['additionalLanguage'],
          decoration: const InputDecoration(
            labelText: 'Additional Language',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'French', child: Text('French')),
            DropdownMenuItem(value: 'German', child: Text('German')),
            DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
            DropdownMenuItem(value: 'Portuguese', child: Text('Portuguese')),
            DropdownMenuItem(value: 'None', child: Text('None')),
          ],
          onChanged: (value) {
            provider.updateUserData('additionalLanguage', value);
          },
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => provider.previousStep(),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () => provider.nextStep(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3328BF),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3(BuildContext context, SubjectSelectionProvider provider) {
    return Column(
      children: [
        const Text(
          'Number of Elective Subjects',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'How many elective subjects would you like to take?',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF808080),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        DropdownButtonFormField<int>(
          initialValue: provider.userData['numElectives'] ?? 2,
          decoration: const InputDecoration(
            labelText: 'Number of Electives',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 1, child: Text('1')),
            DropdownMenuItem(value: 2, child: Text('2')),
            DropdownMenuItem(value: 3, child: Text('3')),
          ],
          onChanged: (value) {
            provider.updateUserData('numElectives', value);
          },
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => provider.previousStep(),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () => provider.nextStep(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3328BF),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Generate Recommendations'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep4(BuildContext context, SubjectSelectionProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              color: Color(0xFF3328BF),
            ),
            SizedBox(height: 16),
            Text(
              'Generating your personalized recommendations...',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF808080),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        const Text(
          'Your Recommended Subject Package',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9FB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Compulsory Subjects:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D0D0D),
                ),
              ),
              const SizedBox(height: 12),
              ...provider.compulsorySubjects.map((subject) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF3328BF),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          subject,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0D0D0D),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              const Text(
                'Elective Subjects:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D0D0D),
                ),
              ),
              const SizedBox(height: 12),
              ...provider.recommendedSubjects
                  .where((subject) =>
                      !provider.compulsorySubjects.contains(subject))
                  .map((subject) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFF3328BF),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              subject,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0D0D0D),
                              ),
                            ),
                          ],
                        ),
                      )),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => provider.previousStep(),
              child: const Text('Back'),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => provider.reset(),
                  child: const Text('Start Over'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3328BF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}



