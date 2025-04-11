import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsReflection extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final TextEditingController _reflectionController = TextEditingController();
  String reflectionText;

  ResultsReflection({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.reflectionText,
  

  }) : super(key: key);

  @override
  _ResultsReflectionState createState() => _ResultsReflectionState();
}

class _ResultsReflectionState extends State<ResultsReflection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(widget.screenHeightUnit * 50),
      child: Card(
        elevation: widget.screenHeightUnit * 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(widget.screenWidthUnit * 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.edit, size: widget.screenHeightUnit * 36, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Your Reflection',
                    style: TextStyle(
                        fontSize: widget.screenHeightUnit * 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Container(
                width: 80 * widget.screenWidthUnit,
                height: 3 * widget.screenHeightUnit,
                color: Colors.purple,
                margin: EdgeInsets.symmetric(vertical: widget.screenHeightUnit * 18),
              ),
              Container(
                padding: EdgeInsets.all(widget.screenWidthUnit * 26),
                margin: EdgeInsets.only(bottom: widget.screenHeightUnit * 20),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '"Now that you\'ve seen your results, take a moment to reflect. What did you learn about your money habits? What would you do differently next time?"',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                    height: 1.5,
                    fontSize: widget.screenHeightUnit * 20,
                  ),
                ),
              ),
              Stack(
                children: [
                  TextField(
                    maxLength: 200,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write your reflection here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      contentPadding: EdgeInsets.all(widget.screenWidthUnit * 20),
                      counterText: '',
                    ),
                    onChanged: _handleReflectionChange,
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10 * widget.screenWidthUnit, vertical: 6 * widget.screenHeightUnit),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Text(
                        '${widget.reflectionText.length}/200',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16 * widget.screenHeightUnit,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 * widget.screenHeightUnit),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit, size: 30 * widget.screenHeightUnit, color: Colors.white),
                label: Text('Save Reflection',style: GoogleFonts.baloo2(fontSize: 24 * widget.screenHeightUnit, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 28 * widget.screenWidthUnit, vertical: 16 * widget.screenHeightUnit),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _handleReflectionChange(String value) {
    if (value.length <= 200) {
      setState(() {
        widget.reflectionText = value;
      });
    }
  }
}

