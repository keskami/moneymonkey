import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/home.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CelebrationScreen extends StatelessWidget {
  const CelebrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007FFF), // Purple background
      body: SafeArea(
        child: Stack(
          children: [
            // main content (centered vertically, no scrolling)
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
            // Celebration title
            const Text(
              '🎉 Lesson Complete! 🎉',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // Celebration GIF in the center
// ...existing code...
            // Celebration GIF in the center
            Center(
              child: Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                // inner content is centered and square (no shadow on the GIF itself)
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 300, // square GIF
                      height: 300,
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Gifs%2Fcelebration_animation_GIF.gif?alt=media&token=10d648af-02e3-4c34-8672-71d38133adfa',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.celebration,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
// ...existing code...
            
            const SizedBox(height: 40),
            
            // Bananas earned box
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF8BC34A), // Green background
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF689F38), // Darker green border
                  width: 3,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'BANANAS EARNED',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '🍌',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '10',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),

            // Positioned finish button at bottom-right
            Positioned(
              right: 20,
              bottom: 20,
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightTheme().pastelGreen,
                  padding: EdgeInsets.zero,
                ),
                child: CustomNextButton(
                  nextPage: () {
                    if (Get.isRegistered<BaseLessonController>()) {
                      Get.delete<BaseLessonController>();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }, // visual only; action handled by ElevatedButton
                  isEnabled: true,
                  text: "Finish",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}