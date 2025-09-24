import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';

class PerformanceTrendsChart extends StatefulWidget {
  final double? width;
  final double? height;
  final String filter;
  const PerformanceTrendsChart({
    Key? key,
    required this.filter,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<PerformanceTrendsChart> createState() => _PerformanceTrendsChartState();
}

class _PerformanceTrendsChartState extends State<PerformanceTrendsChart> {
  TeacherDashboardController teacherDashboardController = Get.find<TeacherDashboardController>();
  
  @override
  Widget build(BuildContext context) {
    final double containerWidth =
        widget.width ?? MediaQuery.of(context).size.width * 0.9;
    final double containerHeight =
        widget.height ?? MediaQuery.of(context).size.height * 0.5;

    // Calculate width based on number of components to ensure there's enough space
    final double contentWidth = max(
      containerWidth,
      teacherDashboardController.childComponents.value.length * 120.0,
    );

    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      width: containerWidth,
      height: containerHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Performance Trends',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLegendItem('Class Average', Colors.blue),
                      const SizedBox(width: 12),
                      _buildLegendItem('Participation Rate', Colors.green),
                      const SizedBox(width: 12),
                      _buildLegendItem('Lesson Completion', Colors.purple),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: contentWidth,
                height: containerHeight - 80,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        tooltipMargin: 0,
                        getTooltipColor: (touchedSpot) => Colors.white,
                        tooltipPadding: EdgeInsets.all(8),
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((barSpot) {
                            return LineTooltipItem(
                              '${barSpot.y.toStringAsFixed(1)}%',
                              TextStyle(
                                color: barSpot.bar.color,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> spotIndexes) {
                        return spotIndexes.map((spotIndex) {
                          return TouchedSpotIndicatorData(
                            FlLine(color: Colors.transparent),
                            FlDotData(show: true),
                          );
                        }).toList();
                      },
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 25,
                      verticalInterval: 1,
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) =>
                              bottomTitleWidgets(value, meta, teacherDashboardController.childComponents.value),
                          interval: 1,
                          reservedSize: 70, // Increased to accommodate 2 lines
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 25,
                          reservedSize: 35,
                          getTitlesWidget: leftTitleWidgets,
                        ),
                      ),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        left: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    minX: 0,
                    maxX: (teacherDashboardController.childComponents.value.length - 1).toDouble(),
                    minY: 0,
                    maxY: 100,
                    lineBarsData: generateFilteredChart(widget.filter),
                  ),
                ),
              ),
            ),
          ),
          // Add a small indicator to show that the chart is scrollable
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_left, size: 20, color: Colors.grey),
                Text('Scroll to see more', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Icon(Icons.arrow_right, size: 20, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  // Method to handle properly mapping multiple components with varying values
  List<LineChartBarData> generateFilteredChart(String filter) {
    // Safety check to ensure we have data
    if (teacherDashboardController.childComponents.value.isEmpty) {
      return [];
    }
    
    // Map each component to its corresponding data point
    // This creates varying data points based on actual component values
    List<FlSpot> classAverageSpots = teacherDashboardController.childComponents.value
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.performanceTrends.classAverage,
            ))
        .toList();
    
    List<FlSpot> participationRateSpots = teacherDashboardController.childComponents.value
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.performanceTrends.participationRate,
            ))
        .toList();
    
    List<FlSpot> lessonCompletionSpots = teacherDashboardController.childComponents.value
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.performanceTrends.lessonCompletion,
            ))
        .toList();
    
    // Return the appropriate data based on filter
    if (filter == 'Class Average') {
      return [
        generateLineData(classAverageSpots, Colors.blue),
      ];
    } else if (filter == 'Participation Rate') {
      return [
        generateLineData(participationRateSpots, Colors.green),
      ];
    } else if (filter == 'Lesson Completion') {
      return [
        generateLineData(lessonCompletionSpots, Colors.purple),
      ];
    } else {
      // Show all metrics if "All Statistics" is selected
      return [
        generateLineData(classAverageSpots, Colors.blue),
        generateLineData(participationRateSpots, Colors.green),
        generateLineData(lessonCompletionSpots, Colors.purple),
      ];
    }
  }

  LineChartBarData generateLineData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      curveSmoothness: 0.3, // Smoother curves
      color: color,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, bar, index) => TripleCircleDotPainter(
          color: color,
          radius: 5,
        ),
      ),
      //Optional to show bottom Colors too
      // belowBarData: BarAreaData(
      //   show: true,
      //   color: color.withOpacity(0.1),
      // ),
    );
  }
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  return Padding(
    padding: const EdgeInsets.only(right: 4.0),
    child: Text(
      '${value.toInt()}%',
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.right,
    ),
  );
}

Widget bottomTitleWidgets(
    double value, TitleMeta meta, List<Component> data) {
  if (value.toInt() >= data.length) return const SizedBox.shrink();

  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: RotatedBox(
      quarterTurns: 0, // No rotation - change to 1 for 90 degree rotation if needed
      child: Container(
        width: 100, // Fixed width for the label
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          data[value.toInt()].title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    ),
  );
}

class TripleCircleDotPainter extends FlDotPainter {
  final Color color;
  final double radius;

  TripleCircleDotPainter({
    required this.color,
    required this.radius,
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offset) {
    // Outer colored circle
    canvas.drawCircle(
      offset,
      radius,
      Paint()..color = color,
    );

    // Middle white circle
    canvas.drawCircle(
      offset,
      radius - 1,
      Paint()..color = Colors.white,
    );

    // Inner colored circle
    canvas.drawCircle(
      offset,
      radius - 2,
      Paint()..color = color,
    );
  }

  @override
  Size getSize(FlSpot spot) {
    return Size(radius * 2, radius * 2);
  }

  @override
  List<Object> get props => [color, radius];

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    throw UnimplementedError();
  }

  @override
  Color get mainColor => throw UnimplementedError();
}