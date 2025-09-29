import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';

class StartFreshPage2 extends GetView<StartFreshController> {
  const StartFreshPage2({super.key});

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
          
          // Achievements Section
          Expanded(
            child: _buildAchievementsSection(),
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
          "Here's what you can achieve in 3 months!",
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
          "Build strong financial foundations step by step",
          style: GoogleFonts.fredoka().copyWith(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    final List<Map<String, String>> achievements = [
      {
        "title": "Master Financial Habits",
        "description": "Budgeting tools, savings plans, and expense tracking",
        "icon": "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Frework.png?alt=media&token=7988b569-33ea-461d-9030-a0e8b5d3cfb4",
      },
      {
        "title": "Build your Financial Blueprint",
        "description": "Financial planning guides, investment simulations, and personalized advice",
        "icon": "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fblue_icon.png?alt=media&token=8a2e6bb8-acaa-4d41-835a-9005a28fe3be",
      },
      {
        "title": "Develop a Learning Habit",
        "description": "Smart reminders, fun challenges, and progress tracking",
        "icon": "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fwatch.png?alt=media&token=e424e7dc-cdec-4174-bfcb-ad754d45c093",
      },
    ];

    return ListView.separated(
      itemCount: achievements.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Achievement Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: _getIconBackgroundColor(index),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.network(
                  achievement["icon"]!,
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
                    _getFallbackIcon(index),
                    size: 32,
                    color: _getIconColor(index),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Achievement Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement["title"]!,
                      style: GoogleFonts.fredoka().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      achievement["description"]!,
                      style: GoogleFonts.fredoka().copyWith(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Progress indicator or checkmark
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getProgressColor(index).withOpacity(0.1),
                  border: Border.all(
                    color: _getProgressColor(index),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.trending_up,
                  size: 18,
                  color: _getProgressColor(index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getIconBackgroundColor(int index) {
    switch (index) {
      case 0:
        return Colors.green.withOpacity(0.1);
      case 1:
        return Colors.blue.withOpacity(0.1);
      case 2:
        return Colors.orange.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }

  Color _getIconColor(int index) {
    switch (index) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getProgressColor(int index) {
    switch (index) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getFallbackIcon(int index) {
    switch (index) {
      case 0:
        return Icons.savings;
      case 1:
        return Icons.architecture;
      case 2:
        return Icons.schedule;
      default:
        return Icons.star;
    }
  }
}