import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalReflection extends StatefulWidget {
  final double height;
  final double width;

  final TextEditingController textController;
  final String reflectionType;

  FinalReflection({
    Key? key,
    required this.height,
    required this.width,
    required this.reflectionType,

    required this.textController,
  }) : super(key: key);

  @override
  _FinalReflectionState createState() => _FinalReflectionState();
}

class _FinalReflectionState extends State<FinalReflection> {


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
              '${widget.reflectionType} Reflection',
              style: GoogleFonts.baloo2(
                fontSize: widget.height * 42,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: widget.height * 20),
            Text(
              "Reflect on your experience with this lesson. What did you learn? How did you feel?",
              style: GoogleFonts.baloo2(
                fontSize: widget.height * 29,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: widget.height * 25),
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
                controller: widget.textController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(widget.width * 20),
                  border: InputBorder.none,
                  hintText: widget.textController.text.isEmpty ? "Type your reflection here..." : widget.textController.text,
                  hintStyle: GoogleFonts.baloo2(
                    fontSize: widget.height * 26,
                    color: widget.textController.text.isEmpty ? Colors.grey: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: widget.height * 30),
            GestureDetector(
              onTap: () {
                // Save to database logic here
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
                    'Save Reflection',
                    style: GoogleFonts.baloo2(
                      fontSize: widget.height * 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}