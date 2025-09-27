class StudentProfile {
  final int mathMarks;
  final int englishMarks;
  final int scienceMarks;
  final String interest;
  final String budgetPreference;
  final String locationPreference;
  final String learningStyle;
  final String careerGoal;

  StudentProfile({
    required this.mathMarks,
    required this.englishMarks,
    required this.scienceMarks,
    required this.interest,
    required this.budgetPreference,
    required this.locationPreference,
    required this.learningStyle,
    required this.careerGoal,
  });

  factory StudentProfile.fromCsv(Map<String, dynamic> csvData) {
    return StudentProfile(
      mathMarks: int.tryParse(csvData['math_marks']?.toString() ?? '0') ?? 0,
      englishMarks: int.tryParse(csvData['english_marks']?.toString() ?? '0') ?? 0,
      scienceMarks: int.tryParse(csvData['science_marks']?.toString() ?? '0') ?? 0,
      interest: csvData['interest'] ?? '',
      budgetPreference: csvData['budget_preference'] ?? '',
      locationPreference: csvData['location_preference'] ?? '',
      learningStyle: csvData['learning_style'] ?? '',
      careerGoal: csvData['career_goal'] ?? '',
    );
  }

  // Calculate average marks
  double get averageMarks {
    return (mathMarks + englishMarks + scienceMarks) / 3.0;
  }

  // Get academic performance level
  String get academicLevel {
    final avg = averageMarks;
    if (avg >= 90) return 'Excellent';
    if (avg >= 80) return 'Very Good';
    if (avg >= 70) return 'Good';
    if (avg >= 60) return 'Average';
    return 'Below Average';
  }

  // Get strongest subject
  String get strongestSubject {
    if (mathMarks >= englishMarks && mathMarks >= scienceMarks) return 'Mathematics';
    if (englishMarks >= mathMarks && englishMarks >= scienceMarks) return 'English';
    return 'Science';
  }

  // Get recommended career paths based on profile
  List<String> get recommendedCareers {
    List<String> careers = [];
    
    // Based on interest
    switch (interest.toLowerCase()) {
      case 'technology':
        careers.addAll(['Software Developer', 'Data Analyst', 'IT Support', 'Cybersecurity Specialist']);
        break;
      case 'business':
        careers.addAll(['Business Analyst', 'Marketing Manager', 'Financial Advisor', 'Entrepreneur']);
        break;
      case 'engineering':
        careers.addAll(['Civil Engineer', 'Mechanical Engineer', 'Electrical Engineer', 'Project Manager']);
        break;
      case 'medicine':
        careers.addAll(['Doctor', 'Nurse', 'Pharmacist', 'Medical Researcher']);
        break;
      case 'law':
        careers.addAll(['Lawyer', 'Legal Advisor', 'Judge', 'Paralegal']);
        break;
      case 'education':
        careers.addAll(['Teacher', 'Education Administrator', 'Curriculum Developer', 'Academic Researcher']);
        break;
      case 'science':
        careers.addAll(['Research Scientist', 'Laboratory Technician', 'Environmental Scientist', 'Biologist']);
        break;
      case 'arts':
        careers.addAll(['Graphic Designer', 'Artist', 'Creative Director', 'Art Teacher']);
        break;
      case 'environment':
        careers.addAll(['Environmental Scientist', 'Conservation Officer', 'Sustainability Consultant', 'Ecologist']);
        break;
      case 'social sciences':
        careers.addAll(['Social Worker', 'Psychologist', 'Sociologist', 'Policy Analyst']);
        break;
      case 'sports':
        careers.addAll(['Sports Coach', 'Physical Therapist', 'Sports Manager', 'Fitness Instructor']);
        break;
      case 'mathematics':
        careers.addAll(['Mathematician', 'Statistician', 'Actuary', 'Data Scientist']);
        break;
    }

    // Filter by academic performance
    if (averageMarks < 70) {
      careers = careers.where((career) => 
        !career.contains('Doctor') && 
        !career.contains('Lawyer') && 
        !career.contains('Engineer')
      ).toList();
    }

    return careers.take(4).toList();
  }

  // Get education pathway recommendations
  String get recommendedEducationPath {
    if (averageMarks >= 85) {
      return 'University Degree';
    } else if (averageMarks >= 70) {
      return 'University Degree or Diploma';
    } else if (averageMarks >= 60) {
      return 'Diploma or Certificate';
    } else {
      return 'Certificate or Skills Training';
    }
  }

  // Get budget-appropriate recommendations
  List<String> get budgetAppropriateOptions {
    List<String> options = [];
    
    switch (budgetPreference.toLowerCase()) {
      case 'premium investment':
        options.addAll(['Private University', 'International Studies', 'Specialized Training']);
        break;
      case 'balanced':
        options.addAll(['Public University', 'TVET College', 'Online Courses']);
        break;
      case 'budget conscious':
        options.addAll(['TVET College', 'Online Learning', 'Apprenticeships', 'Skills Training']);
        break;
    }
    
    return options;
  }

  // Get location-appropriate institutions
  List<String> get locationAppropriateInstitutions {
    List<String> institutions = [];
    
    switch (locationPreference.toLowerCase()) {
      case 'western cape':
        institutions.addAll(['University of Cape Town', 'Stellenbosch University', 'Cape Peninsula University of Technology']);
        break;
      case 'gauteng':
        institutions.addAll(['University of Johannesburg', 'University of Pretoria', 'Wits University']);
        break;
      case 'kwazulu-natal':
        institutions.addAll(['University of KwaZulu-Natal', 'Durban University of Technology']);
        break;
      case 'anywhere in sa':
        institutions.addAll(['Any Public University', 'TVET Colleges Nationwide', 'Online Institutions']);
        break;
    }
    
    return institutions;
  }
}
