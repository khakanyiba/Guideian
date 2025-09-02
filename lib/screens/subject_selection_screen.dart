import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_selection_provider.dart';
import '../utils/app_theme.dart';

class SubjectSelectionScreen extends StatefulWidget {
  const SubjectSelectionScreen({super.key});

  @override
  State<SubjectSelectionScreen> createState() => _SubjectSelectionScreenState();
}

class _SubjectSelectionScreenState extends State<SubjectSelectionScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Selection Assistant'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<SubjectSelectionProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Progress Indicator
              Container(
                padding: const EdgeInsets.all(16),
                color: AppTheme.primaryColor.withOpacity(0.1),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Step ${provider.currentStep} of 4',
                          style: AppTheme.textTheme.titleMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${((provider.currentStep / 4) * 100).round()}% Complete',
                          style: AppTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: provider.currentStep / 4,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                    ),
                  ],
                ),
              ),

              // Step Indicators
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: List.generate(4, (index) {
                    final step = index + 1;
                    final isActive = provider.currentStep == step;
                    final isCompleted = provider.currentStep > step;

                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted
                                    ? AppTheme.primaryColor
                                    : isActive
                                        ? AppTheme.primaryColor
                                        : Colors.grey[300],
                              ),
                              child: Center(
                                child: isCompleted
                                    ? const Icon(Icons.check,
                                        color: Colors.white, size: 16)
                                    : Text(
                                        step.toString(),
                                        style: TextStyle(
                                          color: isActive
                                              ? Colors.white
                                              : Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            if (index < 3)
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: isCompleted
                                      ? AppTheme.primaryColor
                                      : Colors.grey[300],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Main Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildAcademicInfoStep(provider),
                    _buildInterestsStep(provider),
                    _buildPreferencesStep(provider),
                    _buildResultsStep(provider),
                  ],
                ),
              ),

              // Navigation Buttons
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (provider.currentStep > 1)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _previousStep(provider),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: AppTheme.primaryColor),
                          ),
                          child: const Text('Previous'),
                        ),
                      ),
                    if (provider.currentStep > 1 && provider.currentStep < 4)
                      const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _nextStep(provider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          provider.currentStep == 4 ? 'Start Over' : 'Next',
                        ),
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

  Widget _buildAcademicInfoStep(SubjectSelectionProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Academic Information',
              style: AppTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Let\'s start by understanding your academic background and preferences.',
              style: AppTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            // Languages Section
            Text(
              'Languages',
              style: AppTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select the languages you are currently studying or plan to study:',
              style: AppTheme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'English Home Language',
                'English First Additional Language',
                'Afrikaans Home Language',
                'Afrikaans First Additional Language',
                'IsiZulu Home Language',
                'IsiZulu First Additional Language',
                'IsiXhosa Home Language',
                'IsiXhosa First Additional Language',
                'Sepedi Home Language',
                'Sepedi First Additional Language',
                'Setswana Home Language',
                'Setswana First Additional Language',
                'Sesotho Home Language',
                'Sesotho First Additional Language',
                'Xitsonga Home Language',
                'Xitsonga First Additional Language',
                'Tshivenda Home Language',
                'Tshivenda First Additional Language',
                'SiSwati Home Language',
                'SiSwati First Additional Language',
                'IsiNdebele Home Language',
                'IsiNdebele First Additional Language',
              ].map((language) {
                final isSelected =
                    provider.selectedLanguages.contains(language);
                return FilterChip(
                  label: Text(language),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      provider.addLanguage(language);
                    } else {
                      provider.removeLanguage(language);
                    }
                  },
                  selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                  checkmarkColor: AppTheme.primaryColor,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Mathematics Choice
            Text(
              'Mathematics',
              style: AppTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select your mathematics preference:',
              style: AppTheme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            ...['Mathematics', 'Mathematical Literacy'].map((math) {
              return RadioListTile<String>(
                title: Text(math),
                value: math,
                groupValue: provider.mathChoice,
                onChanged: (value) {
                  if (value != null) {
                    provider.setMathChoice(value);
                  }
                },
                activeColor: AppTheme.primaryColor,
              );
            }),
            const SizedBox(height: 24),

            // Number of Electives
            Text(
              'Number of Electives',
              style: AppTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'How many elective subjects would you like to take?',
              style: AppTheme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: provider.numberOfElectives.toDouble(),
                    min: 1,
                    max: 4,
                    divisions: 3,
                    activeColor: AppTheme.primaryColor,
                    onChanged: (value) {
                      provider.setNumberOfElectives(value.toInt());
                    },
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      provider.numberOfElectives.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestsStep(SubjectSelectionProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Interests',
            style: AppTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select all the areas that interest you. This will help us recommend the best subjects for you.',
            style: AppTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          // Interest Categories
          ...provider.interests.map((interest) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                title: Text(
                  interest.category,
                  style: AppTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: interest.topics.map((topic) {
                        final isSelected =
                            provider.selectedInterests.contains(topic);
                        return FilterChip(
                          label: Text(topic),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              provider.addInterest(topic);
                            } else {
                              provider.removeInterest(topic);
                            }
                          },
                          selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                          checkmarkColor: AppTheme.primaryColor,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPreferencesStep(SubjectSelectionProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Preferences',
            style: AppTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tell us more about your preferences to fine-tune your recommendations.',
            style: AppTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          // Learning Style
          Text(
            'Learning Style',
            style: AppTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...['Visual', 'Auditory', 'Kinesthetic', 'Reading/Writing']
              .map((style) {
            return RadioListTile<String>(
              title: Text(style),
              value: style,
              groupValue: provider.learningStyle,
              onChanged: (value) {
                if (value != null) {
                  provider.setLearningStyle(value);
                }
              },
              activeColor: AppTheme.primaryColor,
            );
          }),
          const SizedBox(height: 24),

          // Future Career Interests
          Text(
            'Future Career Interests',
            style: AppTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'What career paths interest you? (Optional)',
            style: AppTheme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: provider.careerInterestsController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'e.g., Medicine, Engineering, Business, Arts...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Summary
          Card(
            color: AppTheme.primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary',
                    style: AppTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'Languages: ${provider.selectedLanguages.length} selected'),
                  Text('Mathematics: ${provider.mathChoice}'),
                  Text('Electives: ${provider.numberOfElectives} subjects'),
                  Text(
                      'Interests: ${provider.selectedInterests.length} selected'),
                  Text('Learning Style: ${provider.learningStyle}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsStep(SubjectSelectionProvider provider) {
    final recommendedSubjects = provider.getRecommendedSubjects();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Recommended Subjects',
            style: AppTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Based on your preferences, here are our recommendations:',
            style: AppTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          // Compulsory Subjects
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Compulsory Subjects',
                        style: AppTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...provider.compulsorySubjects.map((subject) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_right, color: AppTheme.primaryColor),
                          const SizedBox(width: 8),
                          Text(subject),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Recommended Electives
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Recommended Electives',
                        style: AppTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...recommendedSubjects
                      .take(provider.numberOfElectives)
                      .map((subject) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_right, color: AppTheme.primaryColor),
                          const SizedBox(width: 8),
                          Expanded(child: Text(subject.name)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${subject.matchScore.round()}%',
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement save functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Results saved!')),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save Results'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: AppTheme.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement print functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Printing results...')),
                    );
                  },
                  icon: const Icon(Icons.print),
                  label: const Text('Print'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _nextStep(SubjectSelectionProvider provider) {
    if (provider.currentStep == 4) {
      // Start over
      provider.reset();
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Validate current step
      if (_validateCurrentStep(provider)) {
        provider.nextStep();
        _pageController.animateToPage(
          provider.currentStep - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _previousStep(SubjectSelectionProvider provider) {
    if (provider.currentStep > 1) {
      provider.previousStep();
      _pageController.animateToPage(
        provider.currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep(SubjectSelectionProvider provider) {
    switch (provider.currentStep) {
      case 1:
        if (provider.selectedLanguages.isEmpty) {
          _showError('Please select at least one language.');
          return false;
        }
        if (provider.mathChoice.isEmpty) {
          _showError('Please select your mathematics preference.');
          return false;
        }
        break;
      case 2:
        if (provider.selectedInterests.isEmpty) {
          _showError('Please select at least one interest area.');
          return false;
        }
        break;
      case 3:
        if (provider.learningStyle.isEmpty) {
          _showError('Please select your learning style.');
          return false;
        }
        break;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
