import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_monkey/TeacherDashboard/Backend/Model.dart';

class PerformanceTrendsChart extends StatefulWidget {
  final List<PerformanceData> data;
  final double? width;
  final double? height;
  final String filter;
  const PerformanceTrendsChart({
    Key? key,
    required this.data,
    required this.filter,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<PerformanceTrendsChart> createState() => _PerformanceTrendsChartState();
}

class _PerformanceTrendsChartState extends State<PerformanceTrendsChart> {
  @override
  Widget build(BuildContext context) {
    final double containerWidth =
        widget.width ?? MediaQuery.of(context).size.width * 0.9;
    final double containerHeight =
        widget.height ?? MediaQuery.of(context).size.height * 0.5;

    final double contentWidth = max(
      containerWidth,
      widget.data.length * 100.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                        tooltipRoundedRadius: 8,
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        tooltipMargin: 0,
                        getTooltipColor: (touchedSpot) =>
                            Colors.grey.withValues(alpha: 0.5),
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
                              bottomTitleWidgets(value, meta, widget.data),
                          interval: 1,
                          reservedSize: 50,
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
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: (widget.data.length - 1).toDouble(),
                    minY: 0,
                    maxY: 100,
                    lineBarsData: generateFilteredChart(widget.filter),
                  ),
                ),
              ),
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
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  List<LineChartBarData> generateFilteredChart(String filter) {
    if (filter == 'Class Average') {
      return [
        generateLineData(
          widget.data
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.classAverage))
              .toList(),
          Colors.blue,
        ),
      ];
    } else if (filter == 'Participation Rate') {
      return [
        generateLineData(
          widget.data
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.participationRate))
              .toList(),
          Colors.green,
        ),
      ];
    } else if (filter == 'Lesson Completion') {
      return [
        generateLineData(
          widget.data
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.lessonCompletion))
              .toList(),
          Colors.purple,
        ),
      ];
    } else {
      return [
        generateLineData(
          widget.data
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.classAverage))
              .toList(),
          Colors.blue,
        ),
        generateLineData(
          widget.data
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.participationRate))
              .toList(),
          Colors.green,
        ),
        generateLineData(
          widget.data
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.lessonCompletion))
              .toList(),
          Colors.purple,
        ),
      ];
    }
  }

  LineChartBarData generateLineData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, bar, index) => TripleCircleDotPainter(
          color: color,
          radius: 5,
        ),
      ),
      belowBarData: BarAreaData(show: false),
    );
  }
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  return Padding(
    padding: const EdgeInsets.only(right: 4.0),
    child: Text(
      '${value.toInt()}%',
      style: const TextStyle(fontSize: 12),
      textAlign: TextAlign.right,
    ),
  );
}

Widget bottomTitleWidgets(
    double value, TitleMeta meta, List<PerformanceData> data) {
  if (value.toInt() >= data.length) return const SizedBox.shrink();

  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      data[value.toInt()].label,
      style: const TextStyle(fontSize: 12),
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
