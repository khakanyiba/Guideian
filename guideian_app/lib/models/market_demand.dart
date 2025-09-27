class MarketDemand {
  final String ofoCode;
  final String ofoTitle;
  final double secondaryData;
  final double mentionsFrequency;
  final double averageCertainty;
  final double weightedAverage;

  MarketDemand({
    required this.ofoCode,
    required this.ofoTitle,
    required this.secondaryData,
    required this.mentionsFrequency,
    required this.averageCertainty,
    required this.weightedAverage,
  });

  factory MarketDemand.fromCsv(Map<String, dynamic> csvData) {
    return MarketDemand(
      ofoCode: csvData['OFO_CODE'] ?? '',
      ofoTitle: csvData['OFO_TITLE'] ?? '',
      secondaryData: double.tryParse(csvData['SECONDARY_DATA']?.toString() ?? '0') ?? 0.0,
      mentionsFrequency: double.tryParse(csvData['MENTIONS_FREQUENCY']?.toString() ?? '0') ?? 0.0,
      averageCertainty: double.tryParse(csvData['AVERAGE_CERTAINTY']?.toString() ?? '0') ?? 0.0,
      weightedAverage: double.tryParse(csvData['WEIGHTED_AVERAGE']?.toString() ?? '0') ?? 0.0,
    );
  }

  // Get demand level based on weighted average
  String get demandLevel {
    if (weightedAverage >= 0.6) return 'High Demand';
    if (weightedAverage >= 0.4) return 'Medium Demand';
    return 'Low Demand';
  }

  // Get demand color for UI
  String get demandColor {
    if (weightedAverage >= 0.6) return '#10B981'; // Green
    if (weightedAverage >= 0.4) return '#F59E0B'; // Yellow
    return '#EF4444'; // Red
  }

  // Get growth projection based on weighted average
  String get growthProjection {
    if (weightedAverage >= 0.6) return '+15% over 10 years';
    if (weightedAverage >= 0.4) return '+8% over 10 years';
    return '+3% over 10 years';
  }
}
