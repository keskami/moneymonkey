import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend/Models/stock_data.dart';
import '../../themes/color_themes.dart';

class LineChartWidget extends StatefulWidget {
  final List<StockData> stockData;
  final String duration;

  const LineChartWidget({
    Key? key,
    required this.stockData,
    required this.duration,
  }) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  double calculateChange(double open, double close) {
    return ((close - open) / open) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> days = {
      "24H": 40,
      "7D": 45,
      "1M": 90,
      "3M": 150,
      "1Y": 365,
      "ALL": widget.stockData.length,
    };
    DateTime cutOffDate =
        DateTime.now().subtract(Duration(days: days[widget.duration]!));
    List<FlSpot> spots = widget.stockData
        .where(
          (data) => data.date.isAfter(cutOffDate),
        )
        .toList()
        .toList()
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.close,
            ))
        .toList();

    if (spots.isEmpty) {
      spots = [FlSpot(0, widget.stockData.first.close)];
      print(
          'No data available for ${widget.duration} range. Showing default data point.');
    }
    print(spots);
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
            dotData: const FlDotData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(0),
                  style: GoogleFonts.baloo2().copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
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
                final dataPoint = widget.stockData[index];
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
                      text: '🍌${dataPoint.close.toStringAsFixed(2)}  ',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: '$arrow ${change.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                        backgroundColor: Colors.white,
                      ),
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
                ),
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
