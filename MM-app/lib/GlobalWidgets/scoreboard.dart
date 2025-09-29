import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/CacheServices.dart';
import 'package:money_monkey/Backend/Services/game_mechanics_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Lesson_Refresh.dart';

class ScoreboardWidget extends StatefulWidget {
  const ScoreboardWidget({Key? key}) : super(key: key);

  @override
  State<ScoreboardWidget> createState() => _ScoreboardWidgetState();
}

class _ScoreboardWidgetState extends State<ScoreboardWidget> {
  final StudentProfileService _profileService = StudentProfileService();
  final RewardService _rewardService = RewardService();
  
  Student? _student;
  bool _isLoading = true;
  String? _error;
  Worker? _refreshWorker;  // Add this

  // Daily quest progress (mock data - replace with real quest tracking)
  int _unitsCompleted = 0;
  int _highScoreLessons = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    
    // Set up the refresh listener - same pattern as other widgets
    if (!Get.isRegistered<LessonRefreshController>()) {
      Get.put(LessonRefreshController());
    }
    
    _refreshWorker = ever(Get.find<LessonRefreshController>().shouldRefresh, (_) {
      if (mounted) {
        debugPrint('🔄 Scoreboard refresh triggered, reloading from Firebase...');
        _loadUserData(forceRefresh: true);
      }
    });
  }

  @override
  void dispose() {
    _refreshWorker?.dispose();  // Clean up the listener
    super.dispose();
  }

  Future<void> _loadUserData({bool forceRefresh = false}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() {
        _error = 'No user logged in';
        _isLoading = false;
      });
      return;
    }

    try {
      // Use forceRefresh when triggered by completion events
      final student = forceRefresh
          ? await _profileService.loadProfileWithCache(userId, forceRefresh: true)
          : await _profileService.loadProfileOfflineFirst(userId);
      
      // Calculate daily quest progress based on student data
      _calculateDailyQuestProgress(student);
      
      setState(() {
        _student = student;
        _isLoading = false;
        _error = null;
      });
      
    } catch (e) {
      setState(() {
        _error = 'Error loading data: $e';
        _isLoading = false;
      });
      debugPrint('Error loading scoreboard data: $e');
    }
  }

  void _calculateDailyQuestProgress(Student student) {
    // Mock calculation based on student data
    // Replace with actual quest tracking logic from your database

    var units = student.progress.split('.'); // e.g. "A.1.2.3"
    if (units.length >= 2) {
      int unitNumber = int.tryParse(units[1]) ?? 1;
      _unitsCompleted = unitNumber - 1; // Assume each unit completed increments this
    } else {
      _unitsCompleted = 0;
    }
    
    // Example: Based on knowledge level progression
    _unitsCompleted = (_unitsCompleted % 3); // 0-3 units completed today
    
    // Example: Based on portfolio score (mock calculation)
    _highScoreLessons = student.profile.portfolioScore > 80 ? 1 : 0;
    
    // You could also check recent activity:
    // - Check completion timestamps from today
    // - Query recent lesson completions
    // - Track daily progress in a separate collection
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        // Force refresh from Firebase
        final student = await _profileService.loadProfileWithCache(userId, forceRefresh: true);
        _calculateDailyQuestProgress(student);
        
        setState(() {
          _student = student;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _error = 'Error refreshing data: $e';
          _isLoading = false;
        });
      }
    }
  }

  // ... rest of your code stays the same

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    return Container(
      width: screenWidth * 0.25,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025, vertical: 0),
      child: Column(
        children: [
          SizedBox(height: screenHeightUnit * 10),
          
          // Stats bar with real student data
          _buildStatsBar(screenWidthUnit, screenHeightUnit),
          
          SizedBox(height: screenHeightUnit * 46),
          
          // Daily quests container
          _buildDailyQuestsContainer(screenWidthUnit, screenHeightUnit),
        ],
      ),
    );
  }

  Widget _buildStatsBar(double screenWidthUnit, double screenHeightUnit) {
    if (_isLoading) {
      return Container(
        height: screenHeightUnit * 80,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_error != null) {
      return GestureDetector(
        onTap: _refreshData,
        child: Container(
          height: screenHeightUnit * 80,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 20, color: Colors.red),
                SizedBox(height: 4),
                Text(
                  'Tap to retry',
                  style: GoogleFonts.baloo2(fontSize: 12, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _refreshData,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/LOGO.png',
              height: screenHeightUnit * 80,
            ),
            SizedBox(width: screenWidthUnit * 7),
            
            // Total Profit (Bananas) - from Student model
            Image.asset(
              'assets/images/img_monkeymoney_52.png',
              height: screenHeightUnit * 53,
            ),
            SizedBox(width: screenWidthUnit * 2),
            Text(
              _formatNumber(_student?.profile.totalProfit.toInt() ?? 0),
              style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 9,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: screenWidthUnit * 7),
            
            // Portfolio Score - from Student model
            Image.asset(
              'assets/images/img_monkeymoney_51.png',
              height: screenHeightUnit * 49,
            ),
            SizedBox(width: screenWidthUnit * 2),
            Text(
              _student?.profile.portfolioScore.toInt().toString() ?? '0',
              style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 9,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyQuestsContainer(double screenWidthUnit, double screenHeightUnit) {
    return SizedBox(
      width: screenWidthUnit * 100,
      height: screenHeightUnit * 340,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: .5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: screenHeightUnit * 15),
            
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidthUnit * 7),
                  child: Text(
                    "Daily Quests",
                    style: GoogleFonts.baloo2(
                      fontSize: screenWidthUnit * 5.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidthUnit * 7),
                  child: TextButton(
                    onPressed: _refreshData,
                    child: Text(
                      "Refresh >",
                      style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 4.75,
                        color: Color.fromRGBO(79, 195, 247, 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: screenHeightUnit * 10),
            
            // Quest 1: Complete units
            _buildDailyQuest(
              title: "Complete 3 units",
              outOf: 3,
              completed: _unitsCompleted,
              screenWidthUnit: screenWidthUnit,
              screenHeightUnit: screenHeightUnit,
              reward: 15,
            ),
            
            SizedBox(height: screenHeightUnit * 20),
            
            // Quest 2: High scores
            _buildDailyQuest(
              title: "Score 80% or higher in 2\nlessons",
              outOf: 2,
              completed: _highScoreLessons,
              screenWidthUnit: screenWidthUnit,
              screenHeightUnit: screenHeightUnit,
              reward: 20,
            ),
            
            // Show level up notification if applicable
            if (_student?.canLevelUp == true) ...[
              SizedBox(height: screenHeightUnit * 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidthUnit * 7),
                padding: EdgeInsets.all(screenWidthUnit * 3),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '🎉',
                      style: TextStyle(fontSize: screenWidthUnit * 4),
                    ),
                    SizedBox(width: screenWidthUnit * 2),
                    Expanded(
                      child: Text(
                        'Ready to Level Up!',
                        style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 3.5,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            // Show current level and progress
            if (_student != null) ...[
              SizedBox(height: screenHeightUnit * 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidthUnit * 7),
                padding: EdgeInsets.all(screenWidthUnit * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level: ${_student!.knowledgeLevel}',
                      style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 3.5,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _student!.experienceLevel,
                      style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 3.5,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDailyQuest({
    required String title,
    required int outOf,
    required int completed,
    required double screenWidthUnit,
    required double screenHeightUnit,
    required int reward,
  }) {
    final isCompleted = completed >= outOf;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    
    return Padding(
      padding: EdgeInsets.fromLTRB(screenWidthUnit * 7, 0, screenWidthUnit * 7, 0),
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(height: screenHeightUnit * 10),
              Stack(
                children: [
                  Image.asset(
                    "assets/images/img_monkeymoney_51.png",
                    height: screenHeightUnit * 72,
                  ),
                  if (isCompleted)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          // Award quest completion reward
                          if (userId != null) {
                            final success = await _rewardService.award10Bananas(
                              userId, 
                              'Daily quest: $title'
                            );
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Quest reward claimed: +10 bananas!'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              // Refresh data to show updated totals
                              _refreshData();
                            }
                          }
                        },
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(width: screenWidthUnit * 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 3.8,
                          color: isCompleted ? Colors.green[700] : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidthUnit * 2,
                        vertical: screenHeightUnit * 1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '+10 🍌', // Simplified to always award 10 bananas
                        style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 3,
                          color: Colors.orange[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeightUnit * 2),
                Container(
                  height: screenHeightUnit * 25,
                  width: screenWidthUnit * 62,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        isCompleted 
                            ? Colors.green 
                            : Color.fromRGBO(135, 206, 235, 1),
                        Color.fromRGBO(213, 213, 213, 1),
                      ],
                      stops: [
                        completed / outOf,
                        completed / outOf,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "$completed/$outOf",
                      style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 3.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}