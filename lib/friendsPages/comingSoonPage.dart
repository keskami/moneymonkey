import 'package:flutter/material.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({super.key});

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Set a background color
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/monkey.png',
              height: screenHeight / 2,
              width: screenWidth / 2,
            ),
            Text(
              "Coming Soon",
              style: TextStyle(
                fontSize: 24 * (screenWidth / 390), // Responsive font size
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            const SizedBox(height: 10), // Add spacing
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20 * (screenWidth / 390)),
              child: Text(
                "Stay tuned for updates! We are working hard to bring you this feature.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16 * (screenWidth / 390), // Responsive font size
                  color: Colors.grey[700], // Subtle text color
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        padding: EdgeInsets.only(top: 20),
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 40,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
