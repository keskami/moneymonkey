import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Pages/results.dart';

class ResultsStyle extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  final List<BudgetingStyle> budgetingStyles;
  final int userStyleIndex = 0;

  BudgetingStyle userStyle = BudgetingStyle(
            title: "The Balanced Budgeter",
            icon: Icons.monitor_heart_rounded,
            description:
                "You made thoughtful, intentional choices. You didn't sacrifice your well-being, and you worked steadily toward your\ngoals. Keep refining your flexibility and continue to build that rainy day fund.");

  ResultsStyle({
    Key? key,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.budgetingStyles,
  }) : super(key: key);

  @override
  _ResultsStyleState createState() => _ResultsStyleState();
}

class _ResultsStyleState extends State<ResultsStyle> {
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.userStyle = widget.budgetingStyles[widget.userStyleIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(50 * widget.screenWidthUnit),
      child: Card(
        elevation: 6.0 * widget.screenHeightUnit,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(20 * widget.screenWidthUnit),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.psychology,
                      size: 36 * widget.screenHeightUnit, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Your Budgeting Style',
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
                color: Colors.blue,
                margin: EdgeInsets.symmetric(vertical: 12),
              ),
              Container(
                padding: EdgeInsets.all(25 * widget.screenWidthUnit),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[100]!, width: .6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(widget.userStyle.icon,
                            size: 36 * widget.screenHeightUnit,
                            color: Colors.black),
                        SizedBox(width: 12 * widget.screenWidthUnit),
                        Text(
                          'You are... ',
                          style: GoogleFonts.baloo2(
                              fontSize: 26 * widget.screenHeightUnit,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          widget.userStyle.title,
                          style: TextStyle(
                              fontSize: 26 * widget.screenHeightUnit,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700]),
                        ),
                        Text(' 🎉',
                            style: TextStyle(
                                fontSize: 26 * widget.screenHeightUnit,
                                color: Colors.black)),
                      ],
                    ),
                    SizedBox(height: 16 * widget.screenHeightUnit),
                    Text(
                      widget.userStyle.description,
                      style: TextStyle(
                        color: Colors.grey[900],
                        height: 1.5,
                        fontSize: 22 * widget.screenHeightUnit,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32 * widget.screenHeightUnit),
              Text(
                'Alternate types include:',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16 * widget.screenHeightUnit),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    for (int i = 0; i < widget.budgetingStyles.length; i++)
                      if (i != widget.userStyleIndex)
                      Padding(padding: EdgeInsets.only(bottom: 20 * widget.screenHeightUnit),
                      
                    child:
                        Container(
                          height: widget.screenHeightUnit * 90,
                          width: widget.screenWidthUnit * 1800,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30 * widget.screenWidthUnit,
                            vertical: 12 * widget.screenHeightUnit,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                widget.budgetingStyles[i].icon,
                                size: widget.screenHeightUnit * 30,
                                color: Colors.black,
                              ),
                              SizedBox(width: 12 * widget.screenWidthUnit),
                              Text(
                                widget.budgetingStyles[i].title,
                                style: GoogleFonts.baloo2(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25 * widget.screenHeightUnit,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
