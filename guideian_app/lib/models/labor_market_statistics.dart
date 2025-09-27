import 'package:flutter/material.dart';

class LaborMarketStatistics {
  final String quarter;
  final String table;
  final String category;
  final String subcategory;
  final double? previousQtr;
  final double? currentQtr;
  final double? qtrToQtrChange;
  final double? yearOnYearChange;
  final double? qtrToQtrChangePercent;
  final double? yearOnYearChangePercent;
  final double? unemploymentRate;
  final double? absorptionRate;
  final double? labourForceParticipationRate;
  final double? coefficientOfVariationPrevious;
  final double? coefficientOfVariationCurrent;
  final double? lower95;
  final double? upper95;
  final double? pValue;

  LaborMarketStatistics({
    required this.quarter,
    required this.table,
    required this.category,
    required this.subcategory,
    this.previousQtr,
    this.currentQtr,
    this.qtrToQtrChange,
    this.yearOnYearChange,
    this.qtrToQtrChangePercent,
    this.yearOnYearChangePercent,
    this.unemploymentRate,
    this.absorptionRate,
    this.labourForceParticipationRate,
    this.coefficientOfVariationPrevious,
    this.coefficientOfVariationCurrent,
    this.lower95,
    this.upper95,
    this.pValue,
  });

  factory LaborMarketStatistics.fromCsv(Map<String, dynamic> csvData) {
    return LaborMarketStatistics(
      quarter: csvData['Quarter'] ?? '',
      table: csvData['Table'] ?? '',
      category: csvData['Category'] ?? '',
      subcategory: csvData['Subcategory'] ?? '',
      previousQtr: _parseDouble(csvData['Previous Qtr (Thousand)']),
      currentQtr: _parseDouble(csvData['Current Qtr (Thousand)']),
      qtrToQtrChange: _parseDouble(csvData['Qtr-to-qtr change (Thousand)']),
      yearOnYearChange: _parseDouble(csvData['Year-on-year change (Thousand)']),
      qtrToQtrChangePercent: _parseDouble(csvData['Qtr-to-qtr change (%)']),
      yearOnYearChangePercent: _parseDouble(csvData['Year-on-year change (%)']),
      unemploymentRate: _parseDouble(csvData['Unemployment Rate (%)']),
      absorptionRate: _parseDouble(csvData['Absorption Rate (%)']),
      labourForceParticipationRate: _parseDouble(csvData['Labour Force Participation Rate (%)']),
      coefficientOfVariationPrevious: _parseDouble(csvData['Coefficient of Variation Previous Qtr (%)']),
      coefficientOfVariationCurrent: _parseDouble(csvData['Coefficient of Variation Current Qtr (%)']),
      lower95: _parseDouble(csvData['Lower 95% (Thousand)']),
      upper95: _parseDouble(csvData['Upper 95% (Thousand)']),
      pValue: _parseDouble(csvData['P-value']),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null || value == '') return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final cleaned = value.replaceAll(',', '').trim();
      if (cleaned.isEmpty) return null;
      return double.tryParse(cleaned);
    }
    return null;
  }

  // Get trend direction
  String get trendDirection {
    if (qtrToQtrChangePercent == null) return 'Stable';
    if (qtrToQtrChangePercent! > 0) return 'Increasing';
    if (qtrToQtrChangePercent! < 0) return 'Decreasing';
    return 'Stable';
  }

  // Get trend color for UI
  Color get trendColor {
    if (qtrToQtrChangePercent == null) return const Color(0xFF6B7280); // Gray
    if (qtrToQtrChangePercent! > 0) return const Color(0xFF10B981); // Green
    if (qtrToQtrChangePercent! < 0) return const Color(0xFFEF4444); // Red
    return const Color(0xFF6B7280); // Gray
  }

  // Check if data is significant
  bool get isSignificant {
    return pValue != null && pValue! < 0.05;
  }

  // Get confidence level
  String get confidenceLevel {
    if (pValue == null) return 'Unknown';
    if (pValue! < 0.01) return 'Very High (99%)';
    if (pValue! < 0.05) return 'High (95%)';
    if (pValue! < 0.10) return 'Medium (90%)';
    return 'Low (<90%)';
  }
}
