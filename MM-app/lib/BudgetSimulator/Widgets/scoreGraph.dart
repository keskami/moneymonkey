import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetGraphWidget extends StatefulWidget {
  const BudgetGraphWidget({Key? key}) : super(key: key);

  @override
  _BudgetGraphWidgetState createState() => _BudgetGraphWidgetState();
}

class _BudgetGraphWidgetState extends State<BudgetGraphWidget> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double screenHeightUnit = screenHeight / 1406;
    double screenWidthUnit = screenWidth / 2079;

    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color.fromRGBO(0, 127, 255, 1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.00,
          right: screenWidth * 0.02,
          top: screenHeight * 0.03,
        ),
        child: AspectRatio(
          aspectRatio: 3,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: 300,
              minY: 0,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipRoundedRadius: 4,
                  getTooltipColor: (group) => Colors.white,
                  tooltipBorder: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),


                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String tooltipText = '';

                    if (hoveredIndex != null) {
                      if (hoveredIndex! < 2) {
                        tooltipText =
                            'Payment History\nCurrent: ${rod.toY.toStringAsFixed(1)}\nPotential: ${rod.toY.toStringAsFixed(1)}';
                      } else if (hoveredIndex! < 4) {
                        tooltipText =
                            'Credit Utilization\nValue: ${rod.toY.toStringAsFixed(1)}';
                      } else {
                        tooltipText =
                            'Credit Mix\nValue: ${rod.toY.toStringAsFixed(1)}';
                      }
                    }

                    return BarTooltipItem(
                      tooltipText,
                      TextStyle(color: Colors.black),
                    );
                  },
                ),
                touchCallback:
                    (FlTouchEvent event, BarTouchResponse? response) {
                  if (event is FlPointerHoverEvent && response?.spot != null) {
                    setState(() {
                      hoveredIndex = response!.spot!.touchedBarGroupIndex;
                    });
                  } else {
                    setState(() {
                      hoveredIndex = null;
                    });
                  }
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getBottomTitles,
                    reservedSize: 80 * screenHeightUnit,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getLeftTitles,
                    reservedSize: 80 * screenWidthUnit,
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                horizontalInterval: 100 * screenHeightUnit,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(show: false),
              groupsSpace: 100 * screenWidthUnit,
              barGroups: [
                createBarGroup(0, 150, 200, screenWidthUnit), // Payment History
                createBarGroup(
                    1, 250, 200, screenWidthUnit), // Credit Utilization
                createBarGroup(
                    2, 200, 200, screenWidthUnit), // Length of Credit
                createBarGroup(3, 150, 200, screenWidthUnit), // Credit Mix
                createBarGroup(4, 50, 200, screenWidthUnit), // New Credit
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData createBarGroup(
      int x, double blueValue, double whiteValue, double screenWidthUnit) {
    return BarChartGroupData(
      x: x,
      barRods: [
        // Blue bar with hover effect
        BarChartRodData(
          toY: blueValue,
          color: Color.fromRGBO(0, 127, 255, 1),
          width: 40 * screenWidthUnit,
          borderRadius: BorderRadius.zero,
        ),
        // White bar with light gray border
        BarChartRodData(
          toY: whiteValue,
          color: Colors.grey.withOpacity(.7),
          width: 40 * screenWidthUnit,
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
      ],
      barsSpace: 2,
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    final titles = [
      'Debt\nReduction',
      'Payment\nTimeliness & Penalties',
      'Credit Score\nImprovement',
      'Wellness\nImprovement',
      'Milestones\nAchieved'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: TextStyle(
        color: Colors.grey,
        fontSize: 10,
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
