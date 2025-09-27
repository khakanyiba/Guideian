import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/guideian_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/market_data_service.dart';
import '../services/labor_market_service.dart';
import '../models/job_listing.dart';
import '../models/market_demand.dart';

class CareerInsightsScreen extends StatefulWidget {
  const CareerInsightsScreen({super.key});

  @override
  State<CareerInsightsScreen> createState() => _CareerInsightsScreenState();
}

class _CareerInsightsScreenState extends State<CareerInsightsScreen> {
  String selectedTab = 'Career Explorer';
  String selectedIndustry = 'All Industries';
  String selectedEducation = 'All Levels';
  double salaryRange = 45000;
  double growthScore = 0;
  List<String> selectedSkills = [];
  String searchQuery = ''; 
  String sortBy = 'Popularity';
  bool _isDataLoaded = false;
  List<JobListing> _filteredJobs = [];
  List<MarketDemand> _topDemandCareers = [];
  Map<String, dynamic> _laborMarketTrends = {};
  Map<String, dynamic> _studentInsights = {};

  final List<String> tabs = [
    'National Overview',
    'Career Explorer',
  ];

  List<String> get industries {
    if (!_isDataLoaded) {
      return [
        'All Industries',
        'Technology',
        'Healthcare',
        'Finance',
        'Engineering',
        'Education',
        'Marketing',
        'Creative',
        'Trades & Services',
        'Legal',
        'Sciences',
        'Hospitality',
        'Transportation',
        'Agriculture',
        'Manufacturing',
        'Construction',
        'Retail',
        'Government',
      ];
    }
    final realIndustries = MarketDataService.getIndustries();
    return ['All Industries', ...realIndustries];
  }

  final List<String> educationLevels = [
    'All Levels',
    'Matric',
    'Diploma',
    'Bachelor\'s',
    'Master\'s',
    'PhD',
  ];

  @override
  void initState() {
    super.initState();
    _loadMarketData();
  }

  Future<void> _loadMarketData() async {
    try {
      await MarketDataService.initialize();
      await LaborMarketService.initialize();
      
      setState(() {
        _isDataLoaded = true;
        _filteredJobs = MarketDataService.getAllJobListings();
        _topDemandCareers = MarketDataService.getTopDemandCareers(limit: 10);
        _laborMarketTrends = LaborMarketService.getLaborMarketTrends();
        _studentInsights = LaborMarketService.getStudentInsights();
      });
      
      // Debug print to check data loading
      print('Labor market trends: $_laborMarketTrends');
      print('Student insights: $_studentInsights');
    } catch (e) {
      print('Error loading market data: $e');
    }
  }

  void _filterJobs() {
    if (!_isDataLoaded) return;
    
    List<JobListing> filtered = MarketDataService.getAllJobListings();
    
    // Filter by industry
    if (selectedIndustry != 'All Industries') {
      filtered = filtered.where((job) => job.industry == selectedIndustry).toList();
    }
    
    // Filter by salary range
    filtered = filtered.where((job) => job.averageSalary <= salaryRange).toList();
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = MarketDataService.searchJobListings(searchQuery);
    }
    
    setState(() {
      _filteredJobs = filtered;
    });
  }

  final List<String> skills = [
    'JavaScript',
    'React',
    'Node.js',
    'Python',
    'Machine Learning',
    'Data Analysis',
    'Project Management',
    'Digital Marketing',
    'Financial Modeling',
    'CAD',
    'Patient Care',
    'Medical Knowledge',
    'Critical Thinking',
    'UX/UI Design',
    'Adobe Creative Suite',
    'Welding',
    'Plumbing',
    'Teaching',
    'Curriculum Development',
    'Public Speaking',
    'SQL',
    'Java',
    'C++',
    'Cloud Computing',
    'Cybersecurity',
    'Network Administration',
    'Mobile Development',
    'DevOps',
    'Artificial Intelligence',
    'Blockchain',
    'Content Writing',
    'SEO',
    'Social Media Marketing',
    'Graphic Design',
    'Video Editing',
    'Photography',
    'Sales',
    'Customer Service',
    'Leadership',
    'Risk Management',
    'Accounting',
    'Legal Research',
    'Contract Law',
    'Laboratory Skills',
    'Research Methods',
    'Statistical Analysis',
    'Event Planning',
    'Food Safety',
    'Quality Control',
    'Supply Chain Management',
  ];

  final List<CareerCard> careers = [
    // Technology Careers
    CareerCard(
      title: 'Software Engineer',
      industry: 'Technology',
      salary: 'R 35,000',
      salaryNumber: 35000,
      totalEmployed: '45,800',
      growthScore: 85,
      growthColor: const Color(0xFF16A34A),
      description: 'Designs, develops, and maintains software applications for various platforms.',
      skills: ['JavaScript', 'React', 'Node.js', 'Python'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+22% over 10 years',
      entryRequirements: 'Bachelor\'s in Computer Science, portfolio projects',
      coreSkills: ['Programming', 'Problem-solving', 'Debugging'],
      emergingSkills: ['AI/ML', 'Cloud Architecture', 'DevOps'],
      niceToHaveSkills: ['Mobile Development', 'UI/UX Design'],
      videoUrl: 'https://www.youtube.com/results?search_query=software+engineer+career+explained',
    ),
    CareerCard(
      title: 'Data Scientist',
      industry: 'Technology',
      salary: 'R 40,000',
      salaryNumber: 40000,
      totalEmployed: '12,500',
      growthScore: 88,
      growthColor: const Color(0xFF16A34A),
      description: 'Analyzes and interprets complex data to inform business decisions and create predictive models.',
      skills: ['Python', 'Machine Learning', 'Data Analysis', 'SQL'],
      education: 'Master\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+31% over 10 years',
      entryRequirements: 'Master\'s in Data Science/Statistics, Python proficiency',
      coreSkills: ['Statistical Analysis', 'Machine Learning', 'Data Visualization'],
      emergingSkills: ['Deep Learning', 'MLOps', 'Big Data Technologies'],
      niceToHaveSkills: ['Domain Expertise', 'Business Acumen'],
      videoUrl: 'https://www.youtube.com/results?search_query=data+scientist+career+path',
    ),
    CareerCard(
      title: 'Cybersecurity Specialist',
      industry: 'Technology',
      salary: 'R 38,000',
      salaryNumber: 38000,
      totalEmployed: '8,200',
      growthScore: 90,
      growthColor: const Color(0xFF16A34A),
      description: 'Protects systems and networks from digital attacks and security breaches.',
      skills: ['Network Security', 'Penetration Testing', 'Security Analysis', 'Cryptography'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+35% over 10 years',
      entryRequirements: 'Bachelor\'s in Cybersecurity/IT, security certifications',
      coreSkills: ['Network Security', 'Risk Assessment', 'Incident Response'],
      emergingSkills: ['Cloud Security', 'AI Security', 'Zero Trust Architecture'],
      niceToHaveSkills: ['Forensics', 'Compliance', 'Ethical Hacking'],
      videoUrl: 'https://www.youtube.com/results?search_query=cybersecurity+specialist+career',
    ),
    CareerCard(
      title: 'UX/UI Designer',
      industry: 'Technology',
      salary: 'R 29,000',
      salaryNumber: 29000,
      totalEmployed: '9,800',
      growthScore: 82,
      growthColor: const Color(0xFF16A34A),
      description: 'Designs user-friendly interfaces and experiences for websites and mobile applications.',
      skills: ['UX/UI Design', 'Wireframing', 'Prototyping', 'Adobe Creative Suite'],
      education: 'Diploma or Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+18% over 10 years',
      entryRequirements: 'Design degree, portfolio, design tools proficiency',
      coreSkills: ['User Research', 'Wireframing', 'Visual Design'],
      emergingSkills: ['Voice UI', 'AR/VR Design', 'Design Systems'],
      niceToHaveSkills: ['Front-end Development', 'Motion Design'],
      videoUrl: 'https://www.youtube.com/results?search_query=ux+ui+designer+career+guide',
    ),
    CareerCard(
      title: 'DevOps Engineer',
      industry: 'Technology',
      salary: 'R 42,000',
      salaryNumber: 42000,
      totalEmployed: '6,500',
      growthScore: 87,
      growthColor: const Color(0xFF16A34A),
      description: 'Bridges development and operations, automating and streamlining software deployment.',
      skills: ['DevOps', 'Cloud Computing', 'Automation', 'Docker'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+28% over 10 years',
      entryRequirements: 'Bachelor\'s in IT/Engineering, cloud certifications',
      coreSkills: ['CI/CD', 'Infrastructure as Code', 'Monitoring'],
      emergingSkills: ['GitOps', 'Service Mesh', 'Platform Engineering'],
      niceToHaveSkills: ['Security', 'Cost Optimization', 'Team Leadership'],
      videoUrl: 'https://www.youtube.com/results?search_query=devops+engineer+career+path',
    ),
    CareerCard(
      title: 'Mobile App Developer',
      industry: 'Technology',
      salary: 'R 33,000',
      salaryNumber: 33000,
      totalEmployed: '15,200',
      growthScore: 80,
      growthColor: const Color(0xFF16A34A),
      description: 'Creates applications for mobile devices using various programming languages and frameworks.',
      skills: ['Mobile Development', 'Java', 'Swift', 'React Native'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+19% over 10 years',
      entryRequirements: 'Bachelor\'s in Computer Science, mobile development portfolio',
      coreSkills: ['iOS/Android Development', 'API Integration', 'Mobile UI/UX'],
      emergingSkills: ['Cross-platform Development', 'AR/VR', 'IoT Integration'],
      niceToHaveSkills: ['Backend Development', 'Game Development', 'Performance Optimization'],
      videoUrl: 'https://www.youtube.com/results?search_query=mobile+app+developer+career',
    ),
    CareerCard(
      title: 'AI/Machine Learning Engineer',
      industry: 'Technology',
      salary: 'R 45,000',
      salaryNumber: 45000,
      totalEmployed: '4,800',
      growthScore: 92,
      growthColor: const Color(0xFF16A34A),
      description: 'Develops and implements AI models and machine learning systems for various applications.',
      skills: ['Machine Learning', 'Python', 'TensorFlow', 'Data Science'],
      education: 'Master\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+40% over 10 years',
      entryRequirements: 'Master\'s in AI/ML/Data Science, strong math background',
      coreSkills: ['Machine Learning Algorithms', 'Model Training', 'Data Pipeline'],
      emergingSkills: ['Large Language Models', 'Computer Vision', 'Reinforcement Learning'],
      niceToHaveSkills: ['Research', 'Domain Expertise', 'Cloud Platforms'],
      videoUrl: 'https://www.youtube.com/results?search_query=ai+machine+learning+engineer+career',
    ),
    CareerCard(
      title: 'Cloud Solutions Architect',
      industry: 'Technology',
      salary: 'R 48,000',
      salaryNumber: 48000,
      totalEmployed: '5,200',
      growthScore: 89,
      growthColor: const Color(0xFF16A34A),
      description: 'Designs and manages cloud computing strategies and infrastructure for organizations.',
      skills: ['Cloud Computing', 'AWS', 'Azure', 'System Architecture'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+30% over 10 years',
      entryRequirements: 'Bachelor\'s in IT/Engineering, cloud certifications (AWS/Azure)',
      coreSkills: ['Cloud Architecture', 'System Design', 'Cost Optimization'],
      emergingSkills: ['Multi-cloud Strategy', 'Serverless Architecture', 'Edge Computing'],
      niceToHaveSkills: ['Security', 'Compliance', 'Business Strategy'],
      videoUrl: 'https://www.youtube.com/results?search_query=cloud+solutions+architect+career',
    ),

    // Healthcare Careers
    CareerCard(
      title: 'Registered Nurse',
      industry: 'Healthcare',
      salary: 'R 26,500',
      salaryNumber: 26500,
      totalEmployed: '189,100',
      growthScore: 78,
      growthColor: const Color(0xFF22C55E),
      description: 'Provides and coordinates patient care in various healthcare settings.',
      skills: ['Patient Care', 'Medical Knowledge', 'Critical Thinking', 'First Aid'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+15% over 10 years',
      entryRequirements: 'Bachelor\'s in Nursing, nursing license, clinical experience',
      coreSkills: ['Patient Assessment', 'Medication Administration', 'Care Planning'],
      emergingSkills: ['Telehealth', 'Health Informatics', 'Specialized Care'],
      niceToHaveSkills: ['Leadership', 'Research', 'Teaching'],
      videoUrl: 'https://www.youtube.com/results?search_query=registered+nurse+career+overview',
    ),
    CareerCard(
      title: 'Doctor (General Practitioner)',
      industry: 'Healthcare',
      salary: 'R 55,000',
      salaryNumber: 55000,
      totalEmployed: '45,600',
      growthScore: 75,
      growthColor: const Color(0xFF22C55E),
      description: 'Provides primary healthcare services, diagnoses and treats various medical conditions.',
      skills: ['Medical Knowledge', 'Diagnostic Skills', 'Patient Communication', 'Clinical Decision Making'],
      education: 'Medical degree and residency required',
      demandLevel: 'High',
      projectedGrowth: '+12% over 10 years',
      entryRequirements: 'Medical degree, residency, medical license',
      coreSkills: ['Diagnosis', 'Treatment Planning', 'Patient Communication'],
      emergingSkills: ['Telemedicine', 'Precision Medicine', 'Health Technology'],
      niceToHaveSkills: ['Research', 'Teaching', 'Healthcare Management'],
      videoUrl: 'https://www.youtube.com/results?search_query=general+practitioner+doctor+career',
    ),
    CareerCard(
      title: 'Pharmacist',
      industry: 'Healthcare',
      salary: 'R 38,000',
      salaryNumber: 38000,
      totalEmployed: '12,800',
      growthScore: 70,
      growthColor: const Color(0xFFEAB308),
      description: 'Dispenses medications and provides pharmaceutical care to patients.',
      skills: ['Pharmaceutical Knowledge', 'Patient Counseling', 'Medication Management'],
      education: 'Pharmacy degree required',
      demandLevel: 'Medium',
      projectedGrowth: '+8% over 10 years',
      entryRequirements: 'Pharmacy degree, pharmacy license, internship',
      coreSkills: ['Drug Interactions', 'Dosage Calculations', 'Patient Education'],
      emergingSkills: ['Clinical Pharmacy', 'Pharmacogenomics', 'Digital Health'],
      niceToHaveSkills: ['Business Management', 'Research', 'Specialization'],
      videoUrl: 'https://www.youtube.com/results?search_query=pharmacist+career+guide',
    ),
    CareerCard(
      title: 'Physiotherapist',
      industry: 'Healthcare',
      salary: 'R 28,000',
      salaryNumber: 28000,
      totalEmployed: '18,500',
      growthScore: 73,
      growthColor: const Color(0xFF22C55E),
      description: 'Helps patients recover from injuries and improve mobility through physical therapy.',
      skills: ['Physical Therapy Techniques', 'Patient Assessment', 'Exercise Prescription'],
      education: 'Bachelor\'s degree in Physiotherapy required',
      demandLevel: 'High',
      projectedGrowth: '+16% over 10 years',
      entryRequirements: 'Bachelor\'s in Physiotherapy, professional registration',
      coreSkills: ['Manual Therapy', 'Exercise Therapy', 'Patient Assessment'],
      emergingSkills: ['Telerehabilitation', 'Sports Therapy', 'Geriatric Care'],
      niceToHaveSkills: ['Sports Medicine', 'Research', 'Business Skills'],
      videoUrl: 'https://www.youtube.com/results?search_query=physiotherapist+career+path',
    ),
    CareerCard(
      title: 'Medical Laboratory Technologist',
      industry: 'Healthcare',
      salary: 'R 24,000',
      salaryNumber: 24000,
      totalEmployed: '15,200',
      growthScore: 68,
      growthColor: const Color(0xFFEAB308),
      description: 'Performs laboratory tests to help diagnose diseases and monitor patient health.',
      skills: ['Laboratory Skills', 'Medical Knowledge', 'Quality Control', 'Analytical Skills'],
      education: 'Diploma or Bachelor\'s degree required',
      demandLevel: 'Medium',
      projectedGrowth: '+11% over 10 years',
      entryRequirements: 'Diploma/Degree in Medical Laboratory Science, certification',
      coreSkills: ['Laboratory Testing', 'Quality Assurance', 'Data Analysis'],
      emergingSkills: ['Molecular Diagnostics', 'Automation', 'Point-of-care Testing'],
      niceToHaveSkills: ['Research', 'Laboratory Management', 'Specialized Testing'],
      videoUrl: 'https://www.youtube.com/results?search_query=medical+laboratory+technologist+career',
    ),
    CareerCard(
      title: 'Dentist',
      industry: 'Healthcare',
      salary: 'R 52,000',
      salaryNumber: 52000,
      totalEmployed: '8,900',
      growthScore: 72,
      growthColor: const Color(0xFFEAB308),
      description: 'Diagnoses and treats dental and oral health problems.',
      skills: ['Dental Procedures', 'Patient Care', 'Diagnostic Skills', 'Hand Dexterity'],
      education: 'Dental degree required',
      demandLevel: 'Medium',
      projectedGrowth: '+9% over 10 years',
      entryRequirements: 'Dental degree, dental license, clinical training',
      coreSkills: ['Oral Diagnosis', 'Dental Procedures', 'Patient Management'],
      emergingSkills: ['Digital Dentistry', 'Cosmetic Dentistry', 'Oral Surgery'],
      niceToHaveSkills: ['Practice Management', 'Specialization', 'Research'],
      videoUrl: 'https://www.youtube.com/results?search_query=dentist+career+overview',
    ),

    // Finance Careers
    CareerCard(
      title: 'Financial Analyst',
      industry: 'Finance',
      salary: 'R 35,000',
      salaryNumber: 35000,
      totalEmployed: '34,500',
      growthScore: 75,
      growthColor: const Color(0xFF22C55E),
      description: 'Analyzes financial data and provides insights for investment decisions.',
      skills: ['Financial Modeling', 'Investment Analysis', 'Risk Assessment', 'Excel'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+13% over 10 years',
      entryRequirements: 'Bachelor\'s in Finance/Economics, Excel proficiency',
      coreSkills: ['Financial Analysis', 'Modeling', 'Forecasting'],
      emergingSkills: ['Data Analytics', 'FinTech', 'ESG Analysis'],
      niceToHaveSkills: ['CFA Certification', 'Programming', 'Industry Expertise'],
      videoUrl: 'https://www.youtube.com/results?search_query=financial+analyst+career+guide',
    ),
    CareerCard(
      title: 'Accountant',
      industry: 'Finance',
      salary: 'R 28,000',
      salaryNumber: 28000,
      totalEmployed: '78,200',
      growthScore: 65,
      growthColor: const Color(0xFFEAB308),
      description: 'Prepares and examines financial records, ensures compliance with regulations.',
      skills: ['Accounting', 'Financial Reporting', 'Tax Preparation', 'Auditing'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+7% over 10 years',
      entryRequirements: 'Bachelor\'s in Accounting, professional certification (SAICA)',
      coreSkills: ['Financial Reporting', 'Tax Compliance', 'Bookkeeping'],
      emergingSkills: ['Accounting Software', 'Data Analytics', 'Forensic Accounting'],
      niceToHaveSkills: ['CA(SA) Qualification', 'Business Advisory', 'Management'],
      videoUrl: 'https://www.youtube.com/results?search_query=accountant+career+path',
    ),
    CareerCard(
      title: 'Investment Banking Analyst',
      industry: 'Finance',
      salary: 'R 45,000',
      salaryNumber: 45000,
      totalEmployed: '5,800',
      growthScore: 70,
      growthColor: const Color(0xFFEAB308),
      description: 'Provides financial advisory services for mergers, acquisitions, and capital raising.',
      skills: ['Financial Modeling', 'Valuation', 'Deal Execution', 'Client Relations'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+10% over 10 years',
      entryRequirements: 'Bachelor\'s in Finance/Economics, strong analytical skills',
      coreSkills: ['Financial Modeling', 'Valuation', 'Market Analysis'],
      emergingSkills: ['ESG Investing', 'Technology Deals', 'Alternative Investments'],
      niceToHaveSkills: ['CFA', 'MBA', 'Industry Specialization'],
      videoUrl: 'https://www.youtube.com/results?search_query=investment+banking+analyst+career',
    ),
    CareerCard(
      title: 'Risk Manager',
      industry: 'Finance',
      salary: 'R 42,000',
      salaryNumber: 42000,
      totalEmployed: '12,400',
      growthScore: 78,
      growthColor: const Color(0xFF22C55E),
      description: 'Identifies and mitigates financial and operational risks within organizations.',
      skills: ['Risk Assessment', 'Statistical Analysis', 'Compliance', 'Financial Modeling'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+17% over 10 years',
      entryRequirements: 'Bachelor\'s in Finance/Economics, risk management certification',
      coreSkills: ['Risk Assessment', 'Regulatory Compliance', 'Data Analysis'],
      emergingSkills: ['Cyber Risk', 'Climate Risk', 'Operational Risk'],
      niceToHaveSkills: ['FRM Certification', 'Programming', 'Industry Knowledge'],
      videoUrl: 'https://www.youtube.com/results?search_query=risk+manager+career+finance',
    ),
    CareerCard(
      title: 'Financial Planner',
      industry: 'Finance',
      salary: 'R 32,000',
      salaryNumber: 32000,
      totalEmployed: '18,600',
      growthScore: 73,
      growthColor: const Color(0xFF22C55E),
      description: 'Helps individuals and businesses create strategies to meet financial goals.',
      skills: ['Financial Planning', 'Investment Knowledge', 'Client Relations', 'Insurance'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+15% over 10 years',
      entryRequirements: 'Bachelor\'s in Finance, financial planning certification',
      coreSkills: ['Financial Planning', 'Investment Advice', 'Client Management'],
      emergingSkills: ['Digital Planning Tools', 'ESG Investing', 'Retirement Planning'],
      niceToHaveSkills: ['CFP Certification', 'Tax Knowledge', 'Estate Planning'],
      videoUrl: 'https://www.youtube.com/results?search_query=financial+planner+career+guide',
    ),

    // Engineering Careers
    CareerCard(
      title: 'Mechanical Engineer',
      industry: 'Engineering',
      salary: 'R 31,500',
      salaryNumber: 31500,
      totalEmployed: '28,900',
      growthScore: 65,
      growthColor: const Color(0xFFEAB308),
      description: 'Designs, analyzes, and manufactures mechanical systems and components.',
      skills: ['CAD', 'Thermodynamics', 'Material Science', 'Problem-Solving'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+9% over 10 years',
      entryRequirements: 'Bachelor\'s in Mechanical Engineering, professional registration',
      coreSkills: ['Design', 'Analysis', 'Manufacturing'],
      emergingSkills: ['Additive Manufacturing', 'Renewable Energy', 'Automation'],
      niceToHaveSkills: ['Project Management', 'Software Skills', 'Industry Specialization'],
      videoUrl: 'https://www.youtube.com/results?search_query=mechanical+engineer+career+overview',
    ),
    CareerCard(
      title: 'Civil Engineer',
      industry: 'Engineering',
      salary: 'R 34,000',
      salaryNumber: 34000,
      totalEmployed: '21,300',
      growthScore: 61,
      growthColor: const Color(0xFF3B82F6),
      description: 'Designs and supervises infrastructure projects like roads, bridges, and buildings.',
      skills: ['Structural Design', 'AutoCAD', 'Project Management', 'Surveying'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+6% over 10 years',
      entryRequirements: 'Bachelor\'s in Civil Engineering, professional registration',
      coreSkills: ['Structural Design', 'Project Management', 'Construction Knowledge'],
      emergingSkills: ['Sustainable Design', 'BIM', 'Smart Infrastructure'],
      niceToHaveSkills: ['Geotechnical Knowledge', 'Environmental Engineering', 'Leadership'],
      videoUrl: 'https://www.youtube.com/results?search_query=civil+engineer+career+path',
    ),
    CareerCard(
      title: 'Electrical Engineer',
      industry: 'Engineering',
      salary: 'R 36,000',
      salaryNumber: 36000,
      totalEmployed: '19,800',
      growthScore: 68,
      growthColor: const Color(0xFFEAB308),
      description: 'Designs and develops electrical systems and equipment.',
      skills: ['Electrical Systems', 'Circuit Design', 'Power Systems', 'Control Systems'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+11% over 10 years',
      entryRequirements: 'Bachelor\'s in Electrical Engineering, professional registration',
      coreSkills: ['Circuit Design', 'System Analysis', 'Testing'],
      emergingSkills: ['Renewable Energy', 'Smart Grids', 'IoT'],
      niceToHaveSkills: ['Power Systems', 'Automation', 'Project Management'],
      videoUrl: 'https://www.youtube.com/results?search_query=electrical+engineer+career+guide',
    ),
    CareerCard(
      title: 'Chemical Engineer',
      industry: 'Engineering',
      salary: 'R 39,000',
      salaryNumber: 39000,
      totalEmployed: '8,500',
      growthScore: 72,
      growthColor: const Color(0xFFEAB308),
      description: 'Applies chemistry and engineering principles to industrial processes.',
      skills: ['Process Design', 'Chemical Knowledge', 'Safety Engineering', 'Process Control'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+14% over 10 years',
      entryRequirements: 'Bachelor\'s in Chemical Engineering, industry knowledge',
      coreSkills: ['Process Design', 'Chemical Analysis', 'Safety Management'],
      emergingSkills: ['Green Chemistry', 'Biotechnology', 'Nanotechnology'],
      niceToHaveSkills: ['Environmental Engineering', 'Project Management', 'Research'],
      videoUrl: 'https://www.youtube.com/results?search_query=chemical+engineer+career+overview',
    ),
    CareerCard(
      title: 'Industrial Engineer',
      industry: 'Engineering',
      salary: 'R 33,000',
      salaryNumber: 33000,
      totalEmployed: '15,600',
      growthScore: 69,
      growthColor: const Color(0xFFEAB308),
      description: 'Optimizes processes, systems, and organizations for efficiency and productivity.',
      skills: ['Process Optimization', 'Lean Manufacturing', 'Quality Control', 'Data Analysis'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+12% over 10 years',
      entryRequirements: 'Bachelor\'s in Industrial Engineering, systems thinking',
      coreSkills: ['Process Improvement', 'Data Analysis', 'Systems Design'],
      emergingSkills: ['Industry 4.0', 'Supply Chain Optimization', 'Automation'],
      niceToHaveSkills: ['Six Sigma', 'Project Management', 'Leadership'],
      videoUrl: 'https://www.youtube.com/results?search_query=industrial+engineer+career+path',
    ),

    // Education Careers
    CareerCard(
      title: 'Teacher (FET Phase)',
      industry: 'Education',
      salary: 'R 25,000',
      salaryNumber: 25000,
      totalEmployed: '145,000',
      growthScore: 68,
      growthColor: const Color(0xFFEAB308),
      description: 'Educates students in specific subjects, preparing them for tertiary education.',
      skills: ['Curriculum Development', 'Classroom Management', 'Assessment', 'Public Speaking'],
      education: 'Bachelor\'s degree in Education required',
      demandLevel: 'Medium',
      projectedGrowth: '+10% over 10 years',
      entryRequirements: 'Bachelor\'s in Education, teaching qualification, subject expertise',
      coreSkills: ['Teaching Methods', 'Curriculum Design', 'Student Assessment'],
      emergingSkills: ['Digital Learning', 'Blended Teaching', 'Educational Technology'],
      niceToHaveSkills: ['Leadership', 'Counseling', 'Research'],
      videoUrl: 'https://www.youtube.com/results?search_query=high+school+teacher+career+guide',
    ),
    CareerCard(
      title: 'University Lecturer',
      industry: 'Education',
      salary: 'R 32,000',
      salaryNumber: 32000,
      totalEmployed: '25,400',
      growthScore: 65,
      growthColor: const Color(0xFFEAB308),
      description: 'Teaches university-level courses and conducts research in specialized fields.',
      skills: ['Teaching', 'Research Methods', 'Academic Writing', 'Public Speaking'],
      education: 'Master\'s or PhD required',
      demandLevel: 'Medium',
      projectedGrowth: '+8% over 10 years',
      entryRequirements: 'Master\'s/PhD in field, research experience, publications',
      coreSkills: ['Research', 'Teaching', 'Academic Writing'],
      emergingSkills: ['Online Education', 'Interdisciplinary Research', 'Digital Humanities'],
      niceToHaveSkills: ['Grant Writing', 'Supervision', 'Administration'],
      videoUrl: 'https://www.youtube.com/results?search_query=university+lecturer+professor+career',
    ),
    CareerCard(
      title: 'Educational Psychologist',
      industry: 'Education',
      salary: 'R 28,000',
      salaryNumber: 28000,
      totalEmployed: '4,800',
      growthScore: 72,
      growthColor: const Color(0xFFEAB308),
      description: 'Helps students overcome learning difficulties and psychological barriers to education.',
      skills: ['Psychology', 'Assessment', 'Counseling', 'Educational Theory'],
      education: 'Master\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+14% over 10 years',
      entryRequirements: 'Master\'s in Educational Psychology, professional registration',
      coreSkills: ['Psychological Assessment', 'Intervention Planning', 'Counseling'],
      emergingSkills: ['Digital Assessment Tools', 'Learning Analytics', 'Neurodiversity Support'],
      niceToHaveSkills: ['Research', 'Training', 'Consultation'],
      videoUrl: 'https://www.youtube.com/results?search_query=educational+psychologist+career',
    ),

    // Marketing Careers
    CareerCard(
      title: 'Marketing Manager',
      industry: 'Marketing',
      salary: 'R 33,000',
      salaryNumber: 33000,
      totalEmployed: '56,200',
      growthScore: 72,
      growthColor: const Color(0xFFEAB308),
      description: 'Plans and executes marketing strategies to promote products and services.',
      skills: ['Digital Marketing', 'Brand Management', 'Market Research', 'SEO'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+13% over 10 years',
      entryRequirements: 'Bachelor\'s in Marketing/Business, campaign experience',
      coreSkills: ['Strategy Development', 'Campaign Management', 'Analytics'],
      emergingSkills: ['AI Marketing', 'Influencer Marketing', 'Personalization'],
      niceToHaveSkills: ['Data Analysis', 'Content Creation', 'Leadership'],
      videoUrl: 'https://www.youtube.com/results?search_query=marketing+manager+career+path',
    ),
    CareerCard(
      title: 'Digital Marketing Specialist',
      industry: 'Marketing',
      salary: 'R 27,000',
      salaryNumber: 27000,
      totalEmployed: '32,800',
      growthScore: 85,
      growthColor: const Color(0xFF16A34A),
      description: 'Manages online marketing campaigns across various digital platforms.',
      skills: ['Digital Marketing', 'SEO', 'Social Media Marketing', 'Google Ads'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+25% over 10 years',
      entryRequirements: 'Bachelor\'s in Marketing, digital marketing certifications',
      coreSkills: ['SEO/SEM', 'Social Media', 'Email Marketing'],
      emergingSkills: ['Marketing Automation', 'AI-powered Marketing', 'Voice Search Optimization'],
      niceToHaveSkills: ['Analytics', 'Content Creation', 'Video Marketing'],
      videoUrl: 'https://www.youtube.com/results?search_query=digital+marketing+specialist+career',
    ),
    CareerCard(
      title: 'Content Marketing Manager',
      industry: 'Marketing',
      salary: 'R 29,000',
      salaryNumber: 29000,
      totalEmployed: '18,500',
      growthScore: 80,
      growthColor: const Color(0xFF16A34A),
      description: 'Creates and manages content strategies to engage target audiences.',
      skills: ['Content Writing', 'Content Strategy', 'SEO', 'Analytics'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+20% over 10 years',
      entryRequirements: 'Bachelor\'s in Marketing/Communications, portfolio of content',
      coreSkills: ['Content Creation', 'Strategy Development', 'Analytics'],
      emergingSkills: ['Video Content', 'Interactive Content', 'AI Content Tools'],
      niceToHaveSkills: ['Design Skills', 'Video Editing', 'Technical Writing'],
      videoUrl: 'https://www.youtube.com/results?search_query=content+marketing+manager+career',
    ),
    CareerCard(
      title: 'Social Media Manager',
      industry: 'Marketing',
      salary: 'R 25,000',
      salaryNumber: 25000,
      totalEmployed: '24,600',
      growthScore: 82,
      growthColor: const Color(0xFF16A34A),
      description: 'Manages social media presence and engagement for brands and organizations.',
      skills: ['Social Media Marketing', 'Content Creation', 'Analytics', 'Community Management'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+22% over 10 years',
      entryRequirements: 'Bachelor\'s in Marketing/Communications, social media experience',
      coreSkills: ['Platform Management', 'Content Creation', 'Community Engagement'],
      emergingSkills: ['Social Commerce', 'Live Streaming', 'AR/VR Content'],
      niceToHaveSkills: ['Graphic Design', 'Video Production', 'Influencer Relations'],
      videoUrl: 'https://www.youtube.com/results?search_query=social+media+manager+career',
    ),
    CareerCard(
      title: 'Brand Manager',
      industry: 'Marketing',
      salary: 'R 38,000',
      salaryNumber: 38000,
      totalEmployed: '12,400',
      growthScore: 70,
      growthColor: const Color(0xFFEAB308),
      description: 'Develops and maintains brand identity and positioning strategies.',
      skills: ['Brand Management', 'Market Research', 'Strategic Planning', 'Creative Direction'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+12% over 10 years',
      entryRequirements: 'Bachelor\'s in Marketing/Business, brand experience',
      coreSkills: ['Brand Strategy', 'Market Analysis', 'Campaign Development'],
      emergingSkills: ['Purpose-driven Branding', 'Digital Brand Management', 'Brand Analytics'],
      niceToHaveSkills: ['MBA', 'Creative Skills', 'Global Experience'],
      videoUrl: 'https://www.youtube.com/results?search_query=brand+manager+career+guide',
    ),

    // Creative Careers
    CareerCard(
      title: 'Graphic Designer',
      industry: 'Creative',
      salary: 'R 24,000',
      salaryNumber: 24000,
      totalEmployed: '28,900',
      growthScore: 68,
      growthColor: const Color(0xFFEAB308),
      description: 'Creates visual designs for print and digital media.',
      skills: ['Adobe Creative Suite', 'Graphic Design', 'Typography', 'Branding'],
      education: 'Diploma or Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+11% over 10 years',
      entryRequirements: 'Design degree/diploma, portfolio, Adobe software skills',
      coreSkills: ['Visual Design', 'Typography', 'Layout Design'],
      emergingSkills: ['Motion Graphics', 'UI Design', 'AR/VR Design'],
      niceToHaveSkills: ['Web Design', 'Photography', 'Video Editing'],
      videoUrl: 'https://www.youtube.com/results?search_query=graphic+designer+career+overview',
    ),
    CareerCard(
      title: 'Web Designer',
      industry: 'Creative',
      salary: 'R 26,000',
      salaryNumber: 26000,
      totalEmployed: '15,800',
      growthScore: 78,
      growthColor: const Color(0xFF22C55E),
      description: 'Designs and creates websites with focus on user experience and visual appeal.',
      skills: ['Web Design', 'HTML/CSS', 'UX/UI Design', 'Adobe Creative Suite'],
      education: 'Diploma or Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+16% over 10 years',
      entryRequirements: 'Design qualification, web portfolio, coding basics',
      coreSkills: ['Web Design', 'User Experience', 'Visual Design'],
      emergingSkills: ['Responsive Design', 'Progressive Web Apps', 'Voice UI'],
      niceToHaveSkills: ['Front-end Development', 'SEO', 'Analytics'],
      videoUrl: 'https://www.youtube.com/results?search_query=web+designer+career+path',
    ),
    CareerCard(
      title: 'Video Editor',
      industry: 'Creative',
      salary: 'R 23,000',
      salaryNumber: 23000,
      totalEmployed: '12,600',
      growthScore: 83,
      growthColor: const Color(0xFF16A34A),
      description: 'Edits and produces video content for various media platforms.',
      skills: ['Video Editing', 'Adobe Premiere', 'Final Cut Pro', 'Motion Graphics'],
      education: 'Diploma or Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+23% over 10 years',
      entryRequirements: 'Media qualification, video portfolio, editing software skills',
      coreSkills: ['Video Editing', 'Storytelling', 'Color Correction'],
      emergingSkills: ['360° Video', 'Live Streaming', 'AI-assisted Editing'],
      niceToHaveSkills: ['Motion Graphics', 'Sound Design', 'Photography'],
      videoUrl: 'https://www.youtube.com/results?search_query=video+editor+career+guide',
    ),
    CareerCard(
      title: 'Photographer',
      industry: 'Creative',
      salary: 'R 22,000',
      salaryNumber: 22000,
      totalEmployed: '18,400',
      growthScore: 62,
      growthColor: const Color(0xFF3B82F6),
      description: 'Captures and creates photographic images for commercial or artistic purposes.',
      skills: ['Photography', 'Photo Editing', 'Adobe Photoshop', 'Lighting'],
      education: 'Diploma typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+7% over 10 years',
      entryRequirements: 'Photography qualification, portfolio, equipment knowledge',
      coreSkills: ['Photography Techniques', 'Composition', 'Lighting'],
      emergingSkills: ['Drone Photography', '360° Photography', 'Digital Marketing'],
      niceToHaveSkills: ['Video Production', 'Business Skills', 'Specialization'],
      videoUrl: 'https://www.youtube.com/results?search_query=professional+photographer+career',
    ),
    CareerCard(
      title: 'Interior Designer',
      industry: 'Creative',
      salary: 'R 27,000',
      salaryNumber: 27000,
      totalEmployed: '8,900',
      growthScore: 70,
      growthColor: const Color(0xFFEAB308),
      description: 'Plans and designs interior spaces for residential and commercial properties.',
      skills: ['Design Software', 'Space Planning', 'Color Theory', 'Project Management'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+13% over 10 years',
      entryRequirements: 'Interior Design degree, portfolio, design software skills',
      coreSkills: ['Space Planning', 'Design Principles', 'Material Selection'],
      emergingSkills: ['Sustainable Design', 'Smart Home Integration', 'Virtual Reality'],
      niceToHaveSkills: ['Architecture Knowledge', 'Business Skills', 'Sustainability'],
      videoUrl: 'https://www.youtube.com/results?search_query=interior+designer+career+overview',
    ),

    // Trades & Services
    CareerCard(
      title: 'Electrician',
      industry: 'Trades & Services',
      salary: 'R 22,000',
      salaryNumber: 22000,
      totalEmployed: '75,600',
      growthScore: 55,
      growthColor: const Color(0xFF3B82F6),
      description: 'Installs, maintains, and repairs electrical wiring and control systems.',
      skills: ['Electrical Systems', 'Troubleshooting', 'Wiring', 'Blueprint Reading'],
      education: 'Matric and trade qualification required',
      demandLevel: 'Medium',
      projectedGrowth: '+8% over 10 years',
      entryRequirements: 'Trade qualification, apprenticeship, electrical license',
      coreSkills: ['Electrical Installation', 'Safety Procedures', 'Troubleshooting'],
      emergingSkills: ['Solar Installation', 'Smart Home Systems', 'EV Charging'],
      niceToHaveSkills: ['Business Skills', 'Specialized Systems', 'Supervision'],
      videoUrl: 'https://www.youtube.com/results?search_query=electrician+career+trade',
    ),
    CareerCard(
      title: 'Plumber',
      industry: 'Trades & Services',
      salary: 'R 20,000',
      salaryNumber: 20000,
      totalEmployed: '42,800',
      growthScore: 58,
      growthColor: const Color(0xFF3B82F6),
      description: 'Installs and repairs water, sewage, and gas systems in buildings.',
      skills: ['Plumbing', 'Pipe Installation', 'Leak Detection', 'Blueprint Reading'],
      education: 'Matric and trade qualification required',
      demandLevel: 'Medium',
      projectedGrowth: '+9% over 10 years',
      entryRequirements: 'Trade qualification, apprenticeship, plumbing license',
      coreSkills: ['Pipe Installation', 'System Repair', 'Leak Detection'],
      emergingSkills: ['Green Plumbing', 'Smart Water Systems', 'Water Conservation'],
      niceToHaveSkills: ['Gas Fitting', 'Business Skills', 'Emergency Services'],
      videoUrl: 'https://www.youtube.com/results?search_query=plumber+career+trade+guide',
    ),
    CareerCard(
      title: 'Welder',
      industry: 'Trades & Services',
      salary: 'R 19,000',
      salaryNumber: 19000,
      totalEmployed: '38,500',
      growthScore: 52,
      growthColor: const Color(0xFF3B82F6),
      description: 'Joins metal parts together using various welding techniques.',
      skills: ['Welding', 'Metal Work', 'Blueprint Reading', 'Safety Procedures'],
      education: 'Matric and trade qualification required',
      demandLevel: 'Medium',
      projectedGrowth: '+6% over 10 years',
      entryRequirements: 'Trade qualification, welding certification, safety training',
      coreSkills: ['Arc Welding', 'MIG/TIG Welding', 'Metal Fabrication'],
      emergingSkills: ['Automated Welding', 'Underwater Welding', 'Specialized Alloys'],
      niceToHaveSkills: ['Inspection', 'Supervision', 'Multiple Certifications'],
      videoUrl: 'https://www.youtube.com/results?search_query=welder+career+trade+overview',
    ),
    CareerCard(
      title: 'Automotive Technician',
      industry: 'Trades & Services',
      salary: 'R 21,000',
      salaryNumber: 21000,
      totalEmployed: '52,400',
      growthScore: 60,
      growthColor: const Color(0xFF3B82F6),
      description: 'Diagnoses and repairs mechanical and electrical problems in vehicles.',
      skills: ['Automotive Repair', 'Diagnostic Equipment', 'Troubleshooting', 'Mechanical Knowledge'],
      education: 'Matric and trade qualification required',
      demandLevel: 'Medium',
      projectedGrowth: '+10% over 10 years',
      entryRequirements: 'Trade qualification, automotive training, diagnostic skills',
      coreSkills: ['Engine Repair', 'Electrical Systems', 'Diagnostic Testing'],
      emergingSkills: ['Electric Vehicles', 'Hybrid Systems', 'Advanced Electronics'],
      niceToHaveSkills: ['Specialization', 'Customer Service', 'Business Skills'],
      videoUrl: 'https://www.youtube.com/results?search_query=automotive+technician+career',
    ),
    CareerCard(
      title: 'HVAC Technician',
      industry: 'Trades & Services',
      salary: 'R 23,000',
      salaryNumber: 23000,
      totalEmployed: '18,900',
      growthScore: 68,
      growthColor: const Color(0xFFEAB308),
      description: 'Installs, maintains, and repairs heating, ventilation, and air conditioning systems.',
      skills: ['HVAC Systems', 'Refrigeration', 'Electrical Knowledge', 'Troubleshooting'],
      education: 'Matric and trade qualification required',
      demandLevel: 'Medium',
      projectedGrowth: '+13% over 10 years',
      entryRequirements: 'Trade qualification, HVAC training, refrigeration license',
      coreSkills: ['System Installation', 'Maintenance', 'Troubleshooting'],
      emergingSkills: ['Smart HVAC', 'Energy Efficiency', 'Green Technologies'],
      niceToHaveSkills: ['Commercial Systems', 'Controls', 'Business Skills'],
      videoUrl: 'https://www.youtube.com/results?search_query=hvac+technician+career+guide',
    ),

    // Legal Careers
    CareerCard(
      title: 'Lawyer/Attorney',
      industry: 'Legal',
      salary: 'R 45,000',
      salaryNumber: 45000,
      totalEmployed: '28,500',
      growthScore: 67,
      growthColor: const Color(0xFFEAB308),
      description: 'Provides legal advice and representation to clients in various legal matters.',
      skills: ['Legal Research', 'Contract Law', 'Litigation', 'Client Relations'],
      education: 'Law degree and articles required',
      demandLevel: 'Medium',
      projectedGrowth: '+10% over 10 years',
      entryRequirements: 'LLB degree, articles of clerkship, admission to bar',
      coreSkills: ['Legal Research', 'Case Analysis', 'Legal Writing'],
      emergingSkills: ['Legal Technology', 'Alternative Dispute Resolution', 'Compliance'],
      niceToHaveSkills: ['Specialization', 'Business Development', 'Languages'],
      videoUrl: 'https://www.youtube.com/results?search_query=lawyer+attorney+career+path',
    ),
    CareerCard(
      title: 'Paralegal',
      industry: 'Legal',
      salary: 'R 18,000',
      salaryNumber: 18000,
      totalEmployed: '15,800',
      growthScore: 72,
      growthColor: const Color(0xFFEAB308),
      description: 'Assists lawyers with legal research, document preparation, and case management.',
      skills: ['Legal Research', 'Document Preparation', 'Case Management', 'Administrative Skills'],
      education: 'Paralegal qualification required',
      demandLevel: 'Medium',
      projectedGrowth: '+14% over 10 years',
      entryRequirements: 'Paralegal qualification, legal knowledge, computer skills',
      coreSkills: ['Legal Research', 'Document Drafting', 'Case Administration'],
      emergingSkills: ['Legal Technology', 'E-discovery', 'Case Management Software'],
      niceToHaveSkills: ['Specialization', 'Client Interaction', 'Languages'],
      videoUrl: 'https://www.youtube.com/results?search_query=paralegal+career+overview',
    ),
    CareerCard(
      title: 'Legal Secretary',
      industry: 'Legal',
      salary: 'R 16,000',
      salaryNumber: 16000,
      totalEmployed: '22,400',
      growthScore: 58,
      growthColor: const Color(0xFF3B82F6),
      description: 'Provides administrative support to lawyers and legal professionals.',
      skills: ['Administrative Skills', 'Legal Terminology', 'Document Management', 'Communication'],
      education: 'Matric and legal secretary qualification',
      demandLevel: 'Medium',
      projectedGrowth: '+8% over 10 years',
      entryRequirements: 'Legal secretary qualification, office skills, legal knowledge',
      coreSkills: ['Administrative Support', 'Document Management', 'Client Communication'],
      emergingSkills: ['Digital Document Management', 'Virtual Assistance', 'Legal Software'],
      niceToHaveSkills: ['Languages', 'Bookkeeping', 'Event Coordination'],
      videoUrl: 'https://www.youtube.com/results?search_query=legal+secretary+career',
    ),

    // Sciences Careers
    CareerCard(
      title: 'Research Scientist',
      industry: 'Sciences',
      salary: 'R 35,000',
      salaryNumber: 35000,
      totalEmployed: '8,900',
      growthScore: 75,
      growthColor: const Color(0xFF22C55E),
      description: 'Conducts scientific research to advance knowledge in specific fields.',
      skills: ['Research Methods', 'Data Analysis', 'Laboratory Skills', 'Scientific Writing'],
      education: 'Master\'s or PhD typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+15% over 10 years',
      entryRequirements: 'Advanced degree in science, research experience, publications',
      coreSkills: ['Experimental Design', 'Data Analysis', 'Scientific Writing'],
      emergingSkills: ['Interdisciplinary Research', 'Big Data', 'AI in Research'],
      niceToHaveSkills: ['Grant Writing', 'Collaboration', 'Project Management'],
      videoUrl: 'https://www.youtube.com/results?search_query=research+scientist+career+path',
    ),
    CareerCard(
      title: 'Environmental Scientist',
      industry: 'Sciences',
      salary: 'R 28,000',
      salaryNumber: 28000,
      totalEmployed: '5,600',
      growthScore: 78,
      growthColor: const Color(0xFF22C55E),
      description: 'Studies environmental problems and develops solutions for environmental issues.',
      skills: ['Environmental Science', 'Data Analysis', 'Field Work', 'Report Writing'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+17% over 10 years',
      entryRequirements: 'Bachelor\'s in Environmental Science, field experience, analytical skills',
      coreSkills: ['Environmental Assessment', 'Data Collection', 'Analysis'],
      emergingSkills: ['Climate Change Research', 'Renewable Energy', 'Sustainability'],
      niceToHaveSkills: ['GIS', 'Policy Knowledge', 'Project Management'],
      videoUrl: 'https://www.youtube.com/results?search_query=environmental+scientist+career',
    ),
    CareerCard(
      title: 'Food Scientist',
      industry: 'Sciences',
      salary: 'R 31,000',
      salaryNumber: 31000,
      totalEmployed: '3,200',
      growthScore: 70,
      growthColor: const Color(0xFFEAB308),
      description: 'Develops new food products and improves food safety and processing methods.',
      skills: ['Food Science', 'Laboratory Skills', 'Quality Control', 'Product Development'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+12% over 10 years',
      entryRequirements: 'Bachelor\'s in Food Science/Technology, laboratory experience',
      coreSkills: ['Food Chemistry', 'Microbiology', 'Quality Assurance'],
      emergingSkills: ['Functional Foods', 'Sustainable Production', 'Food Tech Innovation'],
      niceToHaveSkills: ['Sensory Analysis', 'Regulatory Knowledge', 'Innovation'],
      videoUrl: 'https://www.youtube.com/results?search_query=food+scientist+career+overview',
    ),

    // Hospitality Careers
    CareerCard(
      title: 'Hotel Manager',
      industry: 'Hospitality',
      salary: 'R 35,000',
      salaryNumber: 35000,
      totalEmployed: '12,800',
      growthScore: 65,
      growthColor: const Color(0xFFEAB308),
      description: 'Oversees hotel operations, staff management, and guest services.',
      skills: ['Hotel Management', 'Customer Service', 'Leadership', 'Operations Management'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+9% over 10 years',
      entryRequirements: 'Hospitality degree, management experience, customer service skills',
      coreSkills: ['Operations Management', 'Staff Leadership', 'Customer Relations'],
      emergingSkills: ['Digital Hospitality', 'Sustainable Tourism', 'Experience Design'],
      niceToHaveSkills: ['Revenue Management', 'Marketing', 'Languages'],
      videoUrl: 'https://www.youtube.com/results?search_query=hotel+manager+career+hospitality',
    ),
    CareerCard(
      title: 'Chef',
      industry: 'Hospitality',
      salary: 'R 26,000',
      salaryNumber: 26000,
      totalEmployed: '35,400',
      growthScore: 62,
      growthColor: const Color(0xFF3B82F6),
      description: 'Plans menus, prepares food, and manages kitchen operations.',
      skills: ['Culinary Skills', 'Menu Planning', 'Kitchen Management', 'Food Safety'],
      education: 'Culinary qualification typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+7% over 10 years',
      entryRequirements: 'Culinary qualification, kitchen experience, food safety certification',
      coreSkills: ['Food Preparation', 'Kitchen Management', 'Menu Development'],
      emergingSkills: ['Plant-based Cuisine', 'Molecular Gastronomy', 'Sustainable Cooking'],
      niceToHaveSkills: ['Business Skills', 'Creativity', 'Leadership'],
      videoUrl: 'https://www.youtube.com/results?search_query=chef+career+culinary+arts',
    ),
    CareerCard(
      title: 'Event Planner',
      industry: 'Hospitality',
      salary: 'R 24,000',
      salaryNumber: 24000,
      totalEmployed: '18,600',
      growthScore: 73,
      growthColor: const Color(0xFF22C55E),
      description: 'Organizes and coordinates events such as weddings, conferences, and parties.',
      skills: ['Event Planning', 'Project Management', 'Vendor Management', 'Budget Management'],
      education: 'Diploma or Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+14% over 10 years',
      entryRequirements: 'Event management qualification, organizational skills, creativity',
      coreSkills: ['Event Coordination', 'Vendor Relations', 'Budget Management'],
      emergingSkills: ['Virtual Events', 'Hybrid Events', 'Experience Technology'],
      niceToHaveSkills: ['Marketing', 'Design', 'Crisis Management'],
      videoUrl: 'https://www.youtube.com/results?search_query=event+planner+career+guide',
    ),

    // Additional careers to reach 50+
    CareerCard(
      title: 'Sales Representative',
      industry: 'Business',
      salary: 'R 25,000',
      salaryNumber: 25000,
      totalEmployed: '125,400',
      growthScore: 68,
      growthColor: const Color(0xFFEAB308),
      description: 'Sells products or services to businesses and consumers.',
      skills: ['Sales', 'Customer Relations', 'Communication', 'Product Knowledge'],
      education: 'Matric typically required',
      demandLevel: 'High',
      projectedGrowth: '+11% over 10 years',
      entryRequirements: 'Sales experience, communication skills, product knowledge',
      coreSkills: ['Sales Techniques', 'Customer Relations', 'Negotiation'],
      emergingSkills: ['Digital Sales', 'CRM Systems', 'Social Selling'],
      niceToHaveSkills: ['Industry Knowledge', 'Leadership', 'Analytics'],
      videoUrl: 'https://www.youtube.com/results?search_query=sales+representative+career',
    ),
    CareerCard(
      title: 'Human Resources Manager',
      industry: 'Business',
      salary: 'R 38,000',
      salaryNumber: 38000,
      totalEmployed: '22,800',
      growthScore: 72,
      growthColor: const Color(0xFFEAB308),
      description: 'Manages employee relations, recruitment, and organizational development.',
      skills: ['HR Management', 'Recruitment', 'Employee Relations', 'Training'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+14% over 10 years',
      entryRequirements: 'Bachelor\'s in HR/Business, HR experience, people skills',
      coreSkills: ['Recruitment', 'Performance Management', 'Policy Development'],
      emergingSkills: ['HR Analytics', 'Remote Work Management', 'AI in HR'],
      niceToHaveSkills: ['Change Management', 'Training', 'Leadership'],
      videoUrl: 'https://www.youtube.com/results?search_query=human+resources+manager+career',
    ),
    CareerCard(
      title: 'Project Manager',
      industry: 'Business',
      salary: 'R 42,000',
      salaryNumber: 42000,
      totalEmployed: '45,600',
      growthScore: 78,
      growthColor: const Color(0xFF22C55E),
      description: 'Plans, executes, and oversees projects from initiation to completion.',
      skills: ['Project Management', 'Leadership', 'Planning', 'Risk Management'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+16% over 10 years',
      entryRequirements: 'Bachelor\'s degree, project experience, PMP certification preferred',
      coreSkills: ['Project Planning', 'Team Leadership', 'Risk Management'],
      emergingSkills: ['Agile Methodologies', 'Digital Project Tools', 'Remote Team Management'],
      niceToHaveSkills: ['Industry Expertise', 'Change Management', 'Business Analysis'],
      videoUrl: 'https://www.youtube.com/results?search_query=project+manager+career+guide',
    ),
    CareerCard(
      title: 'Business Analyst',
      industry: 'Business',
      salary: 'R 36,000',
      salaryNumber: 36000,
      totalEmployed: '28,400',
      growthScore: 80,
      growthColor: const Color(0xFF16A34A),
      description: 'Analyzes business processes and systems to improve organizational efficiency.',
      skills: ['Business Analysis', 'Data Analysis', 'Process Mapping', 'Requirements Gathering'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+18% over 10 years',
      entryRequirements: 'Bachelor\'s in Business/IT, analytical skills, business knowledge',
      coreSkills: ['Requirements Analysis', 'Process Improvement', 'Stakeholder Management'],
      emergingSkills: ['Digital Transformation', 'Data Analytics', 'Automation'],
      niceToHaveSkills: ['Technical Skills', 'Industry Knowledge', 'Change Management'],
      videoUrl: 'https://www.youtube.com/results?search_query=business+analyst+career+path',
    ),
    CareerCard(
      title: 'Supply Chain Manager',
      industry: 'Manufacturing',
      salary: 'R 40,000',
      salaryNumber: 40000,
      totalEmployed: '15,200',
      growthScore: 75,
      growthColor: const Color(0xFF22C55E),
      description: 'Manages the flow of goods and services from suppliers to customers.',
      skills: ['Supply Chain Management', 'Logistics', 'Procurement', 'Analytics'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'High',
      projectedGrowth: '+15% over 10 years',
      entryRequirements: 'Bachelor\'s in Supply Chain/Business, logistics experience',
      coreSkills: ['Procurement', 'Inventory Management', 'Vendor Relations'],
      emergingSkills: ['Supply Chain Analytics', 'Sustainable Sourcing', 'Digital Supply Chain'],
      niceToHaveSkills: ['International Trade', 'Risk Management', 'Technology'],
      videoUrl: 'https://www.youtube.com/results?search_query=supply+chain+manager+career',
    ),
    CareerCard(
      title: 'Quality Assurance Manager',
      industry: 'Manufacturing',
      salary: 'R 38,000',
      salaryNumber: 38000,
      totalEmployed: '18,900',
      growthScore: 68,
      growthColor: const Color(0xFFEAB308),
      description: 'Ensures products and services meet quality standards and regulations.',
      skills: ['Quality Control', 'Process Improvement', 'Statistical Analysis', 'Auditing'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+11% over 10 years',
      entryRequirements: 'Bachelor\'s in Engineering/Science, quality experience, certifications',
      coreSkills: ['Quality Systems', 'Process Control', 'Continuous Improvement'],
      emergingSkills: ['Digital Quality Tools', 'Predictive Quality', 'Automated Testing'],
      niceToHaveSkills: ['Six Sigma', 'ISO Standards', 'Leadership'],
      videoUrl: 'https://www.youtube.com/results?search_query=quality+assurance+manager+career',
    ),
    CareerCard(
      title: 'Construction Manager',
      industry: 'Construction',
      salary: 'R 45,000',
      salaryNumber: 45000,
      totalEmployed: '22,600',
      growthScore: 70,
      growthColor: const Color(0xFFEAB308),
      description: 'Oversees construction projects from planning to completion.',
      skills: ['Construction Management', 'Project Planning', 'Safety Management', 'Cost Control'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+12% over 10 years',
      entryRequirements: 'Bachelor\'s in Construction Management/Engineering, project experience',
      coreSkills: ['Project Management', 'Cost Estimation', 'Safety Compliance'],
      emergingSkills: ['Green Building', 'Construction Technology', 'Modular Construction'],
      niceToHaveSkills: ['PMP Certification', 'Contracts', 'Leadership'],
      videoUrl: 'https://www.youtube.com/results?search_query=construction+manager+career',
    ),
    CareerCard(
      title: 'Retail Manager',
      industry: 'Retail',
      salary: 'R 28,000',
      salaryNumber: 28000,
      totalEmployed: '85,400',
      growthScore: 58,
      growthColor: const Color(0xFF3B82F6),
      description: 'Manages retail store operations, staff, and customer service.',
      skills: ['Retail Management', 'Customer Service', 'Inventory Management', 'Sales'],
      education: 'Matric typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+8% over 10 years',
      entryRequirements: 'Retail experience, management skills, customer service focus',
      coreSkills: ['Store Operations', 'Staff Management', 'Customer Relations'],
      emergingSkills: ['Omnichannel Retail', 'Digital Integration', 'Data Analytics'],
      niceToHaveSkills: ['Visual Merchandising', 'Loss Prevention', 'Training'],
      videoUrl: 'https://www.youtube.com/results?search_query=retail+manager+career+guide',
    ),
    CareerCard(
      title: 'Transportation Manager',
      industry: 'Transportation',
      salary: 'R 35,000',
      salaryNumber: 35000,
      totalEmployed: '12,800',
      growthScore: 65,
      growthColor: const Color(0xFFEAB308),
      description: 'Coordinates and manages transportation operations and logistics.',
      skills: ['Logistics', 'Transportation Planning', 'Fleet Management', 'Cost Control'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+9% over 10 years',
      entryRequirements: 'Bachelor\'s in Logistics/Business, transportation experience',
      coreSkills: ['Route Planning', 'Fleet Management', 'Cost Optimization'],
      emergingSkills: ['Smart Logistics', 'Electric Vehicles', 'Autonomous Transportation'],
      niceToHaveSkills: ['Regulatory Knowledge', 'Technology', 'Safety Management'],
      videoUrl: 'https://www.youtube.com/results?search_query=transportation+manager+career',
    ),
    CareerCard(
      title: 'Agricultural Manager',
      industry: 'Agriculture',
      salary: 'R 32,000',
      salaryNumber: 32000,
      totalEmployed: '18,500',
      growthScore: 62,
      growthColor: const Color(0xFF3B82F6),
      description: 'Manages farm operations, crop production, and agricultural business activities.',
      skills: ['Farm Management', 'Crop Science', 'Business Management', 'Equipment Operation'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+7% over 10 years',
      entryRequirements: 'Bachelor\'s in Agriculture/Agribusiness, farming experience',
      coreSkills: ['Crop Management', 'Livestock Care', 'Business Planning'],
      emergingSkills: ['Precision Agriculture', 'Sustainable Farming', 'AgTech'],
      niceToHaveSkills: ['Marketing', 'Finance', 'Environmental Knowledge'],
      videoUrl: 'https://www.youtube.com/results?search_query=agricultural+manager+career',
    ),
    CareerCard(
      title: 'Government Administrator',
      industry: 'Government',
      salary: 'R 30,000',
      salaryNumber: 30000,
      totalEmployed: '165,800',
      growthScore: 55,
      growthColor: const Color(0xFF3B82F6),
      description: 'Manages public sector operations and implements government policies.',
      skills: ['Public Administration', 'Policy Analysis', 'Project Management', 'Communication'],
      education: 'Bachelor\'s degree typically required',
      demandLevel: 'Medium',
      projectedGrowth: '+6% over 10 years',
      entryRequirements: 'Bachelor\'s in Public Administration/Political Science, government experience',
      coreSkills: ['Policy Implementation', 'Public Service', 'Administrative Management'],
      emergingSkills: ['Digital Government', 'Data Analytics', 'Citizen Engagement'],
      niceToHaveSkills: ['Law Knowledge', 'Leadership', 'Languages'],
      videoUrl: 'https://www.youtube.com/results?search_query=government+administrator+career',
    ),
  ];

  List<CareerCard> get filteredCareers {
    if (!_isDataLoaded) return careers;
    
    // Use real job data to create career cards
    List<JobListing> filteredJobs = _filteredJobs;
    
    // Apply additional filters
    filteredJobs = filteredJobs.where((job) {
      // Industry filter
      bool matchesIndustry = selectedIndustry == 'All Industries' || 
                            job.industry == selectedIndustry;
      
      // Salary filter
      bool matchesSalary = job.averageSalary <= salaryRange;
      
      // Search filter
      bool matchesSearch = searchQuery.isEmpty || 
                          job.jobTitle.toLowerCase().contains(searchQuery.toLowerCase()) ||
                          job.company.toLowerCase().contains(searchQuery.toLowerCase()) ||
                          job.industry.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesIndustry && matchesSalary && matchesSearch;
    }).toList();
    
    // Convert JobListing to CareerCard
    return filteredJobs.map((job) {
      final marketDemand = MarketDataService.getMarketDemand(job.jobTitle);
      final insights = MarketDataService.getCareerInsights(job.jobTitle);
      
      return CareerCard(
        title: job.jobTitle,
        industry: job.industry,
        salary: job.salary,
        salaryNumber: job.averageSalary.toInt(),
        growthScore: ((marketDemand?.weightedAverage ?? 0.5) * 100).toInt(),
        growthColor: _getDemandColor(marketDemand?.weightedAverage ?? 0.5),
        totalEmployed: insights['jobCount'].toString(),
        education: _getEducationLevel(job.positionType),
        description: 'Real job opportunity at ${job.company} in ${job.location}',
        skills: insights['topSkills'] ?? ['Communication', 'Problem Solving'],
        demandLevel: marketDemand?.demandLevel ?? 'Medium Demand',
        projectedGrowth: marketDemand?.growthProjection ?? '+8% over 10 years',
        entryRequirements: _getEducationLevel(job.positionType),
        coreSkills: insights['topSkills'] ?? ['Communication', 'Problem Solving'],
        emergingSkills: ['Digital Skills', 'Adaptability', 'Critical Thinking'],
        niceToHaveSkills: ['Leadership', 'Teamwork', 'Adaptability'],
        videoUrl: 'https://www.youtube.com/results?search_query=${job.jobTitle.replaceAll(' ', '+')}+career',
      );
    }).toList();
  }
  
  String _getEducationLevel(String positionType) {
    final typeLower = positionType.toLowerCase();
    if (typeLower.contains('junior')) return 'Matric';
    if (typeLower.contains('senior') || typeLower.contains('management')) return 'Bachelor\'s';
    if (typeLower.contains('specialist') || typeLower.contains('executive')) return 'Master\'s';
    return 'Diploma';
  }
  
  Color _getDemandColor(double weightedAverage) {
    if (weightedAverage >= 0.6) return const Color(0xFF10B981); // Green
    if (weightedAverage >= 0.4) return const Color(0xFFF59E0B); // Yellow
    return const Color(0xFFEF4444); // Red
  }

  List<CareerCard> get sortedCareers {
    List<CareerCard> filtered = filteredCareers;
    
    switch (sortBy) {
      case 'Salary (High to Low)':
        filtered.sort((a, b) => b.salaryNumber.compareTo(a.salaryNumber));
        break;
      case 'Salary (Low to High)':
        filtered.sort((a, b) => a.salaryNumber.compareTo(b.salaryNumber));
        break;
      case 'Growth Score':
        filtered.sort((a, b) => b.growthScore.compareTo(a.growthScore));
        break;
      case 'Popularity':
      default:
        filtered.sort((a, b) => int.parse(b.totalEmployed.replaceAll(',', ''))
                               .compareTo(int.parse(a.totalEmployed.replaceAll(',', ''))));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: const GuideianAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Scrollable Header Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Career Insights Dashboard',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3328BF),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comprehensive data and visualizations on South Africa\'s job market and career opportunities.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            // Scrollable Tab Navigation
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = selectedTab == tab;
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = tab),
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF3328BF) : const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getTabIcon(tab),
                              size: 16,
                              color: isSelected ? Colors.white : const Color(0xFF374151),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tab,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.white : const Color(0xFF374151),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            // Main Content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 100), // Extra bottom padding for bottom nav
              child: selectedTab == 'National Overview' 
                ? _buildNationalOverviewContent()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Panel - Filters
                      _buildFiltersPanel(),
                      
                      const SizedBox(width: 32),
                      
                      // Right Panel - Career Cards
                      Expanded(
                        child: _buildCareerCardsPanel(),
                      ),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTabIcon(String tab) {
    switch (tab) {
      case 'National Overview':
        return Icons.bar_chart;
      case 'Career Explorer':
        return Icons.explore;
      default:
        return Icons.info;
    }
  }

  Widget _buildFiltersPanel() {
    return Container(
      width: 400,
      height: 800,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Fixed header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Text(
              'Filter Careers',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF3328BF),
                height: 1.2,
              ),
            ),
          ),
          
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Industry Filter
                  _buildFilterSection(
                    title: 'Industry / Sector',
                    child: _buildDropdown(
                      value: selectedIndustry,
                      items: industries,
                      onChanged: (value) => setState(() => selectedIndustry = value!),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Salary Range Filter
                  _buildFilterSection(
                    title: 'Monthly Salary Range',
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'R0 - R${salaryRange.toInt().toString()}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF6B7280),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Slider(
                          value: salaryRange,
                          min: 0,
                          max: 60000,
                          divisions: 12,
                          activeColor: const Color(0xFF3328BF),
                          inactiveColor: const Color(0xFFE5E7EB),
                          onChanged: (value) => setState(() => salaryRange = value),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'R0',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF6B7280),
                                height: 1.2,
                              ),
                            ),
                            Text(
                              'R30k',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF6B7280),
                                height: 1.2,
                              ),
                            ),
                            Text(
                              'R60k',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF6B7280),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Skills Filter
                  _buildFilterSection(
                    title: 'Required Skills',
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                // Filter skills based on search
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search skills...',
                              hintStyle: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF9CA3AF),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: skills.length,
                            itemBuilder: (context, index) {
                              final skill = skills[index];
                              final isSelected = selectedSkills.contains(skill);
                              return CheckboxListTile(
                                title: Text(
                                  skill,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF374151),
                                  ),
                                ),
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedSkills.add(skill);
                                    } else {
                                      selectedSkills.remove(skill);
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Education Level Filter
                  _buildFilterSection(
                    title: 'Education Level',
                    child: _buildDropdown(
                      value: selectedEducation,
                      items: educationLevels,
                      onChanged: (value) => setState(() => selectedEducation = value!),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Future Growth Score Filter
                  _buildFilterSection(
                    title: 'Future Growth Score',
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Min: ${growthScore.toInt()}%',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF6B7280),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Slider(
                          value: growthScore,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          activeColor: const Color(0xFF3328BF),
                          inactiveColor: const Color(0xFFE5E7EB),
                          onChanged: (value) => setState(() => growthScore = value),
                        ),
                        Row(
                          children: [
                            _buildGrowthIndicator('Limited', const Color(0xFF3B82F6)),
                            const SizedBox(width: 4),
                            _buildGrowthIndicator('Moderate', const Color(0xFFEAB308)),
                            const SizedBox(width: 4),
                            _buildGrowthIndicator('Strong', const Color(0xFF22C55E)),
                            const SizedBox(width: 4),
                            _buildGrowthIndicator('Excellent', const Color(0xFF16A34A)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Reset Filters Button
                  Container(
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF3328BF)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedIndustry = 'All Industries';
                          selectedEducation = 'All Levels';
                          salaryRange = 45000;
                          growthScore = 0;
                          selectedSkills.clear();
                          searchQuery = '';
                        });
                      },
                      child: Text(
                        'Reset Filters',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF3328BF),
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF374151),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280), size: 20),
        ),
      ),
    );
  }

  Widget _buildGrowthIndicator(String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildNationalOverviewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // South Africa National Overview Title
        Text(
          'South Africa National Overview',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1F2937),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 32),

        // Key Statistics Cards
        _buildKeyStatisticsCards(),
        const SizedBox(height: 32),

        // Interactive Provincial Map Section
        _buildProvincialMapSection(),
        const SizedBox(height: 32),

        // Charts Section
        _buildChartsSection(),
        const SizedBox(height: 32),

        // Student Insights Section
        _buildStudentInsightsSection(),
        const SizedBox(height: 32),

        // Most In-Demand Skills Section
        _buildInDemandSkillsSection(),
      ],
    );
  }

  Widget _buildKeyStatisticsCards() {
    if (!_isDataLoaded) {
      return _buildLoadingCards();
    }
    
    final totalJobs = _filteredJobs.length;
    final avgSalary = _filteredJobs.isNotEmpty 
        ? _filteredJobs.map((job) => job.averageSalary).reduce((a, b) => a + b) / _filteredJobs.length
        : 0.0;
    final topDemandCount = _topDemandCareers.length;
    
    return Column(
      children: [
        // First row - 2 cards
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Active Job Opportunities',
                value: totalJobs.toString(),
                unit: ' positions',
                change: 'Live market data',
                changeColor: const Color(0xFF10B981),
                source: 'Real job listings from South African market',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                title: 'Average Salary Range',
                value: 'R${avgSalary.toStringAsFixed(0)}',
                unit: '/month',
                status: 'Market Rate',
                statusColor: const Color(0xFF10B981),
                source: 'Based on current job postings',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Second row - 2 cards
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'High Demand Careers',
                value: topDemandCount.toString(),
                unit: ' categories',
                status: 'Growing',
                statusColor: const Color(0xFF10B981),
                source: 'National demand analysis 2024',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                title: 'Unemployment Rate',
                value: _laborMarketTrends['latestUnemploymentRate'] != null 
                  ? '${(_laborMarketTrends['latestUnemploymentRate'] as double).toStringAsFixed(1)}%'
                  : '32.1%',
                unit: ' national',
                status: _laborMarketTrends['trendDirection'] ?? 'Stable',
                statusColor: _laborMarketTrends['trend'] != null && (_laborMarketTrends['trend'] as double) < 0 
                    ? const Color(0xFF10B981) 
                    : const Color(0xFFEF4444),
                source: 'Stats SA QLFS 2024',
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildLoadingCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatCard(
              title: 'Loading...',
              value: '...',
              unit: '',
              source: 'Loading market data...',
            )),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(
              title: 'Loading...',
              value: '...',
              unit: '',
              source: 'Loading market data...',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatCard(
              title: 'Loading...',
              value: '...',
              unit: '',
              source: 'Loading market data...',
            )),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(
              title: 'Loading...',
              value: '...',
              unit: '',
              source: 'Loading market data...',
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String unit,
    String? change,
    Color? changeColor,
    String? status,
    Color? statusColor,
    required String source,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              Text(
                unit,
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(width: 12),
              if (change != null) ...[
                Icon(
                  Icons.trending_up,
                  color: changeColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  change,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: changeColor,
                    height: 1.2,
                  ),
                ),
              ] else if (status != null) ...[
                Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: statusColor,
                    height: 1.2,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Text(
            source,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9CA3AF),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvincialMapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Provincial Job Market Overview',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1F2937),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Explore employment distribution and key industries across South Africa\'s provinces.',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Interactive Map Placeholder\n(Job distribution by province)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Market Trend Analysis',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1F2937),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Visual data on job growth, salary trends, and market demand.',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildChartPlaceholder('Job Growth by Industry', 'Bar Chart Placeholder'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildChartPlaceholder('Average Salary by Sector', 'Line Chart Placeholder'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartPlaceholder(String title, String placeholderText) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Text(
                placeholderText,
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color(0xFF9CA3AF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInsightsSection() {
    if (!_isDataLoaded || _studentInsights.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text('Loading student insights...'),
        ),
      );
    }

    final totalStudents = _studentInsights['totalStudents'] as int? ?? 0;
    final averageMarks = _studentInsights['averageMarks'] as Map<String, dynamic>? ?? {};
    final topInterests = _studentInsights['topInterests'] as List<dynamic>? ?? [];
    final topCareerGoals = _studentInsights['topCareerGoals'] as List<dynamic>? ?? [];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.school,
                  color: Color(0xFF3B82F6),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Insights & Education Pathways',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      'Based on ${totalStudents.toString()} student profiles',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Academic Performance Overview
          Row(
            children: [
              Expanded(
                child: _buildStudentStatCard(
                  'Average Math',
                  '${(averageMarks['math'] as double? ?? 0.0).toStringAsFixed(1)}%',
                  Icons.calculate,
                  const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStudentStatCard(
                  'Average English',
                  '${(averageMarks['english'] as double? ?? 0.0).toStringAsFixed(1)}%',
                  Icons.language,
                  const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStudentStatCard(
                  'Average Science',
                  '${(averageMarks['science'] as double? ?? 0.0).toStringAsFixed(1)}%',
                  Icons.science,
                  const Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Top Interests and Career Goals
          Row(
            children: [
              Expanded(
                child: _buildTopListCard(
                  'Top Interests',
                  topInterests,
                  Icons.favorite,
                  const Color(0xFFEF4444),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTopListCard(
                  'Career Goals',
                  topCareerGoals,
                  Icons.work,
                  const Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStudentStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTopListCard(String title, List<dynamic> items, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.take(3).map((item) {
            final itemData = item as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      itemData['name'] as String? ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  Text(
                    '${itemData['percentage'] as String? ?? '0'}%',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInDemandSkillsSection() {
    List<SkillData> inDemandSkills;
    
    if (!_isDataLoaded) {
      inDemandSkills = [
        SkillData(name: 'Loading...', count: 0, color: const Color(0xFF9CA3AF)),
      ];
    } else {
      // Extract skills from real job data
      final skillCounts = <String, int>{};
      for (final job in _filteredJobs) {
        final insights = MarketDataService.getCareerInsights(job.jobTitle);
        final skills = insights['topSkills'] as List<String>? ?? [];
        for (final skill in skills) {
          skillCounts[skill] = (skillCounts[skill] ?? 0) + 1;
        }
      }
      
      // Sort by count and take top 5
      final sortedSkills = skillCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      
      final colors = [
        const Color(0xFF3328BF),
        const Color(0xFFEAB308),
        const Color(0xFF16A34A),
        const Color(0xFFDC2626),
        const Color(0xFF3B82F6),
      ];
      
      inDemandSkills = sortedSkills.take(5).toList().asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        return SkillData(
          name: skill.key,
          count: skill.value,
          color: colors[index % colors.length],
        );
      }).toList();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most In-Demand Skills',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1F2937),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Top skills currently most sought after by employers in South Africa.',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: inDemandSkills.map((skill) => _buildSkillBar(skill)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillBar(SkillData skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              skill.name,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: skill.count / 15000,
                backgroundColor: const Color(0xFFF3F4F6),
                color: skill.color,
                minHeight: 12,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '${skill.count}',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerCardsPanel() {
    final displayCareers = sortedCareers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search & Sort Bar
        _buildSearchAndSortBar(),
        const SizedBox(height: 24),
        
        // Career Cards Grid
        if (displayCareers.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.0,
            ),
            itemCount: displayCareers.length,
            itemBuilder: (context, index) {
              final career = displayCareers[index];
              return _buildCareerCard(career);
            },
          )
        else
          Container(
            padding: const EdgeInsets.all(40),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 48, color: Color(0xFF9CA3AF)),
                const SizedBox(height: 16),
                Text(
                  'No careers found',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4B5563),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your filters or search query.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSearchAndSortBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() => searchQuery = value);
                _filterJobs();
              },
              decoration: InputDecoration(
                hintText: 'Search for a career...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF9CA3AF),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Sort Dropdown - Now Functional
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: sortBy,
              items: ['Popularity', 'Salary (High to Low)', 'Salary (Low to High)', 'Growth Score'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF374151),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  sortBy = value!;
                });
              },
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF374151),
              ),
              icon: const Icon(Icons.sort, color: Color(0xFF9CA3AF)),
            ),
          ),
        ),
      ],
    );
  }


  Color _getDemandColorFromLevel(String demandLevel) {
    switch (demandLevel.toLowerCase()) {
      case 'high demand':
        return const Color(0xFF16A34A); // Green
      case 'medium demand':
        return const Color(0xFFEAB308); // Yellow
      case 'low demand':
        return const Color(0xFF3B82F6); // Blue
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }

  Widget _buildCareerCard(CareerCard career) {
    return GestureDetector(
      onTap: () {
        context.go(
          '/career-detail',
          extra: {
            'careerTitle': career.title,
            'salary': career.salary,
            'totalEmployed': career.totalEmployed,
            'growthScore': career.growthScore.toString(),
            'description': career.description,
            'skills': career.skills,
            'education': career.education,
            'demandLevel': career.demandLevel,
            'projectedGrowth': career.projectedGrowth,
            'entryRequirements': career.entryRequirements,
            'coreSkills': career.coreSkills,
            'emergingSkills': career.emergingSkills,
            'niceToHaveSkills': career.niceToHaveSkills,
            'videoUrl': career.videoUrl,
            'industry': career.industry,
          },
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.work_outline, color: Color(0xFF3328BF), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          career.title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F2937),
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${career.salary} p/m',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF16A34A),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Demand Level and Growth Rate
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getDemandColorFromLevel(career.demandLevel).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${career.demandLevel} Demand',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: _getDemandColorFromLevel(career.demandLevel),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.trending_up, color: career.growthColor, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    '${career.growthScore}%',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: career.growthColor,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Projected Growth
              Text(
                'Projected: ${career.projectedGrowth}',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Entry Requirements
              Text(
                career.entryRequirements,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF4B5563),
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 12),
              
              // Core Skills Preview
              if (career.coreSkills.isNotEmpty) ...[
                Text(
                  'Core Skills:',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: career.coreSkills.take(3).map((skill) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3328BF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      skill,
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF3328BF),
                      ),
                    ),
                  )).toList(),
                ),
              ],
              
              const Spacer(),
              
              // Video Link Button
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(career.videoUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_circle_outline, size: 16, color: Color(0xFF6B7280)),
                      const SizedBox(width: 4),
                      Text(
                        'Watch Career Video',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class CareerCard {
  final String title;
  final String industry;
  final String salary;
  final int salaryNumber;
  final String totalEmployed;
  final int growthScore;
  final Color growthColor;
  final String description;
  final List<String> skills;
  final String education;
  final String demandLevel;
  final String projectedGrowth;
  final String entryRequirements;
  final List<String> coreSkills;
  final List<String> emergingSkills;
  final List<String> niceToHaveSkills;
  final String videoUrl;

  CareerCard({
    required this.title,
    required this.industry,
    required this.salary,
    required this.salaryNumber,
    required this.totalEmployed,
    required this.growthScore,
    required this.growthColor,
    required this.description,
    required this.skills,
    required this.education,
    required this.demandLevel,
    required this.projectedGrowth,
    required this.entryRequirements,
    required this.coreSkills,
    required this.emergingSkills,
    required this.niceToHaveSkills,
    required this.videoUrl,
  });
}

class SkillData {
  final String name;
  final int count;
  final Color color;

  SkillData({
    required this.name,
    required this.count,
    required this.color,
  });
}

// Custom painter for the Guideian logo
class GuideianLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw the curved paths from the SVG
    final path1 = Path()
      ..moveTo(55.0, 1.0)
      ..lineTo(25.0, 1.0)
      ..quadraticBezierTo(0.5, 1.0, 1.0, 28.0)
      ..quadraticBezierTo(1.5, 53.0, 25.0, 53.0)
      ..lineTo(54.0, 53.0)
      ..lineTo(54.0, 28.0);

    final path2 = Path()
      ..moveTo(55.0, 5.0)
      ..lineTo(26.5, 5.0)
      ..quadraticBezierTo(5.0, 5.0, 5.0, 28.0)
      ..quadraticBezierTo(5.0, 49.0, 27.0, 49.0)
      ..lineTo(50.0, 49.0)
      ..lineTo(50.0, 28.0);

    final path3 = Path()
      ..moveTo(55.0, 9.0)
      ..lineTo(25.9, 9.0)
      ..quadraticBezierTo(9.0, 9.0, 9.0, 28.0)
      ..quadraticBezierTo(9.0, 45.5, 26.0, 45.5)
      ..lineTo(46.0, 45.5)
      ..lineTo(46.0, 28.0);

    final path4 = Path()
      ..moveTo(55.0, 13.0)
      ..lineTo(26.3, 13.0)
      ..quadraticBezierTo(13.0, 13.0, 13.0, 27.5)
      ..quadraticBezierTo(13.0, 41.5, 26.5, 41.5)
      ..lineTo(42.0, 41.5)
      ..lineTo(42.0, 28.0);

    final path5 = Path()
      ..moveTo(55.0, 17.0)
      ..lineTo(28.1, 17.0)
      ..quadraticBezierTo(16.5, 17.0, 17.0, 28.0)
      ..quadraticBezierTo(17.5, 37.5, 28.1, 37.5)
      ..lineTo(38.0, 37.5)
      ..lineTo(38.0, 28.0);

    final path6 = Path()
      ..moveTo(55.0, 21.0)
      ..lineTo(27.2, 21.0)
      ..quadraticBezierTo(21.0, 21.0, 21.0, 27.2)
      ..quadraticBezierTo(21.0, 34.0, 27.2, 34.0)
      ..lineTo(34.0, 34.0)
      ..lineTo(34.0, 28.0);

    // Draw all paths
    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
    canvas.drawPath(path3, paint);
    canvas.drawPath(path4, paint);
    canvas.drawPath(path5, paint);
    canvas.drawPath(path6, paint);

    // Draw the text
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Guideian',
        style: GoogleFonts.tenorSans(
          fontSize: 26,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, const Offset(63, 10));

    final subTextPainter = TextPainter(
      text: TextSpan(
        text: 'Future Ready',
        style: GoogleFonts.tenorSans(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    subTextPainter.paint(canvas, const Offset(64, 35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}