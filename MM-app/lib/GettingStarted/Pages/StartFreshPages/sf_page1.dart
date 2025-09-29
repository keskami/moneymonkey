import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';

class StartFreshPage1 extends GetView<StartFreshController> {
  const StartFreshPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return _StartFreshPage1View();
  }
}

class _StartFreshPage1View extends StatefulWidget {
  @override
  State<_StartFreshPage1View> createState() => _StartFreshPage1ViewState();
}

class _StartFreshPage1ViewState extends State<_StartFreshPage1View> {
  late final StartFreshController startFreshController = Get.find();
  
  int selectedIndex = 5;

  @override
  Widget build(BuildContext context) {
    void onTapGoal(int val) {
      print('Value: ${val * 5}');
      startFreshController.learningGoal.value = val * 5;
    }

    final List<Map<String, String>> learningGoals = [
      {
        "time": "5 min / day",
        "level": "Casual",
      },
      {
        "time": "10 min / day", 
        "level": "Regular",
      },
      {
        "time": "15 min / day",
        "level": "Serious", 
      },
      {
        "time": "20 min / day",
        "level": "Intense",
      },
    ];
    
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
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
            child: _buildOptionsSection(learningGoals, onTapGoal),
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
        const Text(
          "What's your daily learning goal?",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 12),
        
        // Subtitle
        Text(
          "Choose a goal that fits your schedule",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOptionsSection(List<Map<String, String>> learningGoals, void Function(int) onTapGoal) {
    return ListView.separated(
      itemCount: learningGoals.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final goal = learningGoals[index];
        final isSelected = selectedIndex == index ||
            (startFreshController.learningGoal.value / 5) - 1 == index;
        
        return GestureDetector(
          onTap: () {
            onTapGoal(index + 1);
            print(index);
            print(startFreshController.learningGoal.value);
            setState(() {
              selectedIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected 
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
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
                // Time commitment
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal["time"]!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        goal["level"]!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Selection indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected 
                          ? Theme.of(context).primaryColor 
                          : Colors.grey[400]!,
                      width: 2,
                    ),
                    color: isSelected 
                        ? Theme.of(context).primaryColor 
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}