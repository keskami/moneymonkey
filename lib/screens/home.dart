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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String? userID;
  late AnimationController _chestAnimationController;
late ProgressController progressController;
late ScrollController _scrollController;
String  _titleText = "Earning and Saving";
int _currentSection = 1;
 bool _isAnimationControllerInitialized = false;

   @override
void initState() {
  super.initState();
  _scrollController = ScrollController()..addListener(_onScroll);
  progressController = Get.put(ProgressController());
  _chestAnimationController = AnimationController(
    duration: const Duration(seconds: 2), // Slower duration for testing
    vsync: this,
     lowerBound: 1.0, // Start scale at 1.0 to ensure the chest is visible initially
  upperBound: 1.5, // Scale up to 1.5 when animated
  )..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
     // _chestAnimationController.reset(); // Reset after animation completes
    }
  })..addListener(() {
    print("Animation progress: ${_chestAnimationController.value}");
  });
  _isAnimationControllerInitialized = true;
}
  void _onScroll() {
    double offset = _scrollController.offset;
    int newSection = (offset / 300).floor() + 1; // Adjust 300 as per the height of each section

    if (newSection != _currentSection) {
      setState(() {
        _currentSection = newSection;
        if (_currentSection == 1) {
          _titleText = "Earning and Saving";
        } else if (_currentSection == 2) {
          _titleText = "Buying Assets";
        } else if (_currentSection == 3) {
          _titleText = "Buy Stocks";
        }
      });
    }
  }

    @override
  void dispose() {
    _scrollController.dispose();
     if (_isAnimationControllerInitialized) {
      _chestAnimationController.dispose(); // Dispose only if initialized
    }
    super.dispose();
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
              CardTitle(unitNumber: _currentSection,titleText: _titleText,),
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

  final int itemsPerSection = images.length;
  final int numberOfSections = 3;

  return Expanded(
    child: LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        // Use the original values for scaling
        double horizontalOffsetLeft = screenWidth * 0.3; // Original left offset
        double horizontalOffsetRight = screenWidth * 0.2; // Original right offset
        double verticalSpacing = screenHeight * 0.02; // Original vertical spacing
        double imageWidth = screenWidth * 0.3; // Original image width scaling
        double imageHeight = screenHeight * 0.2; // Original image height scaling

        return ListView.builder(
          controller: _scrollController,
          itemCount: numberOfSections * (itemsPerSection + 1),
          itemBuilder: (context, index) {
            bool isHeader = index % (itemsPerSection + 1) == 0;
            int sectionIndex = index ~/ (itemsPerSection + 1);
            int itemIndex = index % (itemsPerSection + 1) - 1;

            if (isHeader) {
              // Render the section header
              return _buildSectionHeader("Section ${sectionIndex + 1}");
            } else if (itemIndex >= 0 && itemIndex < images.length) {
              bool isLeftAligned = itemIndex % 2 == 0;
              bool isEnabled = itemIndex <= progressController.currentLessonIndex.value;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: Row(
                  mainAxisAlignment: isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: isLeftAligned ? horizontalOffsetLeft : 0,
                        right: isLeftAligned ? 0 : horizontalOffsetRight,
                      ),
                      child: GestureDetector(
                        onTap: isEnabled ? () {

                                 // Debugging: Check if the item is enabled
    print("ItemIndex: $itemIndex, isEnabled: $isEnabled");

    // Debugging: Check the current lesson index value
    print("Current lesson index: ${progressController.currentLessonIndex.value}");

                                if (itemIndex == 3 && 
                                    progressController.currentLessonIndex.value >= 3) {
                                  // Play the animation if the treasure chest is reached
                                 // print("ItemIndex: $itemIndex, isEnabled: $isEnabled");
                                  print("bruhhhh");
                                  _chestAnimationController.forward();
                                } else if (itemIndex != 3) {
                                  _showDialog(context, itemIndex, Offset.zero); // For regular items
                                }
                              } : null,
                        child: Opacity(
                          opacity: isEnabled ? 1.0 : 0.5,
                          child:
                          itemIndex==3 && _isAnimationControllerInitialized? ScaleTransition(scale: _chestAnimationController,child: Image.asset(
                                    images[itemIndex],
                                    width: imageWidth,
                                    height: imageHeight,),):
                           Image.asset(
                            images[itemIndex],
                            width: imageWidth,
                            height: imageHeight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox.shrink();
            }
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
Widget _buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: 10, // Space between divider and text
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 10, // Space between text and divider
          ),
        ),
      ],
    ),
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
