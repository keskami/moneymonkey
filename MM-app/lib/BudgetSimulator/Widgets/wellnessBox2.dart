import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WellnessBox2 extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
   int wellnessScore;

  WellnessBox2(
      {required this.screenHeightUnit,
      required this.screenWidthUnit,
      required this.wellnessScore});

  @override
  _WellnessBox2State createState() => _WellnessBox2State();
}

class _WellnessBox2State extends State<WellnessBox2> {
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
    final double max = 1000;
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
      height: widget.screenHeightUnit * 260,
      width: widget.screenWidthUnit * 440,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(widget.screenWidthUnit * 20,
                widget.screenHeightUnit * 8, 0, widget.screenHeightUnit * 8),
            child: Text(
              "Wellness Score",
              style: GoogleFonts.baloo2(
                  fontSize: widget.screenHeightUnit * 38,
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
                      padding: EdgeInsets.fromLTRB(widget.screenWidthUnit * 25,
                          widget.screenHeightUnit * 15, 0, 0),
                      child: Row(
                        children: [
                          Text('${widget.wellnessScore}',
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenWidthUnit * 54,
                                fontWeight: FontWeight.w600,
                                color: widget.wellnessScore >
                                        ((max - min) / numberOfSections) * 4
                                    ? sectionColors[4]
                                    : widget.wellnessScore >
                                            ((max - min) / numberOfSections) * 3
                                        ? sectionColors[3]
                                        : widget.wellnessScore >
                                                ((max - min) /
                                                        numberOfSections) *
                                                    2
                                            ? sectionColors[2]
                                            : widget.wellnessScore >
                                                    ((max - min) /
                                                            numberOfSections) *
                                                        1
                                                ? sectionColors[1]
                                                : sectionColors[0],
                              ),
                              textAlign: TextAlign.start),
                          Padding(
                            padding: EdgeInsets.only(
                              top: widget.screenHeightUnit * 34,
                            ),
                            child: Text(
                              '/1000',
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenWidthUnit * 34,
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
                width: widget.screenWidthUnit * 30,
              ),
              Padding(
                padding: EdgeInsets.only(top: widget.screenHeightUnit * 70),
                child: Container(
                  height: widget.screenHeightUnit * 115,
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
                            value: widget.wellnessScore.toDouble(),
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
