import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Backend/Models/stock_data.dart';
import '../../themes/color_themes.dart';

class LineChartWidget extends StatelessWidget {
  final List<StockData> stockData; // Receive stock data from InvestmentPage
  final String duration;

  const LineChartWidget({
    super.key,
    required this.stockData,
    required this.duration,
  });

  // Function to calculate the percentage change
  double calculateChange(double open, double close) {
    return ((close - open) / open) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> days = {
      "24H": 24,
      "7D": 24,
      "1M": 30,
      "3M": 90,
      "1Y": 365,
      "ALL": 366,
    };
    DateTime oneYearAgo =
        DateTime.now().subtract(Duration(days: days[duration]!));

    // Filter stock data based on the selected duration
    List<FlSpot> spots = stockData
        .where((data) => data.date.isAfter(oneYearAgo))
        .toList()
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.close,
            ))
        .toList();

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
                  LightTheme().primaryBlue.withOpacity(0.4),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            dotData: FlDotData(show: false), // Disable default dots
          ),
        ],
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (group) => Colors.black,
            tooltipMargin: 8,
            tooltipRoundedRadius: 10,
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 3,
            ),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final index = touchedSpot.spotIndex;
                final dataPoint = stockData[index];
                final change = calculateChange(dataPoint.open, dataPoint.close);
                final arrow = change >= 0 ? '+' : '';

                return LineTooltipItem(
                  '${dataPoint.date.month}/${dataPoint.date.day}/${dataPoint.date.year}\n',
                  const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: '🍌${dataPoint.close.toStringAsFixed(2)} ',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: '$arrow ${change.toStringAsFixed(2)}%',
                          style: const TextStyle(
                            backgroundColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                  textAlign: TextAlign.left,
                );
              }).toList();
            },
          ),
          getTouchedSpotIndicator: (barData, indicators) {
            return indicators.map((int index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: Colors.transparent,
                  strokeWidth: 0,
                ), // No vertical line
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 6,
                    color: Colors.black,
                    strokeColor: Colors.black,
                  ),
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
