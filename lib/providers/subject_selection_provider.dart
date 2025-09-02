import 'package:flutter/material.dart';

class Subject {
  final String name;
  final List<String> keywords;
  final double matchScore;

  Subject({
    required this.name,
    required this.keywords,
    this.matchScore = 0.0,
  });
}

class Interest {
  final String category;
  final List<String> topics;

  Interest({
    required this.category,
    required this.topics,
  });
}

class SubjectSelectionProvider extends ChangeNotifier {
  int _currentStep = 1;
  final List<String> _selectedLanguages = [];
  String _mathChoice = '';
  int _numberOfElectives = 2;
  final List<String> _selectedInterests = [];
  String _learningStyle = '';
  final TextEditingController _careerInterestsController =
      TextEditingController();

  // Getters
  int get currentStep => _currentStep;
  List<String> get selectedLanguages => _selectedLanguages;
  String get mathChoice => _mathChoice;
  int get numberOfElectives => _numberOfElectives;
  List<String> get selectedInterests => _selectedInterests;
  String get learningStyle => _learningStyle;
  TextEditingController get careerInterestsController =>
      _careerInterestsController;

  // Compulsory subjects
  List<String> get compulsorySubjects => [
        'English Home Language',
        'Afrikaans First Additional Language',
        'Life Orientation',
        'Life Sciences',
        'Physical Sciences',
      ];

  // Interest categories
  List<Interest> get interests => [
        Interest(
          category: 'Science & Technology',
          topics: [
            'Biology',
            'Chemistry',
            'Physics',
            'Computer Science',
            'Engineering',
            'Medicine',
            'Research',
            'Technology',
            'Mathematics',
            'Astronomy',
            'Environmental Science'
          ],
        ),
        Interest(
          category: 'Business & Economics',
          topics: [
            'Business Management',
            'Economics',
            'Accounting',
            'Finance',
            'Marketing',
            'Entrepreneurship',
            'Management',
            'Commerce',
            'Investment'
          ],
        ),
        Interest(
          category: 'Arts & Humanities',
          topics: [
            'Literature',
            'History',
            'Geography',
            'Languages',
            'Philosophy',
            'Psychology',
            'Sociology',
            'Politics',
            'Religion',
            'Cultural Studies',
            'Creative Writing'
          ],
        ),
        Interest(
          category: 'Creative Arts',
          topics: [
            'Visual Arts',
            'Music',
            'Drama',
            'Dance',
            'Design',
            'Photography',
            'Film',
            'Architecture',
            'Fashion',
            'Interior Design',
            'Graphic Design'
          ],
        ),
        Interest(
          category: 'Health & Wellness',
          topics: [
            'Physical Education',
            'Nutrition',
            'Sports Science',
            'Physiotherapy',
            'Occupational Therapy',
            'Nursing',
            'Public Health',
            'Mental Health',
            'Wellness'
          ],
        ),
        Interest(
          category: 'Agriculture & Environment',
          topics: [
            'Agriculture',
            'Horticulture',
            'Environmental Studies',
            'Conservation',
            'Animal Science',
            'Forestry',
            'Marine Biology',
            'Sustainability',
            'Climate Science'
          ],
        ),
      ];

  // Available elective subjects
  List<Subject> get availableSubjects => [
        Subject(name: 'Accounting', keywords: [
          'business',
          'finance',
          'accounting',
          'economics',
          'management'
        ]),
        Subject(name: 'Agricultural Sciences', keywords: [
          'agriculture',
          'farming',
          'environment',
          'biology',
          'science'
        ]),
        Subject(name: 'Business Studies', keywords: [
          'business',
          'management',
          'entrepreneurship',
          'commerce',
          'economics'
        ]),
        Subject(name: 'Consumer Studies', keywords: [
          'consumer',
          'lifestyle',
          'nutrition',
          'health',
          'wellness'
        ]),
        Subject(name: 'Dramatic Arts', keywords: [
          'drama',
          'theatre',
          'performing arts',
          'creative',
          'entertainment'
        ]),
        Subject(name: 'Economics', keywords: [
          'economics',
          'finance',
          'business',
          'politics',
          'social studies'
        ]),
        Subject(name: 'Engineering Graphics and Design', keywords: [
          'engineering',
          'design',
          'technology',
          'architecture',
          'technical'
        ]),
        Subject(
            name: 'English First Additional Language',
            keywords: ['english', 'language', 'literature', 'communication']),
        Subject(name: 'Geography', keywords: [
          'geography',
          'environment',
          'earth sciences',
          'social studies',
          'climate'
        ]),
        Subject(name: 'History', keywords: [
          'history',
          'social studies',
          'politics',
          'culture',
          'humanities'
        ]),
        Subject(name: 'Hospitality Studies', keywords: [
          'hospitality',
          'tourism',
          'service',
          'business',
          'lifestyle'
        ]),
        Subject(name: 'Information Technology', keywords: [
          'technology',
          'computers',
          'programming',
          'digital',
          'innovation'
        ]),
        Subject(name: 'Life Sciences', keywords: [
          'biology',
          'life sciences',
          'medicine',
          'health',
          'science'
        ]),
        Subject(name: 'Mathematical Literacy', keywords: [
          'mathematics',
          'numeracy',
          'practical math',
          'everyday math'
        ]),
        Subject(name: 'Mathematics', keywords: [
          'mathematics',
          'advanced math',
          'calculus',
          'algebra',
          'science'
        ]),
        Subject(name: 'Music', keywords: [
          'music',
          'arts',
          'creative',
          'performing arts',
          'culture'
        ]),
        Subject(name: 'Physical Sciences', keywords: [
          'physics',
          'chemistry',
          'science',
          'engineering',
          'technology'
        ]),
        Subject(name: 'Tourism', keywords: [
          'tourism',
          'travel',
          'hospitality',
          'business',
          'service'
        ]),
        Subject(
            name: 'Visual Arts',
            keywords: ['art', 'creative', 'design', 'visual', 'culture']),
      ];

  // Methods
  void nextStep() {
    if (_currentStep < 4) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 1) {
      _currentStep--;
      notifyListeners();
    }
  }

  void addLanguage(String language) {
    if (!_selectedLanguages.contains(language)) {
      _selectedLanguages.add(language);
      notifyListeners();
    }
  }

  void removeLanguage(String language) {
    _selectedLanguages.remove(language);
    notifyListeners();
  }

  void setMathChoice(String choice) {
    _mathChoice = choice;
    notifyListeners();
  }

  void setNumberOfElectives(int number) {
    _numberOfElectives = number;
    notifyListeners();
  }

  void addInterest(String interest) {
    if (!_selectedInterests.contains(interest)) {
      _selectedInterests.add(interest);
      notifyListeners();
    }
  }

  void removeInterest(String interest) {
    _selectedInterests.remove(interest);
    notifyListeners();
  }

  void setLearningStyle(String style) {
    _learningStyle = style;
    notifyListeners();
  }

  void reset() {
    _currentStep = 1;
    _selectedLanguages.clear();
    _mathChoice = '';
    _numberOfElectives = 2;
    _selectedInterests.clear();
    _learningStyle = '';
    _careerInterestsController.clear();
    notifyListeners();
  }

  List<Subject> getRecommendedSubjects() {
    List<Subject> recommendations = [];

    for (Subject subject in availableSubjects) {
      double matchScore = 0.0;
      int totalKeywords = subject.keywords.length;

      // Calculate match score based on selected interests
      for (String interest in _selectedInterests) {
        for (String keyword in subject.keywords) {
          if (interest.toLowerCase().contains(keyword.toLowerCase()) ||
              keyword.toLowerCase().contains(interest.toLowerCase())) {
            matchScore += 1.0;
          }
        }
      }

      // Normalize score to percentage
      if (totalKeywords > 0) {
        matchScore = (matchScore / totalKeywords) * 100;
      }

      // Add bonus for learning style compatibility
      if (_learningStyle.isNotEmpty) {
        if (_learningStyle == 'Visual' &&
            ['Visual Arts', 'Engineering Graphics and Design', 'Geography']
                .contains(subject.name)) {
          matchScore += 10;
        } else if (_learningStyle == 'Auditory' &&
            ['Music', 'Dramatic Arts', 'English First Additional Language']
                .contains(subject.name)) {
          matchScore += 10;
        } else if (_learningStyle == 'Kinesthetic' &&
            [
              'Physical Sciences',
              'Agricultural Sciences',
              'Engineering Graphics and Design'
            ].contains(subject.name)) {
          matchScore += 10;
        } else if (_learningStyle == 'Reading/Writing' &&
            ['History', 'Geography', 'English First Additional Language']
                .contains(subject.name)) {
          matchScore += 10;
        }
      }

      // Add bonus for mathematics choice compatibility
      if (_mathChoice == 'Mathematics' && subject.name == 'Mathematics') {
        matchScore += 20;
      } else if (_mathChoice == 'Mathematical Literacy' &&
          subject.name == 'Mathematical Literacy') {
        matchScore += 20;
      }

      // Cap the score at 100%
      matchScore = matchScore.clamp(0.0, 100.0);

      recommendations.add(Subject(
        name: subject.name,
        keywords: subject.keywords,
        matchScore: matchScore,
      ));
    }

    // Sort by match score (highest first)
    recommendations.sort((a, b) => b.matchScore.compareTo(a.matchScore));

    return recommendations;
  }

  @override
  void dispose() {
    _careerInterestsController.dispose();
    super.dispose();
  }
}
