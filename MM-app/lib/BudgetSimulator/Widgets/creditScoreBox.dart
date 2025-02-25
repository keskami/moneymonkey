import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MeterBox extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final int creditScore;

  MeterBox(
      {required this.screenHeightUnit,
      required this.screenWidthUnit,
      required this.creditScore});

  @override
  _MeterBoxState createState() => _MeterBoxState();
}

class _MeterBoxState extends State<MeterBox> {
  final List<Color> sectionColors = [
    Colors.red,
    Color.fromRGBO(251, 176, 59, 1),
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    final double min = 550;
    final double max = 700;
    final int numberOfSections = 5;
    final double sectionSize = (max - min) / numberOfSections;
    final List<GaugeRange> ranges = List.generate(numberOfSections, (index) {
      final double startValue = min + (sectionSize * index);
      final double endValue = startValue + sectionSize;
      return GaugeRange(
        startValue: startValue,
        endValue: endValue,
        color: sectionColors[index],
        startWidth: widget.screenWidthUnit * 30,
        endWidth: widget.screenWidthUnit * 30,
      );
    });

    return Container(
      height: widget.screenHeightUnit * 190,
      width: widget.screenWidthUnit * 470,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: widget.screenWidthUnit,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(widget.screenWidthUnit * 16,
                widget.screenHeightUnit * 8, 0, widget.screenHeightUnit * 8),
            child: Text(
              "Credit Score",
              style: GoogleFonts.baloo2(
                  fontSize: widget.screenHeightUnit * 34,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Container(
            width: widget.screenWidthUnit * 470,
            height: widget.screenHeightUnit * 1,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          widget.screenWidthUnit * 25, widget.screenHeightUnit * 10, 0, 0),
                      child: Row(
                        children: [
                          Text('${widget.creditScore}',
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenWidthUnit * 50,
                                fontWeight: FontWeight.w600,
                                color: widget.creditScore >
                                        670
                                    ? sectionColors[4]
                                    : widget.creditScore >
                                            640
                                        ? sectionColors[3]
                                        : widget.creditScore >
                                                610
                                            ? sectionColors[2]
                                            : widget.creditScore >
                                                    580
                                                ? sectionColors[1]
                                                : sectionColors[0],
                              ),
                              textAlign: TextAlign.start),
                          Padding(
                            padding: EdgeInsets.only(
                              top: widget.screenHeightUnit * 32,
                            ),
                            child: Text(
                              '/850',
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenWidthUnit * 30,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(
                width: widget.screenWidthUnit * 50,
              ),
              Padding(
                padding: EdgeInsets.only(top: widget.screenHeightUnit * 40),
                child: Container(
                  height: widget.screenHeightUnit * 80,
                  width: widget.screenWidthUnit * 220,
                  child: SfRadialGauge(
                    animationDuration: 1000,
                    enableLoadingAnimation: true,
                    axes: <RadialAxis>[
                      RadialAxis(
                        showLabels: false,
                        showTicks: false,
                        minimum: min,
                        maximum: max,
                        startAngle: 178,
                        endAngle: 2,
                        radiusFactor:
                            1.75, // Increase the radius factor to make it taller and wider
                        ranges: ranges,
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value: widget.creditScore.toDouble(),
                            needleEndWidth: 5,
                            needleStartWidth: 1,
                            enableAnimation: true,
                            knobStyle: KnobStyle(
                              color: Colors.lightGreen,
                              knobRadius: widget.screenHeightUnit * .45,
                              borderColor: Colors.grey[300],
                              borderWidth: widget.screenHeightUnit * .045,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
