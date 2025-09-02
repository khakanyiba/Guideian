import 'package:flutter/material.dart';

class SubjectSelectionProvider extends ChangeNotifier {
  int _currentStep = 0;
  final Map<String, dynamic> _userData = {};
  List<String> _recommendedSubjects = [];
  bool _isLoading = false;

  int get currentStep => _currentStep;
  Map<String, dynamic> get userData => _userData;
  List<String> get recommendedSubjects => _recommendedSubjects;
  bool get isLoading => _isLoading;

  // Compulsory subjects for Grade 10
  final List<String> compulsorySubjects = [
    'English Home Language',
    'Afrikaans First Additional Language',
    'Mathematics',
    'Life Orientation',
    'Physical Sciences',
    'Life Sciences',
  ];

  // Elective subjects mapped by interest keywords
  final Map<String, List<String>> electiveSubjectsByInterest = {
    'technology': [
      'Information Technology',
      'Computer Applications Technology'
    ],
    'business': ['Accounting', 'Business Studies', 'Economics'],
    'arts': ['Visual Arts', 'Dramatic Arts', 'Music'],
    'languages': ['French', 'German', 'Spanish', 'Portuguese'],
    'sciences': ['Agricultural Sciences', 'Engineering Graphics and Design'],
    'humanities': ['Geography', 'History', 'Tourism'],
    'sports': ['Physical Education Studies'],
  };

  void updateUserData(String key, dynamic value) {
    _userData[key] = value;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void reset() {
    _currentStep = 0;
    _userData.clear();
    _recommendedSubjects.clear();
    notifyListeners();
  }

  Future<void> generateRecommendations() async {
    _isLoading = true;
    notifyListeners();

    // Simulate processing time
    await Future.delayed(const Duration(seconds: 2));

    List<String> recommendations = [];
    recommendations.addAll(compulsorySubjects);

    // Add elective subjects based on interests
    List<String> interests = _userData['interests'] ?? [];
    int numElectives = _userData['numElectives'] ?? 2;

    for (String interest in interests) {
      for (String keyword in electiveSubjectsByInterest.keys) {
        if (interest.toLowerCase().contains(keyword) &&
            recommendations.length < compulsorySubjects.length + numElectives) {
          recommendations.addAll(electiveSubjectsByInterest[keyword]!);
        }
      }
    }

    // Ensure we don't exceed the required number of subjects
    if (recommendations.length > compulsorySubjects.length + numElectives) {
      recommendations = recommendations
          .take(compulsorySubjects.length + numElectives)
          .toList();
    }

    _recommendedSubjects = recommendations;
    _isLoading = false;
    notifyListeners();
  }

  String getRecommendationSummary() {
    if (_recommendedSubjects.isEmpty) return '';

    String summary =
        'Based on your interests and preferences, we recommend the following subject package:\n\n';
    summary += 'Compulsory Subjects:\n';

    for (String subject in compulsorySubjects) {
      summary += '• $subject\n';
    }

    summary += '\nElective Subjects:\n';
    List<String> electives = _recommendedSubjects
        .where((subject) => !compulsorySubjects.contains(subject))
        .toList();

    for (String subject in electives) {
      summary += '• $subject\n';
    }

    return summary;
  }
}
