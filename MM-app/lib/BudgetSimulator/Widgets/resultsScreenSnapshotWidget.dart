import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Pages/results.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/scoreGraph.dart';


class ResultsScreenSnapShot extends StatefulWidget {
  final List<String> scoreCategories;
  final dynamic widget;

  const ResultsScreenSnapShot(
      {Key? key, required this.scoreCategories, required this.widget})
      : super(key: key);

  @override
  State<ResultsScreenSnapShot> createState() => _ResultsScreenSnapShotState();
}

class _ResultsScreenSnapShotState extends State<ResultsScreenSnapShot> {
  bool showRadarChart = true;
  final snapshotKey = GlobalKey();
  List<int> scores = [0, 0, 0, 0, 0];
  List<int> potentialScores = [300, 250, 200, 150, 100];
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();
  late List<double> scoreRatios = [
    0,
    0,
    0,
    0,
    0,
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      scores[0] = functions
          .s1P2SavingsScore(widget.widget.widget.savingsAccountBalance) as int;
      scores[1] = functions
          .s1P2CreditScoreScore(widget.widget.widget.creditScore) as int;
      scores[2] = widget.widget.widget.onTimePaymentScore as int;
      scores[3] =
          functions.s1P2CCDebtScore(widget.widget.widget.creditCardDebt) as int;
      scores[4] = functions.s1P2WellnessScore(
          widget.widget.widget.bodyScore,
          widget.widget.widget.mindScore,
          widget.widget.widget.socialScore) as int;
    });
    scoreRatios = List.generate(
      scores.length,
      (index) => (scores[index] / potentialScores[index]).clamp(0, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenWidthUnit = screenWidth / 1920;
    final screenHeightUnit = screenHeight / 1080;

    return SingleChildScrollView(
      key: snapshotKey,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidthUnit * 60, vertical: screenHeightUnit * 50),
      child: Card(
        elevation: screenHeightUnit * 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(screenWidthUnit * 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.bar_chart,
                      size: screenHeightUnit * 30, color: Colors.grey[800]),
                  SizedBox(width: screenWidthUnit * 10),
                  Text(
                    'Budgeting Snapshot',
                    style: TextStyle(
                        fontSize: screenHeightUnit * 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                ],
              ),
              Container(
                width: screenWidthUnit * 80,
                height: 2,
                color: Colors.blue,
                margin: EdgeInsets.symmetric(vertical: screenHeightUnit * 14),
              ),
              Text(
                'A visual summary of your budgeting strengths. Each category is rated and color-coded to help you quickly see where you\nshined and where you can grow.',
                style: TextStyle(color: Colors.grey[600], height: 1.4),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 25 * screenHeightUnit),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _toggleVisualization,
                  icon: Icon(
                    showRadarChart ? Icons.bar_chart : Icons.radar,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Switch to ${showRadarChart ? 'Progress Bars' : 'Radar Chart'}',
                    style: GoogleFonts.baloo2(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                        horizontal: 26 * screenWidthUnit,
                        vertical: 17 * screenHeightUnit),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30 * screenHeightUnit),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: Container(
                    key: ValueKey<bool>(showRadarChart),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: showRadarChart
                          ? _buildRadarChart(widget.scoreCategories, scoreRatios)
                          : BudgetGraphWidget(
                              scoreCategories: widget.scoreCategories,
                              widget: widget.widget,
                            ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadarChart(List<String> scoreCategories, List<double> scores) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenWidthUnit = screenWidth / 1920;
    final screenHeightUnit = screenHeight / 1080;
    return Container(
      height: screenHeightUnit * 350,
      child: RadarChart(
        RadarChartData(
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarBorderData: BorderSide(color: Colors.grey.withOpacity(0.2)),
          tickBorderData: BorderSide(color: Colors.transparent),
          gridBorderData:
              BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          ticksTextStyle: TextStyle(color: Colors.transparent),
          titleTextStyle: TextStyle(
              color: Colors.grey[700],
              fontSize: screenHeightUnit * 16,
              fontWeight: FontWeight.w500),
          titlePositionPercentageOffset: 0.225,
          getTitle: (index, angle) => RadarChartTitle(
            text: scoreCategories[index],
          ),
            dataSets: [
            RadarDataSet(
              dataEntries: scores
                .asMap()
                .entries
                .map((entry) => RadarEntry(value: entry.value.toDouble()))
                .toList(),
              borderColor: Colors.blue,
              borderWidth: 2 * screenWidthUnit,
              entryRadius: 4 * screenWidthUnit,
              fillColor: Colors.blue.withOpacity(0.1),
            ),
          ],
          tickCount: 5,
          radarShape: RadarShape.polygon,
        ),
      ),
    );
  }

  void _toggleVisualization() {
    setState(() {
      showRadarChart = !showRadarChart;
    });
  }
}
