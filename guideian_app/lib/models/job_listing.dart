class JobListing {
  final String sheet;
  final String jobTitle;
  final String company;
  final String salary;
  final String positionType;
  final String location;

  JobListing({
    required this.sheet,
    required this.jobTitle,
    required this.company,
    required this.salary,
    required this.positionType,
    required this.location,
  });

  factory JobListing.fromCsv(Map<String, dynamic> csvData) {
    return JobListing(
      sheet: csvData['Sheet'] ?? '',
      jobTitle: csvData['Job Title'] ?? '',
      company: csvData['Company'] ?? '',
      salary: csvData['Salary'] ?? '',
      positionType: csvData['Position Type'] ?? '',
      location: csvData['Location'] ?? '',
    );
  }

  // Parse salary range to get numeric values
  double? get minSalary {
    if (salary.toLowerCase().contains('undisclosed')) return null;
    
    final salaryText = salary.replaceAll(RegExp(r'[^\d,.-]'), '');
    final parts = salaryText.split('-');
    if (parts.length >= 2) {
      return double.tryParse(parts[0].replaceAll(',', ''));
    }
    return double.tryParse(salaryText.replaceAll(',', ''));
  }

  double? get maxSalary {
    if (salary.toLowerCase().contains('undisclosed')) return null;
    
    final salaryText = salary.replaceAll(RegExp(r'[^\d,.-]'), '');
    final parts = salaryText.split('-');
    if (parts.length >= 2) {
      return double.tryParse(parts[1].replaceAll(',', ''));
    }
    return null;
  }

  double get averageSalary {
    final min = minSalary;
    final max = maxSalary;
    if (min != null && max != null) {
      return (min + max) / 2;
    }
    return min ?? 0;
  }

  // Get industry category from sheet
  String get industry {
    final sheetLower = sheet.toLowerCase();
    if (sheetLower.contains('admin')) return 'Administration';
    if (sheetLower.contains('agriculture')) return 'Agriculture';
    if (sheetLower.contains('legal')) return 'Legal';
    if (sheetLower.contains('engineering')) return 'Engineering';
    if (sheetLower.contains('construction')) return 'Construction';
    if (sheetLower.contains('business')) return 'Business';
    if (sheetLower.contains('finance')) return 'Finance';
    if (sheetLower.contains('it')) return 'Information Technology';
    if (sheetLower.contains('design')) return 'Design & Media';
    if (sheetLower.contains('education')) return 'Education';
    if (sheetLower.contains('cleaning')) return 'Maintenance';
    return 'Other';
  }

  // Get experience level from position type
  String get experienceLevel {
    final typeLower = positionType.toLowerCase();
    if (typeLower.contains('junior')) return 'Junior';
    if (typeLower.contains('senior')) return 'Senior';
    if (typeLower.contains('management')) return 'Management';
    if (typeLower.contains('specialist')) return 'Specialist';
    if (typeLower.contains('executive')) return 'Executive';
    return 'Intermediate';
  }
}
