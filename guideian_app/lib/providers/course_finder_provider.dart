import 'package:flutter/foundation.dart';

class CourseFinderProvider extends ChangeNotifier {
  String _selectedCourse = '';
  final List<String> _availableCourses = [
    'Computer Science',
    'Engineering',
    'Business Management',
    'Medicine',
    'Law',
    'Arts',
    'Science',
  ];

  String get selectedCourse => _selectedCourse;
  List<String> get availableCourses => _availableCourses;

  void setSelectedCourse(String course) {
    _selectedCourse = course;
    notifyListeners();
  }

  void searchCourses(String query) {
    // Implement course search logic here
    notifyListeners();
  }
}



