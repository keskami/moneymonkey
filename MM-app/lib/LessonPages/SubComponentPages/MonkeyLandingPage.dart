import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';

class MonkeyLandingPage extends StatefulWidget {
  final String introText;
  final String imageURL;
  const MonkeyLandingPage({super.key, required this.introText, required this.imageURL});
  
  @override
  _MonkeyLandingPageState createState() => _MonkeyLandingPageState();
}

class _MonkeyLandingPageState extends State<MonkeyLandingPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  final StoryController storyController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      width: screenWidth * 0.7,
      // Use full remaining height of the screen to let the Stack expand
      height: screenHeight * 0.7, 
      color: Colors.white,
      child: Column(
        children: [
          // Main content that takes all available space except button height
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  
                  // Speech bubble with intro text
                  Container(
                    width: screenWidth * 0.7,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        widget.introText,
                        style: GoogleFonts.baloo2(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  
                  // Triangle pointer for speech bubble
                  Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    child: CustomPaint(
                      painter: TrianglePainter(),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Monkey image
                  Container(
                    height: 200,
                    child: Image.network(
                      widget.imageURL,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: 200,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Add padding at the bottom for spacing
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          
          // Continue button at the bottom of the screen
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () {
                if (storyController.pageIndex.value < storyController.pages.length - 1) {
                  storyController.pageIndex.value += 1;
                }
              },
              child: Container(
                height: 56,
                width: screenWidth * 0.4,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(137, 220, 142, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Continue",
                    style: GoogleFonts.baloo2(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the speech bubble triangle pointer
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}