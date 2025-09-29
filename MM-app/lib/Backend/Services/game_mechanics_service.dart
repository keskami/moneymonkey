// services/reward_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:money_monkey/Backend/Services/CacheServices.dart';

class RewardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StudentProfileService _profileService = StudentProfileService();

  /// Awards 10 bananas to a user and updates their profile
  /// Returns true if successful, false if failed
  Future<bool> award10Bananas(String userId, String reason) async {
    try {
      debugPrint('🍌 Awarding 10 bananas to user: $userId for: $reason');

      // Get current user profile
      final currentProfile = await _profileService.loadProfileWithCache(userId);
      
      // Update the profile with new banana count
      final updatedProfile = currentProfile.copyWith(
        profile: currentProfile.profile.copyWith(
          totalProfit: currentProfile.profile.totalProfit + 10,
        ),
      );

      // Save the updated profile (includes cache update)
      await _profileService.updateProfileOptimistic(userId, updatedProfile);

      // Create a transaction record for tracking
      await _createBananaTransaction(userId, 10, reason);

      debugPrint('✅ Successfully awarded 10 bananas to ${currentProfile.name}');
      debugPrint('📊 New total profit: ${updatedProfile.profile.totalProfit}');
      
      return true;
      
    } catch (e) {
      debugPrint('❌ Error awarding bananas: $e');
      return false;
    }
  }

  /// Creates a transaction record for the banana reward
  Future<void> _createBananaTransaction(String userId, int amount, String reason) async {
    try {
      final transactionRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('Transactions');

      await transactionRef.add({
        'Source/Destination': 'Banana Reward: $reason',
        'Amount': amount,
        'Date': FieldValue.serverTimestamp(),
        'Type': 'Reward',
        'Category': 'Bananas',
        'Description': reason,
      });

      debugPrint('📝 Created transaction record for banana reward');
      
    } catch (e) {
      debugPrint('❌ Error creating transaction record: $e');
      // Don't rethrow - transaction record failure shouldn't prevent reward
    }
  }
}