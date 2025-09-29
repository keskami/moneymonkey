import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/game_mechanics_service.dart';
import 'package:money_monkey/Backend/Services/lesson_progress_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Controllers/Lesson_Refresh.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CelebrationScreen extends StatefulWidget {
  final String completedLessonId;
  
  const CelebrationScreen({
    super.key,
    required this.completedLessonId,
  });

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  final RewardService _rewardService = RewardService();
  final LessonProgressService _progressService = LessonProgressService();
  
  bool _rewardAwarded = false;
  bool _progressUpdated = false;
  bool _isProcessing = false;
  final int _bananasEarned = 10;
  
  String? _nextProgress;
  int? _newStreak;
  bool _streakIncreased = false;
  bool _streakBroken = false;

  @override
  void initState() {
    super.initState();
    _processLessonCompletion();
  }

  Future<void> _processLessonCompletion() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      debugPrint('Completed lesson: ${widget.completedLessonId}');
      
      _nextProgress = _progressService.calculateNextLesson(widget.completedLessonId);
      debugPrint('Next lesson will be: $_nextProgress');

      final rewardSuccess = await _rewardService.award10Bananas(
        userId, 
        'Lesson ${widget.completedLessonId} completion'
      );

      final progressSuccess = await _progressService.updateLessonProgress(
        userId,
        widget.completedLessonId,
      );

      final streakResult = await _progressService.checkStreak(userId);
      
      setState(() {
        _rewardAwarded = rewardSuccess;
        _progressUpdated = progressSuccess;
        _newStreak = streakResult.newStreak;
        _streakIncreased = streakResult.isNewStreak;
        _streakBroken = streakResult.streakBroken;
      });

      if (rewardSuccess && progressSuccess) {
        _showSuccessMessage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Some updates failed. Please check your progress.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error processing lesson completion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showSuccessMessage() {
    if (_streakIncreased && !_streakBroken) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Text('🔥 ', style: TextStyle(fontSize: 20)),
              Expanded(
                child: Text(
                  'Streak increased to $_newStreak days!',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.orange[700],
          duration: const Duration(seconds: 3),
        ),
      );
    } else if (_streakBroken) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Streak reset. Start a new one today!'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToHome() {
    if (Get.isRegistered<BaseLessonController>()) {
      Get.delete<BaseLessonController>();
    }
    
    if (Get.isRegistered<LessonRefreshController>()) {
      Get.find<LessonRefreshController>().triggerRefresh();
    }
    
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007FFF),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '🎉 Lesson Complete! 🎉',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Container(
                        width: 400,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Gifs%2Fcelebration_animation_GIF.gif?alt=media&token=10d648af-02e3-4c34-8672-71d38133adfa',
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.celebration,
                                        size: 100,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                      decoration: BoxDecoration(
                        color: _isProcessing 
                            ? Colors.grey[400] 
                            : const Color(0xFF8BC34A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isProcessing 
                              ? Colors.grey[600]! 
                              : const Color(0xFF689F38),
                          width: 3,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _isProcessing ? 'PROCESSING...' : 'BANANAS EARNED',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (_isProcessing)
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('🍌', style: TextStyle(fontSize: 28)),
                                const SizedBox(width: 12),
                                Text(
                                  '$_bananasEarned',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          if (!_isProcessing) ...[
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _rewardAwarded ? Icons.check_circle : Icons.error,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _rewardAwarded ? 'Reward added' : 'Reward failed',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _progressUpdated ? Icons.check_circle : Icons.error,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _progressUpdated ? 'Progress updated' : 'Progress failed',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: ElevatedButton(
                onPressed: _navigateToHome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightTheme().pastelGreen,
                  padding: EdgeInsets.zero,
                ),
                child: CustomNextButton(
                  nextPage: _navigateToHome,
                  isEnabled: true,
                  text: "Finish",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}