import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetGraphWidget extends StatelessWidget {
  const BudgetGraphWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 3.5, 
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: 300,
              minY: 0,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getBottomTitles,
                    reservedSize: 40, // Increased from 20 to 40 for more horizontal title space
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getLeftTitles,
                    reservedSize: 40,
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                horizontalInterval: 50,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(show: false),
              groupsSpace: 50, 
              barGroups: [
                createBarGroup(0, 150, 100), // Payment History
                createBarGroup(1, 250, 200), // Credit Utilization
                createBarGroup(2, 300, 200), // Length of Credit
                createBarGroup(3, 150, 20), // Credit Mix
                createBarGroup(4, 50, 20), // New Credit
              ],
            ),
          ),
        ),
      )
    );
  }

  BarChartGroupData createBarGroup(int x, double blueValue, double whiteValue) {
    return BarChartGroupData(
      x: x,
      barRods: [
        // Blue bar
        BarChartRodData(
          toY: blueValue,
          color: Colors.blue,
          width: 20,
          borderRadius: BorderRadius.zero,
        ),
        // White bar with light gray border
        BarChartRodData(
          toY: whiteValue,
          color: Colors.white,
          width: 20,
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
      ],
      barsSpace: 2, // Small space between blue and white bars
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    final titles = [
      'Debt\nReduction',
      'Payment\nTimeliness & Penalties',
      'Credit Score\nImprovemnt',
      'Wellness\nImprovemnt',
      'Milestones\nAchived'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 8, // Slightly increased from 7 to 8 for better readability
      ),
      textAlign: TextAlign.center,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    if (value % 5 != 0) {
      return Container();
    }
    
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toInt().toString(),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 8,
        ),
      ),
    );
  }
}