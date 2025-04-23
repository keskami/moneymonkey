import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetAGoalWidget extends StatefulWidget {
  final double height;
  final double width;
  final String goalName;
  final String hintText;
  final TextEditingController goalController;
  String goalLength;
  final dynamic Widget;

   SetAGoalWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.goalName,
    required this.hintText,
    required this.goalController,
    required this.goalLength,
    required this.Widget,
  }) : super(key: key);

  @override
  _SetAGoalWidgetState createState() => _SetAGoalWidgetState();
}

class _SetAGoalWidgetState extends State<SetAGoalWidget> {
  

  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 1000,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.25,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: widget.width * 30,
          top: widget.height * 50,
          right: widget.width * 30,
          bottom: widget.height * 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Set a ${widget.goalName} Goal',
              style: GoogleFonts.baloo2(
                fontSize: widget.height * 42,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: widget.height * 20),
            Text(
              "Set a specific, measurable ${widget.goalName} goal that aligns with your personal values. Be as specific as possible about what you want to achieve.",
              style: GoogleFonts.baloo2(
                fontSize: widget.height * 29,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: widget.height * 25),
            Text(
              'My ${widget.goalName} Goal is to:',
              style: GoogleFonts.baloo2(
                fontSize: widget.height * 29,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: widget.height * 2),
            Container(
              width: double.infinity,
              height: widget.height * 200,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
              ),
              child: TextField(
              controller: widget.goalController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(widget.width * 20),
                border: InputBorder.none,
                hintText: widget.goalController.text.isNotEmpty
                  ? widget.goalController.text
                  : widget.hintText,
                hintStyle: GoogleFonts.baloo2(
                fontSize: widget.height * 26,
                color: widget.goalController.text.isNotEmpty
                  ? Colors.black: Colors.grey,
                ),
              ),
              ),
            ),
            
            SizedBox(height: widget.height * 30),
            widget.Widget.goalLength == "3 Months"
                ? Text(
                    'I plan to accomplish this in:',
                    style: GoogleFonts.baloo2(
                      fontSize: widget.height * 29,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  )
                : Text(
                    'I plan to accomplish this in a:',
                    style: GoogleFonts.baloo2(
                      fontSize: widget.height * 29,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
            SizedBox(height: widget.height * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.Widget.goalLength = "Week";
                    });
                  },
                  child: Container(
                    width: widget.width * 220,
                    height: widget.height * 70,
                    decoration: BoxDecoration(
                      color: widget.Widget.goalLength == "Week"
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(212, 212, 212, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Week',
                        style: GoogleFonts.baloo2(
                          fontSize: widget.height * 32,
                          color: widget.Widget.goalLength == "Week"
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.Widget.goalLength  = "Month";
                    });
                  },
                  child: Container(
                    width: widget.width * 220,
                    height: widget.height * 70,
                    decoration: BoxDecoration(
                      color: widget.Widget.goalLength == "Month"
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(212, 212, 212, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Month',
                        style: GoogleFonts.baloo2(
                          fontSize: widget.height * 32,
                          color: widget.Widget.goalLength == "Month"
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.Widget.goalLength = "3 Months";
                    });
                  },
                  child: Container(
                    width: widget.width * 220,
                    height: widget.height * 70,
                    decoration: BoxDecoration(
                      color: widget.Widget.goalLength == "3 Months"
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(212, 212, 212, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '3 Months',
                        style: GoogleFonts.baloo2(
                          fontSize: widget.height * 32,
                          color: widget.Widget.goalLength == "3 Months"
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.Widget.goalLength  = "Year";
                    });
                  },
                  child: Container(
                    width: widget.width * 220,
                    height: widget.height * 70,
                    decoration: BoxDecoration(
                      color: widget.Widget.goalLength == "Year"
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(212, 212, 212, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Year',
                        style: GoogleFonts.baloo2(
                          fontSize: widget.height * 32,
                          color: widget.Widget.goalLength == "Year"
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.height * 30),
            GestureDetector(
                onTap: () {

                  ///SAVE TO DATABASE HERE

                },
                child: Container(
                  width: double.infinity,
                  height: widget.height * 80,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 127, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Save Goal',
                      style: GoogleFonts.baloo2(
                        fontSize: widget.height * 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
