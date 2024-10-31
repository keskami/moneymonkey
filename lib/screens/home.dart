import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';
import 'package:moneymonkey/models/arrowclipper.dart';
import 'package:moneymonkey/routes/app_routes.dart';
import 'package:moneymonkey/widgets/card_title.dart';
//import 'package:moneymonkey/widgets/grid_screenshot.dart';
import 'package:moneymonkey/widgets/top_bar.dart';

class HomePage extends StatefulWidget {
  
  
    HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userID;
late ProgressController progressController;
    @override
  void initState() {
    super.initState();
    // Initialize ProgressController
    progressController = Get.put(ProgressController());
  }
   int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
            TopBar(userId: 'userID',progressController: progressController),
              const SizedBox(height: 16),
              CardTitle(),
              const SizedBox(height: 20),
             // _buildGridScreenshot(context)
             _buildZigzagGrid()
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  

  



Widget _buildZigzagGrid() {
  final List<String> images = [
    "assets/images/img_screenshot_2024_08_26.png",  // First item
    "assets/images/img_screenshot_2024_08_26_94x110.png", // Second item
    "assets/images/img_screenshot_2024_08_26_94x110.png", // Third item
    "assets/images/img_treasure_chest.png",         // Fourth item
    "assets/images/img_screenshot_2024_08_26_1.png",        // Fifth item
  ];

  return Expanded(
    child: LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        // Scale values based on screen width and height
        double horizontalOffsetLeft = screenWidth * 0.3; // Adjust as needed
        double horizontalOffsetRight = screenWidth * 0.2; // Adjust as needed
        double verticalSpacing = screenHeight * 0.02; // 2% of screen height
        double imageWidth = screenWidth * 0.3; // 20% of screen width
        double imageHeight = screenHeight * 0.2; // 10% of screen height

        return ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            bool isLeftAligned = index % 2 == 0;
             bool isEnabled = index <= progressController.currentLessonIndex.value;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: verticalSpacing),
              child: Row(
                mainAxisAlignment:
                    isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: isLeftAligned ? horizontalOffsetLeft : 0,
                      right: isLeftAligned ? 0 : horizontalOffsetRight,
                    ),
                    child: GestureDetector(
                      onTapDown: isEnabled ? (TapDownDetails details) {
                        // Call the _showDialog function when the icon is tapped
                        _showDialog(context,index,details.globalPosition);
                      }:null,
                      child: Opacity(
                        opacity: isEnabled ? 1.0 : 0.5,
                        child: Image.asset(
                          images[index],
                          width: imageWidth,
                          height: imageHeight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
  );
}







      
       





  // Show dialog when tapping the banana item
// void _showDialog(BuildContext context,int index) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
        
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title
//                   Text(
//                     'Money and Currencies',
//                     style: TextStyle(
//                       fontFamily: "Baloo2",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
                  
              
//                    Text(
//                     'Lesson ${index + 1} of 4',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
                  
         
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Get.toNamed(AppRoutes.lessonScreen);
//                        // Navigator.of(context).pop(); // Close the dialog
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 12), 
//                         backgroundColor: const Color(0xFF87CEEB),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Start',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
                  
           
//                   Row(
//                     children: [
//                       const Text(
//                         'Rewards:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: Colors.green,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
                      
//                       // Reward Mystery Icon
//                       Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.black26, width: 2),
//                         ),
//                         child: Image.asset(
//                           'assets/images/rewardmonkey.png',
//                           //height: 30, // Your mystery icon path
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
                      
//                       // Banana Reward
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/images/rewardbanana.png', 
//                             height: 40,
//                           ),
//                           const SizedBox(width: 4),
                       
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
       
//             Positioned(
//               top: -12,
//               left: 90,
//               child: ClipPath(
//                 clipper: ArrowClipper(),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }



void _showDialog(BuildContext context, int index, Offset position) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double horizontalPadding = (screenWidth - 250) / 2;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
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
                  Text(
                    'Money and Currencies',
                    style: TextStyle(
                      fontFamily: "Baloo2",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lesson ${index + 1} of 4',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.lessonScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: const Color(0xFF87CEEB),
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
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black26, width: 2),
                        ),
                        child: Image.asset(
                          'assets/images/rewardmonkey.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/rewardbanana.png',
                            height: 40,
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -12,
              left: screenWidth / 2 - horizontalPadding,
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


 Widget _buildBottomBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex, 
      onTap: (index) {
        setState(() {
          _currentIndex = index; 
        });
      },
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed, // Fixed items
      selectedItemColor: Colors.blue, // Color for the selected item
      unselectedItemColor: Colors.grey, // Color for unselected items
      showSelectedLabels: false, // Hide the labels
      showUnselectedLabels: false, 
      items: [
        _buildNavItem('assets/images/globemonkey.png', 0),
        _buildNavItem('assets/images/treasure.png', 1),
        _buildNavItem('assets/images/bottommonkey.png', 2),
        _buildNavItem('assets/images/bluemonkey.png', 3),
      ],
    );
  }

  // Build each navigation item with custom behavior for selected state
  BottomNavigationBarItem _buildNavItem(String iconPath, int index) {
     final screenSize = MediaQuery.of(context).size;
  double iconSize = screenSize.width * 0.13; // Make icons 10% of screen width

    return BottomNavigationBarItem(
      icon: Container(
        width: iconSize,
      
        height: iconSize,
        decoration: BoxDecoration(
          border: _currentIndex == index
              ? Border.all(color: Colors.blue, width: 3) // Border for the selected item
              : null,
          borderRadius: BorderRadius.circular(12), 
        ),
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
        ),
      ),
      label: '', // No label
    );
  }
}
