import 'package:flutter/material.dart';

class ResultsImprovement extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final List<String> improvements;

  const ResultsImprovement({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.improvements,
  }) : super(key: key);

  @override
  _ResultsImprovementState createState() => _ResultsImprovementState();
}

class _ResultsImprovementState extends State<ResultsImprovement> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(widget.screenHeightUnit * 50),
      child: Card(
        elevation: widget.screenHeightUnit * 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning, size: 36 * widget.screenHeightUnit, color: Colors.black),
                  SizedBox(width: 12 * widget.screenWidthUnit),
                  Text(
                    'What You Can Work On',
                    style: TextStyle(
                        fontSize: 30 * widget.screenHeightUnit,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 2,
                color: Colors.amber,
                margin: EdgeInsets.symmetric(vertical: 12),
              ),
              Text(
                'Gentle, constructive suggestions for next time:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22 * widget.screenHeightUnit,
                ),
              ),
              SizedBox(height: 22 * widget.screenHeightUnit),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.improvements.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12 * widget.screenHeightUnit),
                    padding: EdgeInsets.all(25 * widget.screenWidthUnit),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning, color: Colors.amber, size: 25 * widget.screenHeightUnit),
                        SizedBox(width: 16 * widget.screenWidthUnit),
                        Expanded(
                          child: Text(
                            widget.improvements[index],
                            style: TextStyle(
                              color: Colors.black,
                              height: 1.4,
                              fontSize: 20 * widget.screenHeightUnit,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}