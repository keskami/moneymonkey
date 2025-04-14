import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpendingDonutChart extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  List<String> types;
  List<double> percentage;
  double total = 0;
  List<BudgetSimulatorChartData> chartData = [];
  

  SpendingDonutChart({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.types,
    required this.percentage,
    required this.total,
    required this.chartData,
  });
  @override
  _SpendingDonutChartState createState() => _SpendingDonutChartState();
}

class _SpendingDonutChartState extends State<SpendingDonutChart> {
  List<Color> colors = [
    Colors.pink,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.yellow,
    Colors.black,
    Colors.purple,
  ];
  

  
  

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 314 * widget.screenHeightUnit,
      width: 470 * widget.screenWidthUnit,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: .6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              widget.screenWidthUnit * 20,
              widget.screenHeightUnit * 8,
              0,
              widget.screenHeightUnit * 8,
            ),
            child: Text(
              "This Month’s Spendings",
              style: GoogleFonts.baloo2(
                fontSize: widget.screenHeightUnit * 36,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: 470 * widget.screenWidthUnit,
            height: 1 * widget.screenHeightUnit,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 240 * widget.screenHeightUnit,
                width: 200 * widget.screenWidthUnit,
                child: SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      widget: Text(
                        '${widget.total}\$',
                        style: TextStyle(
                          fontSize: widget.screenWidthUnit * 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                  series: <CircularSeries<BudgetSimulatorChartData, String>>[
                    DoughnutSeries<BudgetSimulatorChartData, String>(
                      dataSource: widget.chartData,
                      xValueMapper: (BudgetSimulatorChartData data, _) => data.category,
                      yValueMapper: (BudgetSimulatorChartData data, _) => data.percentage,
                      pointColorMapper: (BudgetSimulatorChartData data, _) => data.color,
                      innerRadius: '60%',
                    )
                  ],
                ),
              ),
              
              Container(
                height: 225 * widget.screenHeightUnit,
                width: 310 * widget.screenHeightUnit,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.types.length; i++)
                        SpendingSidePart(
                          screenHeightUnit: widget.screenHeightUnit,
                          screenWidthUnit: widget.screenWidthUnit,
                          type: widget.types[i % colors.length],
                          percentage:
                              widget.percentage[i % colors.length].toInt(),
                          color: colors[i % colors.length],
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SpendingSidePart extends StatelessWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final String type;
  final int percentage;
  final Color color;

  SpendingSidePart({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.type,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeightUnit * 12),
      child: Row(
        children: [
          Container(
            height: screenHeightUnit * 23,
            width: screenHeightUnit * 23,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(
            width: screenWidthUnit * 10,
          ),
          type == "Subscriptions & Memberships" ?Text(
            "Subs & Memberships",
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ) :
          Text(
            type,
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: screenWidthUnit * 15),
            child: 
            Text(
              "$percentage%",
              style: GoogleFonts.baloo2(
                  fontSize: screenHeightUnit * 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
class _ChartData {
  final String category;
  final double percentage;
  final Color color;

  _ChartData(this.category, this.percentage, this.color);
}


