import 'package:flutter/material.dart';

class SimulatorTitle extends StatelessWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final String lifeStyle;

  const SimulatorTitle({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.lifeStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeightUnit * 130,
      width: screenWidthUnit * 470,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: .6,

        ),
      ),
      child: Padding(padding: EdgeInsets.only(left: screenWidthUnit * 20, top: screenHeightUnit * 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lifeStyle,
            style: TextStyle(
              fontSize: screenHeightUnit * 45,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 127, 255, 1),
            ),
          ),
          Text(
            "Lifestyle Indicator",
            style: TextStyle(
              fontSize: screenHeightUnit * 30,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
      ),
     
    );
  }
}