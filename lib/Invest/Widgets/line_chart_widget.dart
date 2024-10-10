import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Backend/Models/stock_data.dart';

class LineChartWidget extends StatelessWidget {
  final List<StockData> stockData;

  LineChartWidget({required this.stockData});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = stockData
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.close, // Plotting the close price
            ))
        .toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false), // Hide the grid
        titlesData: FlTitlesData(show: false), // Hide the axis titles
        borderData: FlBorderData(
          show: false, // Hide the borders
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            belowBarData: BarAreaData(show: false), // Hide area below the line
            dotData: FlDotData(show: false), // Hide dots on the line
            curveSmoothness: 0.3, // Smoother curve
          ),
        ],
        // Optionally set the x and y ranges based on your data
        minX: 0,
        maxX: spots.length.toDouble() - 1,
        minY:
            stockData.map((data) => data.close).reduce((a, b) => a < b ? a : b),
        maxY:
            stockData.map((data) => data.close).reduce((a, b) => a > b ? a : b),
      ),
    );
  }
}
