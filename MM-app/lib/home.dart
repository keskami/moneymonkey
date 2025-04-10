import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Controllers/ConversationsController.dart';
import 'package:money_monkey/GlobalWidgets/ChatBotDialog.dart';
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
    // Initialize conversation controller if needed
    if (!Get.isRegistered<ConversationController>()) {
      Get.put(ConversationController());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Obx(() {
        // Get current sidebar width based on expanded state
        double sidebarWidth = homePagesController.isSidebarExpanded.value 
            ? screenWidth * 0.17  // Expanded width
            : screenWidth * 0.06; // Minimized width
        
        return Row(
          children: [
            // Sidebar with MouseRegion to handle expansion
            MouseRegion(
              onEnter: (_) => homePagesController.isSidebarExpanded.value = true,
              onExit: (_) => homePagesController.isSidebarExpanded.value = false,
              child: SizedBox(
                width: sidebarWidth,
                child: const SideBar(),
              ),
            ),
            
            // Content area with GetBuilder for immediate updates
            Expanded(
              child: GetBuilder<HomePagesController>(
                builder: (controller) {
                  return controller.pages[controller.pageIndex.value];
                },
              ),
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return const Align(
                alignment: Alignment.centerRight,
                child: ChatBotDialog(lessonId: ''),
              );
            },
            barrierDismissible: true,
            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black54,
            transitionDuration: const Duration(milliseconds: 200),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}