import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';

class StartFreshPage3 extends GetView<StartFreshController> {
  StartFreshPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return _StartFreshPage3View();
  }
}

class _StartFreshPage3View extends StatefulWidget {
  @override
  State<_StartFreshPage3View> createState() => _StartFreshPage3ViewState();
}

class _StartFreshPage3ViewState extends State<_StartFreshPage3View> {
  late final StartFreshController startFreshController = Get.find();
  
  int sfOrFml = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 60),
          
          // Header Section
          _buildHeader(),
          
          const SizedBox(height: 48),
          
          // Options Section
          Expanded(
            child: _buildOptionsSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Character Image
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
              height: 120,
              width: 120,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Title
        Text(
          "Where would you like to start?",
          style: GoogleFonts.fredoka().copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 12),
        
        // Subtitle
        Text(
          "Choose the path that best fits your experience",
          style: GoogleFonts.fredoka().copyWith(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOptionsSection() {
    final List<Map<String, dynamic>> startingOptions = [
      {
        "title": "Start from scratch",
        "description": "Take the easiest lesson of our financial literacy course",
        "icon": "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fone_banner.png?alt=media&token=9bf102b7-d285-413f-8fee-27c384fc9ed2",
        "value": 1,
        "color": Colors.green,
        "fallbackIcon": Icons.school,
      },
      {
        "title": "Find my level (Coming soon...)",
        "description": "Let Money Monkey recommend where you should start learning",
        "icon": "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fmagnifying_glass.png?alt=media&token=5efa79cc-9435-4b27-9cb0-75ea22b18bb5",
        "value": 2,
        "color": Colors.blue,
        "fallbackIcon": Icons.search,
      },
    ];

    return ListView.separated(
      itemCount: startingOptions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final option = startingOptions[index];
        final isSelected = sfOrFml == option["value"] || 
            startFreshController.startingFresh.value == option["value"];
        
        return GestureDetector(
          // Disable tapping for "Find my level" (value == 2)
          onTap: option["value"] == 2
              ? null
              : () {
                  startFreshController.startingFresh.value = option["value"];
                  setState(() {
                    sfOrFml = option["value"];
                  });
                },
          child: Obx(() {
            final isControllerSelected = startFreshController.startingFresh.value == option["value"];
            final currentlySelected = sfOrFml == option["value"] || isControllerSelected;
            
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: currentlySelected 
                      ? option["color"] 
                      : Colors.grey[300]!,
                  width: currentlySelected ? 2 : 1,
                ),
                color: currentlySelected 
                    ? option["color"].withOpacity(0.1)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Option Icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: option["color"].withOpacity(0.1),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.network(
                      option["icon"],
                      fit: BoxFit.contain,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Icon(
                        option["fallbackIcon"],
                        size: 32,
                        color: option["color"],
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Option Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option["title"],
                          style: GoogleFonts.fredoka().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          option["description"],
                          style: GoogleFonts.fredoka().copyWith(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Selection indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: currentlySelected 
                            ? option["color"] 
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                      color: currentlySelected 
                          ? option["color"] 
                          : Colors.transparent,
                    ),
                    child: currentlySelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}