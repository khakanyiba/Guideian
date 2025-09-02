import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_finder_provider.dart';
import '../utils/app_theme.dart';

class CourseFinderScreen extends StatefulWidget {
  const CourseFinderScreen({super.key});

  @override
  State<CourseFinderScreen> createState() => _CourseFinderScreenState();
}

class _CourseFinderScreenState extends State<CourseFinderScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Finder'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<CourseFinderProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Search and Filter Section
              Container(
                padding: const EdgeInsets.all(16),
                color: AppTheme.primaryColor.withOpacity(0.1),
                child: Column(
                  children: [
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search courses...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            provider.clearSearch();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        provider.setSearchQuery(value);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Filter Button
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _showFilterDialog(context, provider),
                            icon: const Icon(Icons.filter_list),
                            label: const Text('Filters'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: AppTheme.primaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () =>
                              _showPreferencesDialog(context, provider),
                          icon: const Icon(Icons.tune),
                          label: const Text('Preferences'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Results Section
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.courses.isEmpty
                        ? _buildEmptyState()
                        : _buildResultsList(provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No courses found',
            style: AppTheme.textTheme.headlineSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: AppTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _showPreferencesDialog(context, null),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Set Preferences'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(CourseFinderProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.courses.length,
      itemBuilder: (context, index) {
        final course = provider.courses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _showCourseDetails(context, course),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          course.name,
                          style: AppTheme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${course.matchScore.round()}%',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.institution,
                    style: AppTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        course.location,
                        style: AppTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.attach_money,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        _getAffordabilityText(course.affordability),
                        style: AppTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.school, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Min Marks: ${course.minMarks}%',
                        style: AppTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.trending_up,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        _getDemandText(course.demand),
                        style: AppTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: course.interests.take(3).map((interest) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          interest,
                          style: AppTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context, CourseFinderProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Courses'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Location Filter
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                initialValue: provider.selectedLocation.isEmpty
                    ? null
                    : provider.selectedLocation,
                items: [
                  const DropdownMenuItem(
                      value: '', child: Text('All Locations')),
                  ...provider.availableLocations.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    );
                  }),
                ],
                onChanged: (value) {
                  provider.setLocationFilter(value ?? '');
                },
              ),
              const SizedBox(height: 16),

              // Affordability Filter
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Affordability',
                  border: OutlineInputBorder(),
                ),
                initialValue: provider.selectedAffordability.isEmpty
                    ? null
                    : provider.selectedAffordability,
                items: [
                  const DropdownMenuItem(
                      value: '', child: Text('All Price Ranges')),
                  const DropdownMenuItem(value: 'Low', child: Text('Low Cost')),
                  const DropdownMenuItem(
                      value: 'Medium', child: Text('Medium Cost')),
                  const DropdownMenuItem(
                      value: 'High', child: Text('High Cost')),
                ],
                onChanged: (value) {
                  provider.setAffordabilityFilter(value ?? '');
                },
              ),
              const SizedBox(height: 16),

              // Demand Filter
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Demand Level',
                  border: OutlineInputBorder(),
                ),
                initialValue: provider.selectedDemand.isEmpty
                    ? null
                    : provider.selectedDemand,
                items: [
                  const DropdownMenuItem(
                      value: '', child: Text('All Demand Levels')),
                  const DropdownMenuItem(
                      value: 'High', child: Text('High Demand')),
                  const DropdownMenuItem(
                      value: 'Medium', child: Text('Medium Demand')),
                  const DropdownMenuItem(
                      value: 'Low', child: Text('Low Demand')),
                ],
                onChanged: (value) {
                  provider.setDemandFilter(value ?? '');
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.clearFilters();
              Navigator.of(context).pop();
            },
            child: const Text('Clear All'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              provider.applyFilters();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showPreferencesDialog(
      BuildContext context, CourseFinderProvider? provider) {
    final tempProvider = provider ?? CourseFinderProvider();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Your Preferences'),
        content: SizedBox(
          width: double.maxFinite,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Average Marks
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Average Marks (%)',
                    border: OutlineInputBorder(),
                    hintText: 'e.g., 75',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your average marks';
                    }
                    final marks = double.tryParse(value);
                    if (marks == null || marks < 0 || marks > 100) {
                      return 'Please enter a valid percentage (0-100)';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    final marks = double.tryParse(value);
                    if (marks != null) {
                      tempProvider.setAverageMarks(marks);
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Interests
                const Text('Your Interests (select all that apply):'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Technology',
                    'Business',
                    'Medicine',
                    'Engineering',
                    'Arts',
                    'Science',
                    'Education',
                    'Law',
                    'Agriculture',
                    'Environment',
                    'Finance',
                    'Marketing',
                    'Psychology',
                    'Sociology',
                    'History',
                    'Geography',
                    'Languages',
                    'Sports',
                    'Music',
                    'Design',
                    'Architecture'
                  ].map((interest) {
                    final isSelected =
                        tempProvider.selectedInterests.contains(interest);
                    return FilterChip(
                      label: Text(interest),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          tempProvider.addInterest(interest);
                        } else {
                          tempProvider.removeInterest(interest);
                        }
                      },
                      selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                      checkmarkColor: AppTheme.primaryColor,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Location Preference
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Preferred Location',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: tempProvider.preferredLocation.isEmpty
                      ? null
                      : tempProvider.preferredLocation,
                  items: [
                    const DropdownMenuItem(
                        value: '', child: Text('Any Location')),
                    ...tempProvider.availableLocations.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    tempProvider.setPreferredLocation(value ?? '');
                  },
                ),
                const SizedBox(height: 16),

                // Affordability Preference
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Affordability Preference',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: tempProvider.preferredAffordability.isEmpty
                      ? null
                      : tempProvider.preferredAffordability,
                  items: [
                    const DropdownMenuItem(
                        value: '', child: Text('Any Price Range')),
                    const DropdownMenuItem(
                        value: 'Low', child: Text('Low Cost')),
                    const DropdownMenuItem(
                        value: 'Medium', child: Text('Medium Cost')),
                    const DropdownMenuItem(
                        value: 'High', child: Text('High Cost')),
                  ],
                  onChanged: (value) {
                    tempProvider.setPreferredAffordability(value ?? '');
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (provider != null) {
                  provider.findCourses();
                }
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Find Courses'),
          ),
        ],
      ),
    );
  }

  void _showCourseDetails(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(course.name),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  course.institution,
                  style: AppTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow('Location', course.location, Icons.location_on),
                _buildDetailRow(
                    'Min Marks', '${course.minMarks}%', Icons.school),
                _buildDetailRow(
                    'Affordability',
                    _getAffordabilityText(course.affordability),
                    Icons.attach_money),
                _buildDetailRow(
                    'Demand', _getDemandText(course.demand), Icons.trending_up),
                _buildDetailRow(
                    'Match Score', '${course.matchScore.round()}%', Icons.star),
                const SizedBox(height: 16),
                Text(
                  'Related Interests:',
                  style: AppTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: course.interests.map((interest) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        interest,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement application functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Application feature coming soon!')),
              );
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Apply Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: AppTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: AppTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  String _getAffordabilityText(String affordability) {
    switch (affordability.toLowerCase()) {
      case 'low':
        return 'Low Cost';
      case 'medium':
        return 'Medium Cost';
      case 'high':
        return 'High Cost';
      default:
        return affordability;
    }
  }

  String _getDemandText(String demand) {
    switch (demand.toLowerCase()) {
      case 'high':
        return 'High Demand';
      case 'medium':
        return 'Medium Demand';
      case 'low':
        return 'Low Demand';
      default:
        return demand;
    }
  }
}
