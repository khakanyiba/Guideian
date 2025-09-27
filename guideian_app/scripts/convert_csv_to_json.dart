import 'dart:io';
import 'dart:convert';

void main() async {
  // Convert Job_Listings.csv to JSON
  await convertJobListings();
  
  // Convert national_oihd_2024_cleaned.csv to JSON
  await convertMarketDemand();
  
  // Convert STATS-SA-QLFS2022_to_2025.csv to JSON
  await convertLaborMarketStatistics();
  
  // Convert Students.csv to JSON
  await convertStudentProfiles();
  
  print('CSV to JSON conversion completed!');
}

Future<void> convertJobListings() async {
  try {
    final file = File('Job_Listings.csv');
    final lines = await file.readAsLines();
    
    if (lines.isEmpty) return;
    
    final headers = lines[0].split(',');
    final List<Map<String, dynamic>> jsonData = [];
    
    for (int i = 1; i < lines.length; i++) {
      final values = _parseCsvLine(lines[i]);
      if (values.length >= headers.length) {
        final Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length; j++) {
          row[headers[j].trim()] = values[j].trim();
        }
        jsonData.add(row);
      }
    }
    
    // Create assets directory if it doesn't exist
    final assetsDir = Directory('assets/data');
    if (!await assetsDir.exists()) {
      await assetsDir.create(recursive: true);
    }
    
    // Write JSON file
    final jsonFile = File('assets/data/job_listings.json');
    await jsonFile.writeAsString(json.encode(jsonData));
    
    print('Converted ${jsonData.length} job listings to JSON');
  } catch (e) {
    print('Error converting job listings: $e');
  }
}

Future<void> convertMarketDemand() async {
  try {
    final file = File('national_oihd_2024_cleaned.csv');
    final lines = await file.readAsLines();
    
    if (lines.isEmpty) return;
    
    final headers = lines[0].split(',');
    final List<Map<String, dynamic>> jsonData = [];
    
    for (int i = 1; i < lines.length; i++) {
      final values = _parseCsvLine(lines[i]);
      if (values.length >= headers.length) {
        final Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length; j++) {
          row[headers[j].trim()] = values[j].trim();
        }
        jsonData.add(row);
      }
    }
    
    // Create assets directory if it doesn't exist
    final assetsDir = Directory('assets/data');
    if (!await assetsDir.exists()) {
      await assetsDir.create(recursive: true);
    }
    
    // Write JSON file
    final jsonFile = File('assets/data/market_demand.json');
    await jsonFile.writeAsString(json.encode(jsonData));
    
    print('Converted ${jsonData.length} market demand records to JSON');
  } catch (e) {
    print('Error converting market demand: $e');
  }
}

List<String> _parseCsvLine(String line) {
  final List<String> result = [];
  bool inQuotes = false;
  String currentField = '';
  
  for (int i = 0; i < line.length; i++) {
    final char = line[i];
    
    if (char == '"') {
      inQuotes = !inQuotes;
    } else if (char == ',' && !inQuotes) {
      result.add(currentField);
      currentField = '';
    } else {
      currentField += char;
    }
  }
  
  result.add(currentField);
  return result;
}

Future<void> convertLaborMarketStatistics() async {
  try {
    final file = File('STATS-SA-QLFS2022_to_2025.csv');
    final lines = await file.readAsLines();
    
    print('Labor market CSV has ${lines.length} lines');
    if (lines.isEmpty) return;
    
    final headers = lines[0].split(',');
    final List<Map<String, dynamic>> jsonData = [];
    
    for (int i = 1; i < lines.length; i++) {
      final values = _parseCsvLine(lines[i]);
      if (values.length >= headers.length) {
        final Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length; j++) {
          row[headers[j].trim()] = values[j].trim();
        }
        jsonData.add(row);
      }
    }
    
    // Create assets directory if it doesn't exist
    final assetsDir = Directory('assets/data');
    if (!await assetsDir.exists()) {
      await assetsDir.create(recursive: true);
    }
    
    // Write JSON file
    final jsonFile = File('assets/data/labor_market_statistics.json');
    await jsonFile.writeAsString(json.encode(jsonData));
    
    print('Converted ${jsonData.length} labor market statistics to JSON');
  } catch (e) {
    print('Error converting labor market statistics: $e');
  }
}

Future<void> convertStudentProfiles() async {
  try {
    final file = File('Students.csv');
    final lines = await file.readAsLines();
    
    if (lines.isEmpty) return;
    
    final headers = lines[0].split(',');
    final List<Map<String, dynamic>> jsonData = [];
    
    for (int i = 1; i < lines.length; i++) {
      final values = _parseCsvLine(lines[i]);
      if (values.length >= headers.length) {
        final Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length; j++) {
          row[headers[j].trim()] = values[j].trim();
        }
        jsonData.add(row);
      }
    }
    
    // Create assets directory if it doesn't exist
    final assetsDir = Directory('assets/data');
    if (!await assetsDir.exists()) {
      await assetsDir.create(recursive: true);
    }
    
    // Write JSON file
    final jsonFile = File('assets/data/student_profiles.json');
    await jsonFile.writeAsString(json.encode(jsonData));
    
    print('Converted ${jsonData.length} student profiles to JSON');
  } catch (e) {
    print('Error converting student profiles: $e');
  }
}
