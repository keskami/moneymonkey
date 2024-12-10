// widgets/grid_screenshot.dart
import 'package:flutter/material.dart';
import 'package:money_monkey/Lesson%20Flow/Models/arrowclipper.dart';
import 'package:money_monkey/home.dart';

class GridScreenshot extends StatelessWidget {
  const GridScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            bool isEven = index % 2 == 0;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment:
                    isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  _buildGridItem(context, index),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    final List<String> images = [
      "assets/images/img_screenshot_2024_08_26.png",
      "assets/images/img_screenshot_2024_08_26_94x110.png",
      "assets/images/img_screenshot_2024_08_26_94x110.png",
      "assets/images/img_treasure_chest.png",
      "assets/images/img_screenshot_2024_08_26_1.png",
    ];

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          _showDialog(context);
        }
      },
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.asset(
          images[index],
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // Show dialog when tapping the banana item
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Dialog content
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Money and Currencies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Subtitle
                    const Text(
                      'Lesson 1 of 4',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Start Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                          // Get.toNamed(AppRoutes.lessonScreen);
                          // Navigator.of(context).pop(); // Close the dialog
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor:
                              const Color(0xFF87CEEB), // Light blue color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Rewards section
                    Row(
                      children: [
                        const Text(
                          'Rewards:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Reward Mystery Icon
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black26, width: 2),
                          ),
                          child: Image.asset(
                            'assets/images/rewardmonkey.png',
                            //height: 30, // Your mystery icon path
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Banana Reward
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/rewardbanana.png', // Your banana reward icon path
                              height: 40,
                            ),
                            const SizedBox(width: 4),
                            // Text(
                            //   '10',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 18,
                            //     color: Colors.black,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow pointing up
              Positioned(
                top: -12,
                left: 110,
                child: ClipPath(
                  clipper: ArrowClipper(),
                  child: Container(
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
