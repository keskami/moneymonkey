import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsStrengthScreen extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  final List<String> strengths;

  const ResultsStrengthScreen({
    Key? key,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.strengths,
  }) : super(key: key);

  @override
  _ResultsStrengthScreenState createState() => _ResultsStrengthScreenState();
}

class _ResultsStrengthScreenState extends State<ResultsStrengthScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(50 * widget.screenWidthUnit),
      child: Card(
        elevation: 6 * widget.screenHeightUnit,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(20 * widget.screenWidthUnit),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, size: 36 * widget.screenHeightUnit, color: Colors.black),
                  SizedBox(width: 12 * widget.screenWidthUnit),
                  Text(
                    'What You Did Well',
                    style: GoogleFonts.baloo2(
                        fontSize: 30 * widget.screenHeightUnit,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 2,
                color: Colors.green,
                margin: EdgeInsets.symmetric(vertical: 16 * widget.screenHeightUnit),
              ),
              Text(
                'Personalized bullet points summarizing strong habits:',
                style: GoogleFonts.baloo2(
                  color: Colors.grey[600],
                  fontSize: 22 * widget.screenHeightUnit,
                ),
              ),
              SizedBox(height: 22 * widget.screenHeightUnit),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.strengths.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16 * widget.screenHeightUnit),
                    padding: EdgeInsets.all(25 * widget.screenWidthUnit),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
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
                        Icon(Icons.check_circle, color: Colors.green, size: 28 * widget.screenHeightUnit),
                        SizedBox(width: 16 * widget.screenWidthUnit),
                        Expanded(
                          child: Text(
                            widget.strengths[index],
                            style: GoogleFonts.baloo2(
                              color: Colors.grey[800],
                              height: 1.4,
                              fontSize: 22 * widget.screenHeightUnit,
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