import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WellnessBoxNew extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final int score;
  final String type;

  WellnessBoxNew(
      {required this.screenHeightUnit,
      required this.screenWidthUnit,
      required this.score,
      required this.type});

  @override
  _WellnessBoxNewState createState() => _WellnessBoxNewState();
}

class _WellnessBoxNewState extends State<WellnessBoxNew> {
  final List<Color> sectionColors = [
    Colors.red,
    Color.fromRGBO(251, 176, 59, 1),
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    final double min = 0;
    final double max = 100;
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
      height: widget.screenHeightUnit * 180,
      width: widget.screenWidthUnit * 470,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: .6,
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        widget.screenWidthUnit * 16,
                        widget.screenHeightUnit * 4,
                        0,
                        widget.screenHeightUnit * 4),
                    child: Text(
                      "${widget.type}",
                      style: GoogleFonts.baloo2(
                          fontSize: widget.screenHeightUnit * 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    width: widget.screenWidthUnit * 200,
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
                                  widget.screenWidthUnit * 25,
                                  widget.screenHeightUnit * 0,
                                  0,
                                  0),
                              child: Row(
                                children: [
                                  Text('${widget.score}',
                                      style: GoogleFonts.baloo2(
                                        fontSize: widget.screenHeightUnit * 62,
                                        fontWeight: FontWeight.w600,
                                        color: widget.score > 80
                                            ? sectionColors[4]
                                            : widget.score > 60
                                                ? sectionColors[3]
                                                : widget.score > 40
                                                    ? sectionColors[2]
                                                    : widget.score > 20
                                                        ? sectionColors[1]
                                                        : sectionColors[0],
                                      ),
                                      textAlign: TextAlign.start),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: widget.screenHeightUnit * 24,
                                    ),
                                    child: Text(
                                      '/100',
                                      style: GoogleFonts.baloo2(
                                        fontSize: widget.screenHeightUnit * 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                           

                        ],
                      ),
                          
                    ],
                  ),
                  
                ],
              ),
            ),
            Container(
              width: widget.screenWidthUnit * 1,
              height: widget.screenHeightUnit * 180,
              color: Colors.black,
            ),
           
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: widget.screenHeightUnit * 70, left: widget.screenWidthUnit * 30),
                child: Container(
                  height: widget.screenHeightUnit * 110,
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
                            value: widget.score.toDouble(),
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
            )
          ]),
    );
  }
}
