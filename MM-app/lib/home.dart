import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Controllers/ConversationsController.dart';
import 'package:money_monkey/Backend/Services/AssistantConfigService.dart';
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
  late final ConversationController _conversationController;
  late final AssistantConfigService _assistantConfigService;

  @override
  void initState() {
    super.initState();
    // Initialize conversation controller if needed
    if (!Get.isRegistered<ConversationController>()) {
      Get.put(ConversationController());
    }
    _conversationController = Get.find<ConversationController>();
    
    // Initialize assistant config service if needed
    if (!Get.isRegistered<AssistantConfigService>()) {
      Get.put(AssistantConfigService());
    }
    _assistantConfigService = Get.find<AssistantConfigService>();
    
    // Register the general assistant
    _initializeGeneralAssistant();
  }
  
  Future<void> _initializeGeneralAssistant() async {
  final assistantId = 'asst_Miaq9XzcKdd5B5jM0k3ZRinx';
  print('Initializing general assistant with ID: $assistantId');
  
  // Register the general assistant if not already registered
  if (!_conversationController.hasAssistantForLesson('general')) {
    try {
      await _conversationController.registerAssistantForLesson(
        'General Financial',
        assistantId,
        'Minty',
        description: 'Your personal financial assistant',
        metadata: {
          'botName': 'Minty',
          'botImageAsset': 'assets/images/monkeyNoText.png',
        },
      );
      print('Successfully registered general assistant');
    } catch (e) {
      print('Error registering general assistant: $e');
    }
  }
}
  
  void _showGeneralChatBot() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Align(
          alignment: Alignment.centerRight,
          child: ChatBotDialog(
            lessonId: 'general', // Use 'general' ID instead of empty string
            initialGreeting: "Hi there! I'm Minty, your personal financial assistant. How can I help you today?",
          ),
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
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Obx(() {
        // Determine if sidebar should be expanded based on page index
        final int pageIndex = homePagesController.pageIndex.value;
        final bool isSidebarExpanded = !(pageIndex == 0 || pageIndex == 4);
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showGeneralChatBot, // Use the new method
        child: const Icon(Icons.chat), // Changed to chat icon for clarity
      ),
    );
  }
}