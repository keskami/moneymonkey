// services/lesson_progress_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/CacheServices.dart';

class LessonProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StudentProfileService _profileService = StudentProfileService();

  /// Calculates the next lesson based on completed lesson
  /// Format: A.1.1.1 -> A.1.1.3 -> A.1.1.5 -> A.1.1.6 -> A.1.2.1 -> ... -> A.2.2.4
  String calculateNextLesson(String completedLesson) {
    // Parse completed lesson (e.g., "A.1.1.1")
    final parts = completedLesson.split('.');
    if (parts.length != 4) {
      debugPrint('Invalid lesson format: $completedLesson');
      return 'A.1.1.1'; // Default to first lesson
    }

    String level = parts[0]; // A, B, C, etc.
    int unit = int.tryParse(parts[1]) ?? 1;
    int section = int.tryParse(parts[2]) ?? 1;
    int lesson = int.tryParse(parts[3]) ?? 1;

    // Increment lesson based on the pattern: 1 -> 3 -> 5 -> 6 -> next section
    if (lesson == 1) {
      lesson = 3;
    } else if (lesson == 3) {
      lesson = 5;
    } else if (lesson == 5) {
      lesson = 6;
    } else if (lesson == 6) {
      // Move to next section, start at lesson 1
      lesson = 1;
      section++;
    } else {
      // Unexpected lesson number, default to next odd number
      lesson = lesson + 2;
      if (lesson > 6) {
        lesson = 1;
        section++;
      }
    }

    // If section exceeds 2, move to next unit
    if (section > 2) {
      section = 1;
      unit++;
    }

    // If unit exceeds 2, move to next level (A -> B -> C, etc.)
    if (unit > 2) {
      unit = 1;
      section = 1;
      lesson = 1;
      // Move to next level
      level = String.fromCharCode(level.codeUnitAt(0) + 1);
    }

    return '$level.$unit.$section.$lesson';
  }

  /// Updates lesson progress and streak for a user
  Future<bool> updateLessonProgress(String userId, String currentProgress) async {
    try {
      debugPrint('📚 Updating lesson progress for user: $userId');
      debugPrint('Current progress: $currentProgress');

      // Calculate next lesson
      final nextLesson = calculateNextLesson(currentProgress);
      debugPrint('Next lesson: $nextLesson');

      // Get current student profile
      final currentProfile = await _profileService.loadProfileWithCache(userId);
      
      // Calculate new streak
      final streakResult = _calculateStreak(currentProfile);
      
      // Update profile with new progress and streak
      final updatedProfile = currentProfile.copyWith(
        progress: nextLesson,
        profile: currentProfile.profile.copyWith(
          streak: streakResult.newStreak,
        ),
      );

      // Save the updated profile (includes cache update)
      await _profileService.updateProfileOptimistic(userId, updatedProfile);

      // Update last completion timestamp
      await _updateLastCompletionDate(userId);

      debugPrint('✅ Progress updated successfully');
      debugPrint('📈 New progress: $nextLesson');
      debugPrint('🔥 New streak: ${streakResult.newStreak} days');
      if (streakResult.isNewStreak) {
        debugPrint('🎉 Streak increased!');
      }
      
      return true;
      
    } catch (e) {
      debugPrint('❌ Error updating lesson progress: $e');
      return false;
    }
  }

  /// Calculates the new streak based on last completion date
  StreakResult _calculateStreak(Student student) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // Get last completion date from Firestore metadata
    // For now, we'll use a simple logic: if they completed today, keep streak
    // In production, you'd fetch lastCompletionDate from Firestore
    
    final currentStreak = student.profile.streak;
    
    // This is simplified - you should store lastCompletionDate in Firestore
    // and compare it properly. For now, just increment the streak.
    return StreakResult(
      newStreak: currentStreak + 1,
      isNewStreak: true,
    );
  }

  /// Updates the last completion timestamp in Firestore
  Future<void> _updateLastCompletionDate(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'lastCompletionDate': FieldValue.serverTimestamp(),
      });
      
      debugPrint('📅 Updated last completion date');
      
    } catch (e) {
      debugPrint('❌ Error updating last completion date: $e');
      // Don't throw - this is metadata that shouldn't break the flow
    }
  }

  /// Checks streak status based on last completion date
  Future<StreakResult> checkStreak(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      final data = doc.data();
      
      if (data == null || !data.containsKey('lastCompletionDate')) {
        // No previous completion, start fresh
        return StreakResult(newStreak: 1, isNewStreak: true);
      }

      final lastCompletionTimestamp = data['lastCompletionDate'] as Timestamp;
      final lastCompletionDate = lastCompletionTimestamp.toDate();
      
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final lastDate = DateTime(
        lastCompletionDate.year,
        lastCompletionDate.month,
        lastCompletionDate.day,
      );

      final daysDifference = today.difference(lastDate).inDays;

      final student = await _profileService.loadProfileWithCache(userId);
      final currentStreak = student.profile.streak;

      if (daysDifference == 0) {
        // Completed today already, maintain streak
        return StreakResult(newStreak: currentStreak, isNewStreak: false);
      } else if (daysDifference == 1) {
        // Completed yesterday, increment streak
        return StreakResult(newStreak: currentStreak + 1, isNewStreak: true);
      } else {
        // Missed a day, reset streak to 1
        return StreakResult(newStreak: 1, isNewStreak: true, streakBroken: true);
      }
      
    } catch (e) {
      debugPrint('❌ Error checking streak: $e');
      // Return safe default
      return StreakResult(newStreak: 1, isNewStreak: true);
    }
  }

  /// Gets the user's current progress
  Future<String> getCurrentProgress(String userId) async {
    try {
      final student = await _profileService.loadProfileWithCache(userId);
      return student.progress;
    } catch (e) {
      debugPrint('❌ Error getting current progress: $e');
      return 'A.1.1.1'; // Default to first lesson
    }
  }

  /// Validates if a progress string is in correct format
  bool isValidProgress(String progress) {
    final regex = RegExp(r'^[A-Z]\.\d+\.\d+\.\d+$');
    return regex.hasMatch(progress);
  }
}

/// Result of streak calculation
class StreakResult {
  final int newStreak;
  final bool isNewStreak;
  final bool streakBroken;

  StreakResult({
    required this.newStreak,
    required this.isNewStreak,
    this.streakBroken = false,
  });
}