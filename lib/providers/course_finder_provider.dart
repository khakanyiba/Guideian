import 'package:flutter/material.dart';

class Course {
  final String name;
  final String institution;
  final String location;
  final double minMarks;
  final String affordability;
  final String demand;
  final List<String> interests;
  final double matchScore;

  Course({
    required this.name,
    required this.institution,
    required this.location,
    required this.minMarks,
    required this.affordability,
    required this.demand,
    required this.interests,
    this.matchScore = 0.0,
  });
}

class CourseFinderProvider extends ChangeNotifier {
  // Search and Filter State
  String _searchQuery = '';
  String _selectedLocation = '';
  String _selectedAffordability = '';
  String _selectedDemand = '';
  bool _isLoading = false;

  // User Preferences
  double _averageMarks = 0.0;
  final List<String> _selectedInterests = [];
  String _preferredLocation = '';
  String _preferredAffordability = '';

  // Available Data
  List<Course> _allCourses = [];
  List<Course> _filteredCourses = [];

  // Getters
  String get searchQuery => _searchQuery;
  String get selectedLocation => _selectedLocation;
  String get selectedAffordability => _selectedAffordability;
  String get selectedDemand => _selectedDemand;
  bool get isLoading => _isLoading;
  double get averageMarks => _averageMarks;
  List<String> get selectedInterests => _selectedInterests;
  String get preferredLocation => _preferredLocation;
  String get preferredAffordability => _preferredAffordability;
  List<Course> get courses => _filteredCourses;

  List<String> get availableLocations => [
        'Johannesburg',
        'Cape Town',
        'Durban',
        'Pretoria',
        'Port Elizabeth',
        'Bloemfontein',
        'East London',
        'Kimberley',
        'Polokwane',
        'Nelspruit',
        'Online',
        'International'
      ];

  CourseFinderProvider() {
    _initializeCourses();
  }

  void _initializeCourses() {
    _allCourses = [
      Course(
        name: 'Bachelor of Computer Science',
        institution: 'University of Cape Town',
        location: 'Cape Town',
        minMarks: 75.0,
        affordability: 'High',
        demand: 'High',
        interests: [
          'Technology',
          'Programming',
          'Software Development',
          'Computer Science'
        ],
      ),
      Course(
        name: 'Bachelor of Medicine and Surgery',
        institution: 'University of the Witwatersrand',
        location: 'Johannesburg',
        minMarks: 85.0,
        affordability: 'High',
        demand: 'High',
        interests: ['Medicine', 'Healthcare', 'Biology', 'Science'],
      ),
      Course(
        name: 'Bachelor of Commerce',
        institution: 'University of Stellenbosch',
        location: 'Stellenbosch',
        minMarks: 70.0,
        affordability: 'Medium',
        demand: 'High',
        interests: ['Business', 'Finance', 'Economics', 'Management'],
      ),
      Course(
        name: 'Bachelor of Engineering (Civil)',
        institution: 'University of Pretoria',
        location: 'Pretoria',
        minMarks: 80.0,
        affordability: 'High',
        demand: 'High',
        interests: ['Engineering', 'Construction', 'Infrastructure', 'Design'],
      ),
      Course(
        name: 'Bachelor of Arts in Psychology',
        institution: 'University of KwaZulu-Natal',
        location: 'Durban',
        minMarks: 65.0,
        affordability: 'Medium',
        demand: 'Medium',
        interests: [
          'Psychology',
          'Human Behavior',
          'Mental Health',
          'Social Sciences'
        ],
      ),
      Course(
        name: 'Bachelor of Science in Agriculture',
        institution: 'University of Free State',
        location: 'Bloemfontein',
        minMarks: 60.0,
        affordability: 'Low',
        demand: 'Medium',
        interests: [
          'Agriculture',
          'Farming',
          'Environmental Science',
          'Biology'
        ],
      ),
      Course(
        name: 'Bachelor of Laws',
        institution: 'University of Johannesburg',
        location: 'Johannesburg',
        minMarks: 75.0,
        affordability: 'High',
        demand: 'High',
        interests: ['Law', 'Legal Studies', 'Justice', 'Human Rights'],
      ),
      Course(
        name: 'Bachelor of Education',
        institution: 'University of South Africa',
        location: 'Online',
        minMarks: 60.0,
        affordability: 'Low',
        demand: 'Medium',
        interests: ['Education', 'Teaching', 'Learning', 'Child Development'],
      ),
      Course(
        name: 'Bachelor of Fine Arts',
        institution: 'Rhodes University',
        location: 'Grahamstown',
        minMarks: 55.0,
        affordability: 'Medium',
        demand: 'Low',
        interests: ['Arts', 'Creative Design', 'Visual Arts', 'Culture'],
      ),
      Course(
        name: 'Bachelor of Science in Environmental Science',
        institution: 'Nelson Mandela University',
        location: 'Port Elizabeth',
        minMarks: 65.0,
        affordability: 'Medium',
        demand: 'Medium',
        interests: [
          'Environment',
          'Conservation',
          'Climate Science',
          'Sustainability'
        ],
      ),
      Course(
        name: 'Bachelor of Business Administration',
        institution: 'University of the Western Cape',
        location: 'Cape Town',
        minMarks: 65.0,
        affordability: 'Low',
        demand: 'High',
        interests: ['Business', 'Management', 'Administration', 'Leadership'],
      ),
      Course(
        name: 'Bachelor of Science in Mathematics',
        institution: 'University of Limpopo',
        location: 'Polokwane',
        minMarks: 70.0,
        affordability: 'Low',
        demand: 'Medium',
        interests: [
          'Mathematics',
          'Statistics',
          'Analytics',
          'Problem Solving'
        ],
      ),
      Course(
        name: 'Bachelor of Architecture',
        institution: 'University of Cape Town',
        location: 'Cape Town',
        minMarks: 80.0,
        affordability: 'High',
        demand: 'Medium',
        interests: ['Architecture', 'Design', 'Construction', 'Urban Planning'],
      ),
      Course(
        name: 'Bachelor of Science in Nursing',
        institution: 'University of KwaZulu-Natal',
        location: 'Durban',
        minMarks: 70.0,
        affordability: 'Medium',
        demand: 'High',
        interests: ['Nursing', 'Healthcare', 'Patient Care', 'Medical Science'],
      ),
      Course(
        name: 'Bachelor of Commerce in Marketing',
        institution: 'University of Johannesburg',
        location: 'Johannesburg',
        minMarks: 65.0,
        affordability: 'Medium',
        demand: 'High',
        interests: [
          'Marketing',
          'Advertising',
          'Consumer Behavior',
          'Business'
        ],
      ),
    ];

    _filteredCourses = List.from(_allCourses);
  }

  // Search Methods
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void clearSearch() {
    _searchQuery = '';
    _applyFilters();
  }

  // Filter Methods
  void setLocationFilter(String location) {
    _selectedLocation = location;
  }

  void setAffordabilityFilter(String affordability) {
    _selectedAffordability = affordability;
  }

  void setDemandFilter(String demand) {
    _selectedDemand = demand;
  }

  void clearFilters() {
    _selectedLocation = '';
    _selectedAffordability = '';
    _selectedDemand = '';
    _applyFilters();
  }

  void applyFilters() {
    _applyFilters();
  }

  void _applyFilters() {
    _filteredCourses = _allCourses.where((course) {
      // Search query filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesSearch = course.name.toLowerCase().contains(query) ||
            course.institution.toLowerCase().contains(query) ||
            course.interests
                .any((interest) => interest.toLowerCase().contains(query));
        if (!matchesSearch) return false;
      }

      // Location filter
      if (_selectedLocation.isNotEmpty &&
          course.location != _selectedLocation) {
        return false;
      }

      // Affordability filter
      if (_selectedAffordability.isNotEmpty &&
          course.affordability != _selectedAffordability) {
        return false;
      }

      // Demand filter
      if (_selectedDemand.isNotEmpty && course.demand != _selectedDemand) {
        return false;
      }

      return true;
    }).toList();

    notifyListeners();
  }

  // Preference Methods
  void setAverageMarks(double marks) {
    _averageMarks = marks;
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

  void setPreferredLocation(String location) {
    _preferredLocation = location;
  }

  void setPreferredAffordability(String affordability) {
    _preferredAffordability = affordability;
  }

  // Course Finding Methods
  void findCourses() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Calculate match scores for all courses
    List<Course> scoredCourses = _allCourses.map((course) {
      double matchScore = _calculateMatchScore(course);
      return Course(
        name: course.name,
        institution: course.institution,
        location: course.location,
        minMarks: course.minMarks,
        affordability: course.affordability,
        demand: course.demand,
        interests: course.interests,
        matchScore: matchScore,
      );
    }).toList();

    // Filter by minimum marks
    scoredCourses = scoredCourses
        .where((course) => course.minMarks <= _averageMarks)
        .toList();

    // Sort by match score (highest first)
    scoredCourses.sort((a, b) => b.matchScore.compareTo(a.matchScore));

    // Take top 10 results
    _filteredCourses = scoredCourses.take(10).toList();

    _isLoading = false;
    notifyListeners();
  }

  double _calculateMatchScore(Course course) {
    double score = 0.0;

    // Interest matching (40% weight)
    int matchingInterests = 0;
    for (String userInterest in _selectedInterests) {
      for (String courseInterest in course.interests) {
        if (userInterest.toLowerCase() == courseInterest.toLowerCase()) {
          matchingInterests++;
          break;
        }
      }
    }
    score += (matchingInterests / _selectedInterests.length) * 40;

    // Location preference (20% weight)
    if (_preferredLocation.isNotEmpty) {
      if (course.location.toLowerCase() == _preferredLocation.toLowerCase()) {
        score += 20;
      } else if (course.location == 'Online') {
        score += 10; // Online courses get partial credit
      }
    }

    // Affordability preference (20% weight)
    if (_preferredAffordability.isNotEmpty) {
      if (course.affordability == _preferredAffordability) {
        score += 20;
      }
    }

    // Demand bonus (10% weight)
    if (course.demand == 'High') {
      score += 10;
    } else if (course.demand == 'Medium') {
      score += 5;
    }

    // Marks compatibility (10% weight)
    if (_averageMarks >= course.minMarks + 10) {
      score += 10; // Well above minimum
    } else if (_averageMarks >= course.minMarks) {
      score += 5; // Meets minimum
    }

    return score.clamp(0.0, 100.0);
  }

  // Reset method
  void reset() {
    _searchQuery = '';
    _selectedLocation = '';
    _selectedAffordability = '';
    _selectedDemand = '';
    _averageMarks = 0.0;
    _selectedInterests.clear();
    _preferredLocation = '';
    _preferredAffordability = '';
    _filteredCourses = List.from(_allCourses);
    notifyListeners();
  }
}
