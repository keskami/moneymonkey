import 'package:flutter/material.dart';

class LessonCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Wrapping the Stack in a SizedBox with height constraint
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6, // Limit the height to 60% of the screen height
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none, // Allow overflow
                children: [
                  // Full hanging image with ropes
                  Positioned(
                    top: 0, // Start the ropes from the top of the screen
                    child: Image.asset(
                      'assets/images/hang.png', // Your image with ropes
                     // width: MediaQuery.of(context).size.width * 0.9, // Adjust size to fill 90% width
                     height: 598
            ,
                      width: 598, // Specify a fixed width, e.g., 400 pixels
  
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Position stars inside the image
                  Positioned(
                    top: 300, // Adjust to control the stars' vertical position
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/star.png', // Replace with correct path
                          height: 60, // Size of the stars
                        ),
                        SizedBox(width: 10), // Space between stars
                        Image.asset(
                          'assets/images/star.png', // Replace with correct path
                          height: 60,
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          'assets/images/star.png', // Replace with correct path
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                  // Place Lesson Complete text between ropes and stars
                  Positioned(
                    top: 60, // Adjust to control vertical position of the text
                    child: Text(
                      "Lesson\n Complete!",
                      style: TextStyle(
                        fontFamily: "Baloo 2",
                        fontSize: 40, // Larger text size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Center the Continue button within the image
                  Positioned(
                    bottom: 90, // Adjust to place the button inside the image
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your continue button logic
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        backgroundColor: Color(0xFF87CEEB), // Light blue button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontFamily: "Baloo 2",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80), // Adjust height to position the bottom icons better
            // Banana and treasure images at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Add action for banana
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/bigbanana.png', // Replace with correct path
                      height: 90, // Larger images
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // Add action for treasure chest
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/bigtreasure.png', // Replace with correct path
                      height: 90, // Larger images
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
