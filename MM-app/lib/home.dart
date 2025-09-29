import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/SideBar.dart';
import 'package:money_monkey/LessonPages/Controllers/HomePagesController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePagesController homePagesController = Get.put<HomePagesController>(HomePagesController());

  @override
  void initState() {
    super.initState();
    
    // Register the general assistant
    _initializeGeneralAssistant();
  }
  
  Future<void> _initializeGeneralAssistant() async {
  final assistantId = 'asst_Miaq9XzcKdd5B5jM0k3ZRinx';
  print('Initializing general assistant with ID: $assistantId');
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Obx(() {
        // Determine if sidebar should be expanded based on page index
        final int pageIndex = homePagesController.pageIndex.value;
        final bool isSidebarExpanded = !(pageIndex == 3 || pageIndex == 4);
        double sidebarWidth = isSidebarExpanded
            ? screenWidth * 0.17  // Expanded width
            : screenWidth * 0.06; // Minimized width
        
        return Row(
          children: [
            SizedBox(
              width: sidebarWidth,
              child: const SideBar(),
            ),
            Expanded(
              child: IndexedStack(
                index: pageIndex,
                children: homePagesController.pages,
              ),
            )
          ],
        );
      }),
    );
  }
}