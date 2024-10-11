import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:money_monkey/themes/color_themes.dart';

import '../../Backend/Models/stock_data.dart';

class LineChartWidget extends StatelessWidget {
  final List<StockData> stockData;
  final String symbol;
  final int duration;

  LineChartWidget({
    required this.stockData,
    required this.symbol,
    required this.duration,
  });

  // Function to load data from a local JSON file
  static Future<List<StockData>> loadStockData() async {
    try {
      // Load the JSON file from assets
      final String response =
          await rootBundle.loadString('assets/sample_stock_data.json');
      final Map<String, dynamic> jsonMap = json.decode(response);

      // Extract the "Time Series (Daily)" data
      Map<String, dynamic> timeSeries = jsonMap["Time Series (Daily)"];
      print(timeSeries.isEmpty);
      // Map the entries to StockData objects
      List<StockData> loadedStockData = timeSeries.entries.map((entry) {
        return StockData.fromJson(entry.value, entry.key);
      }).toList();

      return loadedStockData; // Return the loaded stock data
    } catch (e) {
      print("Error loading data from JSON file: $e");
      return []; // Return an empty list if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter data to include only the last year
    DateTime oneYearAgo = DateTime.now().subtract(Duration(days: duration));

    // Create FlSpot list from stock data
    List<FlSpot> spots = stockData
        .where((data) =>
            data.date.isAfter(oneYearAgo)) // Ensure 'data' is StockData
        .toList()
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.close, // Access the close price correctly
            ))
        .toList();

    // Check for empty data
    if (spots.isEmpty) {
      return Center(child: Text("No data available for the selected period."));
    }

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: LightTheme().primaryBlue,
            barWidth: 2,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  LightTheme()
                      .primaryBlue
                      .withOpacity(0.4), // Blue gradient at the top
                  Colors.white, // Fade to white at the bottom
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            dotData: FlDotData(show: false), // Hide dots on the line
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No left axis labels
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No bottom axis labels
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No right axis labels
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No top axis labels
          ),
        ),
        gridData: FlGridData(show: false), // No grid lines
        borderData: FlBorderData(show: false), // No borders around the chart
      ),
    );
  }
}
