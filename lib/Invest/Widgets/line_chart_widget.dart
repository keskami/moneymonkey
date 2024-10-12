import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Backend/Models/stock_data.dart';
import '../../themes/color_themes.dart';

class LineChartWidget extends StatelessWidget {
  final List<StockData> stockData; // Receive stock data from InvestmentPage
  final int duration;

  const LineChartWidget({
    Key? key,
    required this.stockData,
    required this.duration,
  }) : super(key: key);

  // Function to calculate the percentage change
  double calculateChange(double open, double close) {
    return ((close - open) / open) * 100;
  }

  @override
  Widget build(BuildContext context) {
    DateTime oneYearAgo = DateTime.now().subtract(Duration(days: duration));

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
            dotData: FlDotData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipMargin: 8,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final index = touchedSpot.spotIndex;
                final dataPoint = stockData[index];
                final change = calculateChange(dataPoint.open, dataPoint.close);
                final arrow = change >= 0 ? '+' : '';

                return LineTooltipItem(
                  '${dataPoint.date.month}/${dataPoint.date.day}/${dataPoint.date.year}\n',
                  TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: '🍌${dataPoint.close.toStringAsFixed(2)} ',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: '$arrow ${change.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.white,
                            fontSize: 10,
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
        ),
      ),
    );
  }
}
