import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/labor_market_statistics.dart';
import '../models/student_profile.dart';

class LaborMarketService {
  static List<LaborMarketStatistics> _laborMarketData = [];
  static List<StudentProfile> _studentProfiles = [];
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Load labor market statistics
      final laborMarketJson = await rootBundle.loadString('assets/data/labor_market_statistics.json');
      final laborMarketData = json.decode(laborMarketJson) as List;
      _laborMarketData = laborMarketData.map((data) => LaborMarketStatistics.fromCsv(data)).toList();

      // Load student profiles
      final studentProfilesJson = await rootBundle.loadString('assets/data/student_profiles.json');
      final studentProfilesData = json.decode(studentProfilesJson) as List;
      _studentProfiles = studentProfilesData.map((data) => StudentProfile.fromCsv(data)).toList();

      _isInitialized = true;
    } catch (e) {
      print('Error loading labor market data: $e');
      _laborMarketData = [];
      _studentProfiles = [];
      _isInitialized = true;
    }
  }

  // Get unemployment rates by province
  static List<LaborMarketStatistics> getUnemploymentByProvince() {
    return _laborMarketData.where((data) => 
      data.table == 'Table E' && 
      data.category == 'Unemployment rate by province'
    ).toList();
  }

  // Get national unemployment trends
  static List<LaborMarketStatistics> getNationalUnemploymentTrends() {
    return _laborMarketData.where((data) => 
      data.table == 'Table A' && 
      data.category == 'Rates' && 
      data.subcategory == 'Unemployment rate'
    ).toList();
  }

  // Get employment by industry
  static List<LaborMarketStatistics> getEmploymentByIndustry() {
    return _laborMarketData.where((data) => 
      data.table.contains('Employment by industry')
    ).toList();
  }

  // Get latest unemployment rate
  static double? getLatestUnemploymentRate() {
    final latestData = _laborMarketData.where((data) => 
      data.unemploymentRate != null
    ).toList();
    
    if (latestData.isEmpty) return null;
    
    latestData.sort((a, b) => b.quarter.compareTo(a.quarter));
    return latestData.first.unemploymentRate;
  }

  // Get unemployment rate by province
  static Map<String, double> getUnemploymentByProvinceMap() {
    final provinceData = getUnemploymentByProvince();
    final Map<String, double> provinceRates = {};
    
    for (final data in provinceData) {
      if (data.subcategory != 'South Africa' && data.unemploymentRate != null) {
        provinceRates[data.subcategory] = data.unemploymentRate!;
      }
    }
    
    return provinceRates;
  }

  // Get student profile insights
  static Map<String, dynamic> getStudentInsights() {
    if (_studentProfiles.isEmpty) return {};

    final totalStudents = _studentProfiles.length;
    final avgMath = _studentProfiles.map((s) => s.mathMarks).reduce((a, b) => a + b) / totalStudents;
    final avgEnglish = _studentProfiles.map((s) => s.englishMarks).reduce((a, b) => a + b) / totalStudents;
    final avgScience = _studentProfiles.map((s) => s.scienceMarks).reduce((a, b) => a + b) / totalStudents;

    // Count interests
    final interestCounts = <String, int>{};
    for (final student in _studentProfiles) {
      interestCounts[student.interest] = (interestCounts[student.interest] ?? 0) + 1;
    }

    // Count career goals
    final careerGoalCounts = <String, int>{};
    for (final student in _studentProfiles) {
      careerGoalCounts[student.careerGoal] = (careerGoalCounts[student.careerGoal] ?? 0) + 1;
    }

    // Count learning styles
    final learningStyleCounts = <String, int>{};
    for (final student in _studentProfiles) {
      learningStyleCounts[student.learningStyle] = (learningStyleCounts[student.learningStyle] ?? 0) + 1;
    }

    return {
      'totalStudents': totalStudents,
      'averageMarks': {
        'math': avgMath,
        'english': avgEnglish,
        'science': avgScience,
        'overall': (avgMath + avgEnglish + avgScience) / 3,
      },
      'topInterests': _getTopItems(interestCounts, 5),
      'topCareerGoals': _getTopItems(careerGoalCounts, 3),
      'topLearningStyles': _getTopItems(learningStyleCounts, 3),
    };
  }

  static List<Map<String, dynamic>> _getTopItems(Map<String, int> counts, int limit) {
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sorted.take(limit).map((entry) => {
      'name': entry.key,
      'count': entry.value,
      'percentage': (entry.value / _studentProfiles.length * 100).toStringAsFixed(1),
    }).toList();
  }

  // Get recommended careers for a student profile
  static List<String> getRecommendedCareers(StudentProfile profile) {
    return profile.recommendedCareers;
  }

  // Get education pathways for a student profile
  static Map<String, dynamic> getEducationPathways(StudentProfile profile) {
    return {
      'recommendedPath': profile.recommendedEducationPath,
      'budgetOptions': profile.budgetAppropriateOptions,
      'locationInstitutions': profile.locationAppropriateInstitutions,
      'academicLevel': profile.academicLevel,
      'strongestSubject': profile.strongestSubject,
    };
  }

  // Get labor market trends
  static Map<String, dynamic> getLaborMarketTrends() {
    final unemploymentTrends = getNationalUnemploymentTrends();
    
    if (unemploymentTrends.isEmpty) return {};

    // Sort by quarter to get chronological order
    unemploymentTrends.sort((a, b) => a.quarter.compareTo(b.quarter));
    
    final latest = unemploymentTrends.last;
    final previous = unemploymentTrends.length > 1 ? unemploymentTrends[unemploymentTrends.length - 2] : null;

    return {
      'latestUnemploymentRate': latest.unemploymentRate,
      'trend': previous != null ? (latest.unemploymentRate! - previous.unemploymentRate!) : 0.0,
      'trendDirection': latest.trendDirection,
      'provinceRates': getUnemploymentByProvinceMap(),
      'isSignificant': latest.isSignificant,
      'confidenceLevel': latest.confidenceLevel,
    };
  }

  // Get industry employment trends
  static List<Map<String, dynamic>> getIndustryTrends() {
    final industryData = getEmploymentByIndustry();
    final Map<String, List<LaborMarketStatistics>> grouped = {};
    
    for (final data in industryData) {
      final industry = data.subcategory;
      if (industry.isNotEmpty) {
        grouped[industry] = grouped[industry] ?? [];
        grouped[industry]!.add(data);
      }
    }

    return grouped.entries.map((entry) {
      final industry = entry.key;
      final data = entry.value;
      
      if (data.isEmpty) return {'industry': industry, 'trend': 'Unknown'};
      
      // Sort by quarter to get latest data
      data.sort((a, b) => a.quarter.compareTo(b.quarter));
      final latest = data.last;
      
      return {
        'industry': industry,
        'currentEmployment': latest.currentQtr,
        'trend': latest.trendDirection,
        'changePercent': latest.qtrToQtrChangePercent,
        'isSignificant': latest.isSignificant,
      };
    }).toList();
  }
}
