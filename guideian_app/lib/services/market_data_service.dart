import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/job_listing.dart';
import '../models/market_demand.dart';

class MarketDataService {
  static List<JobListing> _jobListings = [];
  static List<MarketDemand> _marketDemand = [];
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Load job listings
      final jobListingsJson = await rootBundle.loadString('assets/data/job_listings.json');
      final jobListingsData = json.decode(jobListingsJson) as List;
      _jobListings = jobListingsData.map((data) => JobListing.fromCsv(data)).toList();

      // Load market demand data
      final marketDemandJson = await rootBundle.loadString('assets/data/market_demand.json');
      final marketDemandData = json.decode(marketDemandJson) as List;
      _marketDemand = marketDemandData.map((data) => MarketDemand.fromCsv(data)).toList();

      _isInitialized = true;
    } catch (e) {
      print('Error loading market data: $e');
      // Initialize with empty data if loading fails
      _jobListings = [];
      _marketDemand = [];
      _isInitialized = true;
    }
  }

  // Get all job listings
  static List<JobListing> getAllJobListings() {
    return _jobListings;
  }

  // Get job listings by industry
  static List<JobListing> getJobListingsByIndustry(String industry) {
    return _jobListings.where((job) => job.industry == industry).toList();
  }

  // Get job listings by salary range
  static List<JobListing> getJobListingsBySalaryRange(double minSalary, double maxSalary) {
    return _jobListings.where((job) {
      final avgSalary = job.averageSalary;
      return avgSalary >= minSalary && avgSalary <= maxSalary;
    }).toList();
  }

  // Get job listings by location
  static List<JobListing> getJobListingsByLocation(String location) {
    return _jobListings.where((job) => 
      job.location.toLowerCase().contains(location.toLowerCase())
    ).toList();
  }

  // Get unique industries
  static List<String> getIndustries() {
    final industries = _jobListings.map((job) => job.industry).toSet().toList();
    industries.sort();
    return industries;
  }

  // Get unique locations
  static List<String> getLocations() {
    final locations = _jobListings.map((job) => job.location).toSet().toList();
    locations.sort();
    return locations;
  }

  // Get salary statistics for an industry
  static Map<String, double> getSalaryStats(String industry) {
    final industryJobs = getJobListingsByIndustry(industry);
    if (industryJobs.isEmpty) return {'min': 0, 'max': 0, 'avg': 0};

    final salaries = industryJobs.map((job) => job.averageSalary).where((salary) => salary > 0).toList();
    if (salaries.isEmpty) return {'min': 0, 'max': 0, 'avg': 0};

    salaries.sort();
    return {
      'min': salaries.first,
      'max': salaries.last,
      'avg': salaries.reduce((a, b) => a + b) / salaries.length,
    };
  }

  // Get market demand for a job title
  static MarketDemand? getMarketDemand(String jobTitle) {
    return _marketDemand.firstWhere(
      (demand) => demand.ofoTitle.toLowerCase().contains(jobTitle.toLowerCase()),
      orElse: () => MarketDemand(
        ofoCode: '',
        ofoTitle: jobTitle,
        secondaryData: 0.0,
        mentionsFrequency: 0.0,
        averageCertainty: 0.0,
        weightedAverage: 0.3, // Default medium demand
      ),
    );
  }

  // Get top in-demand careers
  static List<MarketDemand> getTopDemandCareers({int limit = 10}) {
    final sortedDemand = List<MarketDemand>.from(_marketDemand);
    sortedDemand.sort((a, b) => b.weightedAverage.compareTo(a.weightedAverage));
    return sortedDemand.take(limit).toList();
  }

  // Search job listings
  static List<JobListing> searchJobListings(String query) {
    if (query.isEmpty) return _jobListings;
    
    final queryLower = query.toLowerCase();
    return _jobListings.where((job) =>
      job.jobTitle.toLowerCase().contains(queryLower) ||
      job.company.toLowerCase().contains(queryLower) ||
      job.industry.toLowerCase().contains(queryLower) ||
      job.location.toLowerCase().contains(queryLower)
    ).toList();
  }

  // Get career insights for a specific job
  static Map<String, dynamic> getCareerInsights(String jobTitle) {
    final marketDemand = getMarketDemand(jobTitle);
    final similarJobs = _jobListings.where((job) => 
      job.jobTitle.toLowerCase().contains(jobTitle.toLowerCase())
    ).toList();

    if (similarJobs.isEmpty) {
      return {
        'demand': marketDemand?.demandLevel ?? 'Medium Demand',
        'growth': marketDemand?.growthProjection ?? '+8% over 10 years',
        'avgSalary': 0,
        'jobCount': 0,
        'topSkills': [],
      };
    }

    final avgSalary = similarJobs.map((job) => job.averageSalary).reduce((a, b) => a + b) / similarJobs.length;
    final topSkills = _extractTopSkills(similarJobs);

    return {
      'demand': marketDemand?.demandLevel ?? 'Medium Demand',
      'growth': marketDemand?.growthProjection ?? '+8% over 10 years',
      'avgSalary': avgSalary,
      'jobCount': similarJobs.length,
      'topSkills': topSkills,
    };
  }

  static List<String> _extractTopSkills(List<JobListing> jobs) {
    // This would be enhanced with actual skill extraction from job descriptions
    // For now, return common skills based on industry
    final industry = jobs.first.industry;
    switch (industry) {
      case 'Information Technology':
        return ['Programming', 'Problem Solving', 'Database Management'];
      case 'Finance':
        return ['Financial Analysis', 'Excel', 'Accounting'];
      case 'Engineering':
        return ['Technical Skills', 'Project Management', 'Problem Solving'];
      default:
        return ['Communication', 'Teamwork', 'Problem Solving'];
    }
  }
}
