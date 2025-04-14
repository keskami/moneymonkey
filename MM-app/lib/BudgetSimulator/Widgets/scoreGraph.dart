import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';

class BudgetGraphWidget extends StatefulWidget {
  final List<String> scoreCategories;
  final dynamic widget;

  BudgetGraphWidget(
      {Key? key, required this.scoreCategories, required this.widget})
      : super(key: key);

  @override
  _BudgetGraphWidgetState createState() => _BudgetGraphWidgetState();
}

class _BudgetGraphWidgetState extends State<BudgetGraphWidget> {
  int? hoveredIndex;

  List<int> scores = [0, 0, 0, 0, 0];
  List<int> potentialScores = [300, 250, 200, 150, 100];
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();

  @override
  void initState() {
    super.initState();
    setState(() {
      scores[0] =
          functions.s1P2SavingsScore(widget.widget.widget.savingsAccountBalance) as int ;
          scores[1] = functions.s1P2CreditScoreScore(widget.widget.widget.creditScore) as int;
          scores[2] = widget.widget.widget.onTimePaymentScore as int;
          scores[3] = functions.s1P2CCDebtScore(widget.widget.widget.creditCardDebt) as int;
          scores[4] = functions.s1P2WellnessScore(widget.widget.widget.bodyScore , widget.widget.widget.mindScore, widget.widget.widget.socialScore) as int;
    });
  }

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
          width: .6,
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
                  tooltipRoundedRadius: 8,
                  tooltipPadding: EdgeInsets.all(5),
                  tooltipMargin: 8,
                  getTooltipColor: (group) => Colors.white,
                  tooltipBorder: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String tooltipText = '';

                    if (hoveredIndex != null) {
                      if (hoveredIndex! <= 4) {
                        tooltipText =
                            '${widget.scoreCategories[hoveredIndex!]}\nCurrent: ${scores[hoveredIndex!].toStringAsFixed(1)} points\nPotential: ${potentialScores[hoveredIndex!].toStringAsFixed(1)} points';
                      }
                    }

                    return BarTooltipItem(
                      tooltipText,
                      TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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
                createBarGroup(0, scores[0],
                    potentialScores[0], screenWidthUnit),
                createBarGroup(1, scores[1],
                    potentialScores[1], screenWidthUnit),
                createBarGroup(2, scores[2],
                    potentialScores[2], screenWidthUnit),
                createBarGroup(3, scores[3],
                    potentialScores[3], screenWidthUnit),
                createBarGroup(4, scores[4],
                    potentialScores[4] , screenWidthUnit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData createBarGroup(
      int x, int blueValue, int whiteValue, double screenWidthUnit) {
    return BarChartGroupData(
      x: x,
      barRods: [
        // Blue bar with hover effect
        BarChartRodData(
          toY: blueValue.toDouble(),
          color: Color.fromRGBO(0, 127, 255, 1),
          width: 40 * screenWidthUnit,
          borderRadius: BorderRadius.zero,
        ),
        // White bar with light gray border
        BarChartRodData(
          toY: whiteValue.toDouble(),
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
    final titles = widget.scoreCategories;

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
