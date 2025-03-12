import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';

class MonkeyLandingPage extends StatefulWidget {
  final String introText;
  final String imageURL;
  final String title;
  const MonkeyLandingPage({
    super.key, 
    required this.introText, 
    required this.imageURL, 
    required this.title
  });
  
  @override
  _MonkeyLandingPageState createState() => _MonkeyLandingPageState();
}

class _MonkeyLandingPageState extends State<MonkeyLandingPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  final BaseLessonController baseLessonController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    // Responsive layout based on orientation
    return screenWidth > screenHeight
        ? webLayout(screenWidth, screenHeight)
        : mobileLayout(screenWidth, screenHeight);
  }

  Widget webLayout(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.02),
        
        // Title
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        
        SizedBox(height: screenHeight * 0.03),
        
        // Main content
        Container(
          height: screenHeight * 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                
                // Speech bubble with intro text
                Container(
                  width: double.infinity,
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
                  width: double.infinity,
                  child: Center(
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
                ),
                
                // Add padding at the bottom for spacing
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
        
        SizedBox(height: screenHeight * 0.03),
        
        // Continue button with proper centering
        Center(
          child: GestureDetector(
            onTap: () {
              if (baseLessonController.pageIndex.value < baseLessonController.pages.length - 1) {
                baseLessonController.pageIndex.value += 1;
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
    ).paddingSymmetric(horizontal: screenWidth * 0.25); // Key for proper alignment
  }

  Widget mobileLayout(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        
        SizedBox(height: screenHeight * 0.02),
        
        // Main content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                
                // Speech bubble with intro text
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      widget.introText,
                      style: GoogleFonts.baloo2(
                        fontSize: 18,
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
                
                const SizedBox(height: 15),
                
                // Monkey image
                Container(
                  height: 180,
                  width: double.infinity,
                  child: Center(
                    child: Image.network(
                      widget.imageURL,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          width: 180,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Add padding at the bottom for spacing
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        
        // Continue button at the bottom
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: GestureDetector(
              onTap: () {
                if (baseLessonController.pageIndex.value < baseLessonController.pages.length - 1) {
                  baseLessonController.pageIndex.value += 1;
                }
              },
              child: Container(
                height: 50,
                width: screenWidth * 0.7,
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
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20); // Mobile padding
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