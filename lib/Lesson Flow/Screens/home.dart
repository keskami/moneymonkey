import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/Models/arrowclipper.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';
import 'package:money_monkey/Lesson Flow/widgets/card_title.dart';
//import 'package:moneymonkey/widgets/grid_screenshot.dart';
import 'package:money_monkey/Lesson Flow/widgets/top_bar.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/lessonpage.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String? userID;
  late AnimationController _chestAnimationController;
  late ProgressController progressController;
  late ScrollController _scrollController;
  Color _titleColor = const Color(0xFFC8A2C8);
  int _currentSection = 1;
  bool _isAnimationControllerInitialized = false;
  // List of GlobalKeys for each section
  final List<GlobalKey> sectionKeys = List.generate(3, (_) => GlobalKey());
  double? heightSection1, heightSection2, heightSection3;
  @override
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    progressController = Get.put(ProgressController());
    progressController.fetchUnitTitle('unit1');
    print(
        "Initial lesson index: ${progressController.currentLessonIndex.value}");
    _chestAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _chestAnimationController.reset();
        }
      });
    _isAnimationControllerInitialized = true;

    // Calculate section heights once the layout is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        heightSection1 = getSectionHeight(0);
        heightSection2 = heightSection1! + getSectionHeight(1);
        heightSection3 = heightSection2! + getSectionHeight(2);
        print("Height of Section 1: $heightSection1");
        print("Height of Section 2: $heightSection2");
        print("Height of Section 3: $heightSection3");
      });
    });
  }

  double getSectionHeight(int sectionIndex) {
    final renderBox = sectionKeys[sectionIndex]
        .currentContext
        ?.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 0;
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    int newSection = (offset / 800).floor() +
        1; // Adjust 300 as per the height of each section

    if (newSection != _currentSection) {
      setState(() {
        _currentSection = newSection;
        switch (_currentSection) {
          case 1:
            progressController.unitTitle.value = "Introduction to Money";
            _titleColor = const Color(0xFFC8A2C8);
            break;
          case 2:
            progressController.unitTitle.value = "Saving and Spending Basics";
            _titleColor = const Color(0xFFFF6B6B1);
            break;
          case 3:
            progressController.unitTitle.value = "Understanding Banks";
            _titleColor = const Color(0xFFA97436);
            break;
          default:
            progressController.unitTitle.value = "Unknown";
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
    progressController.dispose();
    super.dispose();
  }

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
              TopBar(userId: 'userID', progressController: progressController),
              const SizedBox(height: 16),
              Obx(() => CardTitle(
                    unitNumber: _currentSection,
                    titleText: progressController.unitTitle.value.isNotEmpty
                        ? progressController.unitTitle.value
                        : "Unknown",
                    color: _titleColor,
                  )),
              const SizedBox(height: 20),
              // _buildGridScreenshot(context)
              _buildZigzagGrid()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZigzagGrid() {
    final List<String> images = [
      "assets/images/img_screenshot_2024_08_26.png", // First item
      "assets/images/img_screenshot_2024_08_26_94x110.png", // Second item
      "assets/images/img_screenshot_2024_08_26_94x110.png", // Third item
      "assets/images/img_treasure_chest.png", // Fourth item
      "assets/images/img_screenshot_2024_08_26_1.png", // Fifth item
    ];

    final int itemsPerSection = images.length;
    final int numberOfSections = 3;

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          // Define offsets and spacing based on screen dimensions
          double horizontalOffsetLeft = screenWidth * 0.3;
          double horizontalOffsetRight = screenWidth * 0.2;
          double verticalSpacing = screenHeight * 0.019;

          return ListView.builder(
            controller: _scrollController,
            itemCount: numberOfSections * (itemsPerSection + 1),
            itemBuilder: (context, index) {
              bool isHeader = index % (itemsPerSection + 1) == 0;
              int sectionIndex = index ~/ (itemsPerSection + 1);
              int itemIndex = index % (itemsPerSection + 1) - 1;

              if (isHeader) {
                // Render the section header
                return _buildSectionHeader(sectionIndex);
              } else if (itemIndex >= 0 && itemIndex < images.length) {
                bool isLeftAligned = itemIndex % 2 == 0;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                  child: Row(
                    mainAxisAlignment: isLeftAligned
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: isLeftAligned ? horizontalOffsetLeft : 0,
                          right: isLeftAligned ? 0 : horizontalOffsetRight,
                        ),
                        child: _buildImageItem(
                            itemIndex, images[itemIndex], sectionIndex),
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

  bool _isLessonEnabled(int itemIndex, int sectionIndex) {
    int itemsPerSection = 5;

    // Calculate the start and end indices for the current section
    int startLessonIndexForSection = sectionIndex * itemsPerSection;

    // For the first section (Section 1)
    if (sectionIndex == 0) {
      if (itemIndex == 3) {
        // Enable the chest (index 3) if the third lesson (index 2) is completed
        return progressController.currentLessonIndex.value >= 2;
      } else if (itemIndex == 4) {
        // Enable the fourth lesson (index 4) if the chest (index 3) is completed
        return progressController.currentLessonIndex.value >= 3;
      } else {
        // Enable items if they are less than or equal to the current lesson index
        return itemIndex <= progressController.currentLessonIndex.value;
      }
    }

    // For subsequent sections (Section 2 and beyond)
    bool previousSectionLastLessonCompleted =
        progressController.currentLessonIndex.value >=
            (sectionIndex * itemsPerSection - 1);

    // Enable the first lesson of the new section if the last lesson of the previous section is completed
    if (itemIndex == 0) {
      return previousSectionLastLessonCompleted;
    }

    // Enable the current item if the previous item in the section is completed
    return progressController.currentLessonIndex.value >=
        (startLessonIndexForSection + itemIndex - 1);
  }

  Widget _buildImageItem(int itemIndex, String imagePath, int sectionIndex) {
    bool isEnabled = _isLessonEnabled(itemIndex, sectionIndex);
    GlobalKey iconKey = GlobalKey();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double iconWidth = screenWidth * 0.27;
    double iconHeight = screenHeight * 0.12;

    // Use treasure_chest image specifically for the fourth item in each section
    String displayImage = itemIndex == 3
        ? 'assets/images/img_treasure_chest.png' // Use treasure chest for the fourth item
        : isEnabled
            ? 'assets/images/img_screenshot_2024_08_26.png' // Completed icon for other enabled items
            : imagePath; // Original image path for incomplete items

    return GestureDetector(
      key: iconKey,
      onTap: isEnabled
          ? () {
              // RenderBox renderBox = context.findRenderObject() as RenderBox;
              // Offset position = renderBox.localToGlobal(Offset.zero);
              if (itemIndex == 3 &&
                  progressController.currentLessonIndex.value >= 3) {
                // _chestAnimationController.forward();
                if (!progressController.isChestOpened.value) {
                  _showFloatingGif(context);
                }
              } else if (itemIndex != 3) {
                _showDialog(context, itemIndex, iconKey, _scrollController);
              }
            }
          : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Image.asset(
          displayImage,
          width: iconWidth, // Set size as needed
          height: iconHeight,
        ),
      ),
    );
  }

  void _showFloatingGif(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Image.asset(
          'assets/images/Treasure_chest.gif',
          width: screenWidth * 0.8,
          height: screenHeight * 0.8,
          fit: BoxFit.contain,
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    // Optionally remove the overlay after a duration
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
      // progressController.moveToNextLesson();
      progressController.isChestOpened.value = true; // Mark the chest as opened
      progressController.update();
    });
  }

  void _showDialog(BuildContext context, int index, GlobalKey iconKey,
      ScrollController scrollController) async {
    // Calculate the position of the icon on the screen
    RenderBox renderBox =
        iconKey.currentContext?.findRenderObject() as RenderBox;
    Offset iconPosition = renderBox.localToGlobal(Offset.zero);
    final double iconHeight = renderBox.size.height;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double dialogWidth = screenWidth * 0.7;
    double padding = screenWidth * 0.027;
    double iconSize = screenWidth * 0.13;
    double buttonHeight = screenHeight * 0.01;
    double buttonWidth = dialogWidth * 0.9;
    double arrowHeight = screenHeight * 0.015;
    double textFontSize = screenWidth * 0.04;
    double rewardFontSize = screenWidth * 0.038;

    //final ScrollController scrollController = Scrollable.of(context)?.widget.controller ?? ScrollController();
    final double bottomPadding = screenHeight *
        0.4; // Adjust this based on the height of the bottom navigation bar and dialog

    if (iconPosition.dy + iconHeight + bottomPadding > screenHeight) {
      // Scroll up to make space for the dialog
      scrollController.animateTo(
        scrollController.offset +
            (iconPosition.dy + iconHeight + bottomPadding - screenHeight),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      await Future.delayed(const Duration(milliseconds: 300));
      renderBox = iconKey.currentContext?.findRenderObject() as RenderBox;
      iconPosition = renderBox.localToGlobal(Offset.zero);
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: iconPosition.dx -
                  dialogWidth / 3, // Adjusted to center the dialog
              top: iconPosition.dy + iconHeight - 50, // Positioned above icon
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    ClipPath(
                      clipper: ArrowClipper(),
                      child: Container(
                        height: arrowHeight,
                        width: dialogWidth * 0.14, // Relative width for arrow
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: dialogWidth,
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
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
                              fontSize: textFontSize,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: padding / 2),
                          Text(
                            'Lesson ${index + 1} of 4',
                            style: TextStyle(
                              fontSize: rewardFontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Baloo2",
                            ),
                          ),
                          SizedBox(height: padding),
                          SizedBox(
                            width: buttonWidth,
                            child: ElevatedButton(
                              onPressed: () async {
                                final ProgressController progressController =
                                    Get.find<ProgressController>();
                                progressController.progress.value = 0.0;
                                progressController.progress.refresh();
                                print(
                                    "Progress reset to: ${progressController.progress.value}");

                                // Force a UI update before navigating
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonPage(),
                                  ),
                                );
                                // Get.toNamed(AppRoutes.lessonScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: buttonHeight * 0.6),
                                backgroundColor: const Color(0xFF87CEEB),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.03),
                                ),
                              ),
                              child: Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  color: Colors.white,
                                  fontFamily: "Baloo2",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: padding),
                          Row(
                            children: [
                              Text(
                                'Rewards:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: rewardFontSize,
                                  color: Colors.green,
                                  fontFamily: "Baloo2",
                                ),
                              ),
                              SizedBox(width: padding / 2),
                              Container(
                                width: iconSize,
                                height: iconSize,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.02),
                                  border: Border.all(
                                      color: Colors.black26,
                                      width: screenWidth * 0.005),
                                ),
                                child: Image.asset(
                                  'assets/images/rewardmonkey.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: padding),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/rewardbanana.png',
                                    height: iconSize,
                                  ),
                                  SizedBox(width: padding / 4),
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: rewardFontSize,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(int sectionIndex) {
    final sectionTitles = [
      "Introduction to Money",
      "Savings and Spendings Basics",
      "Understanding Banks"
    ];

    // Fallback to "Section X" if the index is out of range
    final title = sectionIndex < sectionTitles.length
        ? sectionTitles[sectionIndex]
        : "Section ${sectionIndex + 1}";

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
}
