import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpendingDonutChart extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final List<String> types;
  final List<double> percentage;
  double total = 0;

  SpendingDonutChart({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.types,
    required this.percentage,
    required this.total,
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
    Colors.pink
  ];
  int total = 0;

  List<_ChartData> chartData = [];
  Future<void> getData() async {
    for (int i = 0; i < widget.types.length; i++) {
      chartData
          .add(_ChartData(widget.types[i], widget.percentage[i], colors[i]));
      total += widget.percentage[i].toInt();
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 344 * widget.screenHeightUnit,
      width: 470 * widget.screenWidthUnit,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              widget.screenWidthUnit * 24,
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
                height: 270 * widget.screenHeightUnit,
                width: 350 * widget.screenHeightUnit,
                child: SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      widget: Text(
                        '${widget.total}\$',
                        style: TextStyle(
                          fontSize: widget.screenWidthUnit * 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                  series: <CircularSeries<_ChartData, String>>[
                    DoughnutSeries<_ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (_ChartData data, _) => data.category,
                      yValueMapper: (_ChartData data, _) => data.percentage,
                      pointColorMapper: (_ChartData data, _) => data.color,
                      innerRadius: '60%',
                    )
                  ],
                ),
              ),
              Container(
                height: 260 * widget.screenHeightUnit,
                width: 300 * widget.screenHeightUnit,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.types.length; i++)
                        SpendingSidePart(
                          screenHeightUnit: widget.screenHeightUnit,
                          screenWidthUnit: widget.screenWidthUnit,
                          type: widget.types[i],
                          percentage: widget.percentage[i].toInt(),
                          color: colors[i],
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
            height: screenHeightUnit * 25,
            width: screenHeightUnit * 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(
            width: screenWidthUnit * 10,
          ),
          Text(
            type,
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: screenWidthUnit * 15),
            child: Text("$percentage%", style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 24,
              color: Colors.black,
              fontWeight: FontWeight.w600
            ),),
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
