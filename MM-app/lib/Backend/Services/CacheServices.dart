// services/student_profile_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'users';
  
  // Cache configuration
  static const String _cachePrefix = 'student_profile_';
  static const String _cacheTimestampPrefix = 'cache_timestamp_';
  static const Duration _cacheExpiry = Duration(hours: 1); // Cache expires after 1 hour
  
  // In-memory cache for active session
  final Map<String, Student> _memoryCache = {};
  final Map<String, DateTime> _memoryCacheTimestamps = {};

  // CACHING LAYER

  /// Get cache key for a user
  String _getCacheKey(String userId) => '$_cachePrefix$userId';
  String _getTimestampKey(String userId) => '$_cacheTimestampPrefix$userId';

  /// Check if cache is valid (not expired)
  bool _isCacheValid(DateTime cacheTime) {
    return DateTime.now().difference(cacheTime) < _cacheExpiry;
  }

  /// Save profile to persistent cache
  Future<void> _saveToCache(Student profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(profile.toJson());
      final cacheKey = _getCacheKey(profile.userId);
      final timestampKey = _getTimestampKey(profile.userId);
      
      await prefs.setString(cacheKey, jsonString);
      await prefs.setString(timestampKey, DateTime.now().toIso8601String());
      
      // Also save to memory cache
      _memoryCache[profile.userId] = profile;
      _memoryCacheTimestamps[profile.userId] = DateTime.now();
      
      debugPrint('💾 Cached profile for ${profile.name}');
    } catch (e) {
      debugPrint('❌ Error saving to cache: $e');
    }
  }

  /// Load profile from cache
  Future<Student?> _loadFromCache(String userId) async {
    try {
      // First check memory cache
      if (_memoryCache.containsKey(userId) && 
          _memoryCacheTimestamps.containsKey(userId)) {
        final cacheTime = _memoryCacheTimestamps[userId]!;
        if (_isCacheValid(cacheTime)) {
          debugPrint('🚀 Loaded from memory cache: ${_memoryCache[userId]!.name}');
          return _memoryCache[userId];
        } else {
          // Memory cache expired
          _memoryCache.remove(userId);
          _memoryCacheTimestamps.remove(userId);
        }
      }

      // Check persistent cache
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = _getCacheKey(userId);
      final timestampKey = _getTimestampKey(userId);
      
      final jsonString = prefs.getString(cacheKey);
      final timestampString = prefs.getString(timestampKey);
      
      if (jsonString != null && timestampString != null) {
        final cacheTime = DateTime.parse(timestampString);
        
        if (_isCacheValid(cacheTime)) {
          final json = jsonDecode(jsonString) as Map<String, dynamic>;
          final profile = Student.fromJson(json);
          
          // Restore to memory cache
          _memoryCache[userId] = profile;
          _memoryCacheTimestamps[userId] = cacheTime;
          
          debugPrint('📱 Loaded from persistent cache: ${profile.name}');
          return profile;
        } else {
          // Cache expired, remove it
          await _clearUserCache(userId);
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('❌ Error loading from cache: $e');
      return null;
    }
  }

  /// Clear cache for specific user
  Future<void> _clearUserCache(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_getCacheKey(userId));
      await prefs.remove(_getTimestampKey(userId));
      
      // Also clear from memory
      _memoryCache.remove(userId);
      _memoryCacheTimestamps.remove(userId);
      
      debugPrint('🗑️ Cleared cache for user: $userId');
    } catch (e) {
      debugPrint('❌ Error clearing cache: $e');
    }
  }

  /// Clear all cached profiles
  Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      
      for (final key in keys) {
        if (key.startsWith(_cachePrefix) || key.startsWith(_cacheTimestampPrefix)) {
          await prefs.remove(key);
        }
      }
      
      _memoryCache.clear();
      _memoryCacheTimestamps.clear();
      
      debugPrint('🗑️ Cleared all profile cache');
    } catch (e) {
      debugPrint('❌ Error clearing all cache: $e');
    }
  }

  // DATA LOADING PATTERNS

  /// PATTERN 1: Load with Cache-First Strategy
  /// Tries cache first, then Firebase if cache miss or expired
  Future<Student> loadProfileWithCache(String userId, {bool forceRefresh = false}) async {
    try {
      debugPrint('🔄 Loading profile with cache strategy for: $userId');
      
      // Force refresh bypasses cache
      if (!forceRefresh) {
        final cachedProfile = await _loadFromCache(userId);
        if (cachedProfile != null) {
          return cachedProfile;
        }
      }
      
      // Cache miss or force refresh - load from Firebase
      debugPrint('📡 Cache miss, loading from Firebase...');
      final doc = await _firestore.collection(_collection).doc(userId).get();
      
      if (!doc.exists) {
        throw Exception('User not found: $userId');
      }

      final profile = Student.fromFirestore(doc.data()!, doc.id);
      
      // Save to cache for future use
      await _saveToCache(profile);
      
      debugPrint('✅ Loaded and cached profile for ${profile.name}');
      return profile;
      
    } catch (e) {
      debugPrint('❌ Error loading profile: $e');
      rethrow;
    }
  }

  /// PATTERN 2: Real-time Stream with Cache Sync
  /// Provides real-time updates while maintaining cache
  Stream<Student> getProfileStreamWithCache(String userId) {
    debugPrint('👂 Setting up real-time stream with cache sync for: $userId');
    
    return _firestore
        .collection(_collection)
        .doc(userId)
        .snapshots()
        .asyncMap((doc) async {
          if (!doc.exists) {
            throw Exception('User not found: $userId');
          }
          
          final profile = Student.fromFirestore(doc.data()!, doc.id);
          
          // Update cache with real-time data
          await _saveToCache(profile);
          
          debugPrint('🔄 Real-time update cached for ${profile.name}');
          return profile;
        });
  }

  /// PATTERN 3: Offline-First Loading
  /// Always returns cache first, then updates in background
  Future<Student> loadProfileOfflineFirst(String userId) async {
    debugPrint('📱 Loading profile offline-first for: $userId');
    
    // Always try cache first
    final cachedProfile = await _loadFromCache(userId);
    
    if (cachedProfile != null) {
      debugPrint('✅ Returning cached profile for ${cachedProfile.name}');
      
      // Update in background (fire and forget)
      _updateCacheInBackground(userId);
      
      return cachedProfile;
    }
    
    // No cache available, must load from Firebase
    return loadProfileWithCache(userId);
  }

  /// Background cache update (doesn't block UI)
  void _updateCacheInBackground(String userId) {
    debugPrint('🔄 Updating cache in background for: $userId');
    
    _firestore.collection(_collection).doc(userId).get().then((doc) {
      if (doc.exists) {
        final profile = Student.fromFirestore(doc.data()!, doc.id);
        _saveToCache(profile);
        debugPrint('✅ Background cache update completed for ${profile.name}');
      }
    }).catchError((error) {
      debugPrint('❌ Background cache update failed: $error');
    });
  }

  /// PATTERN 4: Real-time Listener with Persistent Connection
  /// Listens to core progress stats and auto-syncs cache
  /// Returns a stream that emits updated Student objects whenever Firebase data changes
  Stream<Student> getProfileRealTimeWithCache(String userId) {
    debugPrint('👂 Setting up real-time listener with cache for: $userId');
    
    return _firestore
        .collection(_collection)
        .doc(userId)
        .snapshots()
        .asyncMap((doc) async {
          if (!doc.exists) {
            throw Exception('User not found: $userId');
          }
          
          final profile = Student.fromFirestore(doc.data()!, doc.id);
          
          // Auto-sync to both memory and persistent cache
          await _saveToCache(profile);
          
          debugPrint('🔄 Real-time update: streak=${profile.profile.streak}, score=${profile.profile.portfolioScore}, level=${profile.knowledgeLevel}, progress=${profile.progress}');
          return profile;
        });
  }

  // UPDATE PATTERNS WITH CACHE INVALIDATION

  /// Update profile section and sync cache
  Future<void> updateProfileSection(
    String userId, 
    Map<String, dynamic> updates, 
    {bool updateCache = true}
  ) async {
    try {
      debugPrint('🔄 Updating profile section for: $userId');
      
      // Update Firebase
      await _firestore.collection(_collection).doc(userId).update(updates);
      
      if (updateCache) {
        // Invalidate cache to force fresh load next time
        await _clearUserCache(userId);
        debugPrint('🗑️ Cache invalidated after update');
      }
      
      debugPrint('✅ Profile section updated successfully');
      
    } catch (e) {
      debugPrint('❌ Error updating profile section: $e');
      rethrow;
    }
  }

  /// Update profile with optimistic caching
  Future<void> updateProfileOptimistic(
    String userId, 
    Student updatedProfile
  ) async {
    try {
      debugPrint('🔄 Optimistic update for: $userId');
      
      // 1. Update cache immediately (optimistic)
      await _saveToCache(updatedProfile);
      debugPrint('✅ Optimistic cache update completed');
      
      // 2. Update Firebase
      await _firestore.collection(_collection).doc(userId).set(updatedProfile.toFirestore());
      debugPrint('✅ Firebase update completed');
      
    } catch (e) {
      debugPrint('❌ Optimistic update failed, clearing cache: $e');
      // If Firebase update fails, clear cache to avoid inconsistency
      await _clearUserCache(userId);
      rethrow;
    }
  }

  // BUSINESS LOGIC EXAMPLES

  /// Handle lesson completion with cache update
  Future<void> handleLessonCompletion(
    String userId, 
    LessonCompletionData lessonData
  ) async {
    debugPrint('\n=== LESSON COMPLETION ===');
    
    try {
      // Load current profile (from cache if available)
      final currentProfile = await loadProfileWithCache(userId);
      
      // Create updated profile
      final updatedProfile = currentProfile.copyWith(
        knowledgeLevel: lessonData.newKnowledgeLevel,
        progress: lessonData.newProgress,
        profile: currentProfile.profile.copyWith(
          streak: lessonData.newStreak,
          portfolioScore: lessonData.newScore,
        ),
      );
      
      // Use optimistic update
      await updateProfileOptimistic(userId, updatedProfile);
      
      debugPrint('✅ Lesson completion processed');
      
    } catch (e) {
      debugPrint('❌ Failed to process lesson completion: $e');
      rethrow;
    }
  }

  /// Update user preferences with immediate cache sync
  Future<void> updateUserPreferences(
    String userId, 
    UserPreferences newPreferences
  ) async {
    debugPrint('\n=== PREFERENCES UPDATE ===');
    
    try {
      final updates = {
        'settings.preferences': newPreferences.toFirestore(),
      };
      
      await updateProfileSection(userId, updates);
      
      debugPrint('✅ User preferences updated');
      
    } catch (e) {
      debugPrint('❌ Failed to update preferences: $e');
      rethrow;
    }
  }

  // QUERY METHODS WITH CACHING

  /// Get multiple students with smart caching
  Future<List<Student>> getStudentsByKnowledgeLevel(
    int minLevel, 
    {bool useCache = true}
  ) async {
    debugPrint('🔍 Querying students with knowledge level >= $minLevel');
    
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('role', isEqualTo: 'student')
          .where('knowledgeLevel', isGreaterThanOrEqualTo: minLevel)
          .get();

      final students = <Student>[];
      
      for (final doc in querySnapshot.docs) {
        if (useCache) {
          // Try to get from cache first
          final cached = await _loadFromCache(doc.id);
          if (cached != null) {
            students.add(cached);
            continue;
          }
        }
        
        // Not in cache, create from Firestore and cache it
        final profile = Student.fromFirestore(doc.data(), doc.id);
        await _saveToCache(profile);
        students.add(profile);
      }
      
      debugPrint('✅ Found ${students.length} students (cache optimization applied)');
      return students;
      
    } catch (e) {
      debugPrint('❌ Error querying students: $e');
      rethrow;
    }
  }

  // CACHE MANAGEMENT UTILITIES

  /// Get cache statistics
  Future<CacheStats> getCacheStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      
      int profileCount = 0;
      int expiredCount = 0;
      int totalSizeBytes = 0;
      
      for (final key in keys) {
        if (key.startsWith(_cachePrefix)) {
          profileCount++;
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            totalSizeBytes += jsonString.length;
          }
          
          // Check if expired
          final timestampKey = key.replaceFirst(_cachePrefix, _cacheTimestampPrefix);
          final timestampString = prefs.getString(timestampKey);
          if (timestampString != null) {
            final cacheTime = DateTime.parse(timestampString);
            if (!_isCacheValid(cacheTime)) {
              expiredCount++;
            }
          }
        }
      }
      
      return CacheStats(
        profileCount: profileCount,
        expiredCount: expiredCount,
        memoryCount: _memoryCache.length,
        totalSizeBytes: totalSizeBytes,
      );
      
    } catch (e) {
      debugPrint('❌ Error getting cache stats: $e');
      return CacheStats(profileCount: 0, expiredCount: 0, memoryCount: 0, totalSizeBytes: 0);
    }
  }

  /// Clean up expired cache entries
  Future<void> cleanExpiredCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      
      int cleanedCount = 0;
      
      for (final key in keys) {
        if (key.startsWith(_cacheTimestampPrefix)) {
          final timestampString = prefs.getString(key);
          if (timestampString != null) {
            final cacheTime = DateTime.parse(timestampString);
            if (!_isCacheValid(cacheTime)) {
              final userId = key.replaceFirst(_cacheTimestampPrefix, '');
              await _clearUserCache(userId);
              cleanedCount++;
            }
          }
        }
      }
      
      debugPrint('🧹 Cleaned $cleanedCount expired cache entries');
      
    } catch (e) {
      debugPrint('❌ Error cleaning expired cache: $e');
    }
  }
}

// Data Transfer Objects

class LessonCompletionData {
  final int newStreak;
  final double newScore;
  final String newProgress;
  final int newKnowledgeLevel;

  const LessonCompletionData({
    required this.newStreak,
    required this.newScore,
    required this.newProgress,
    required this.newKnowledgeLevel,
  });
}

class CacheStats {
  final int profileCount;
  final int expiredCount;
  final int memoryCount;
  final int totalSizeBytes;

  const CacheStats({
    required this.profileCount,
    required this.expiredCount,
    required this.memoryCount,
    required this.totalSizeBytes,
  });
  
  double get totalSizeKB => totalSizeBytes / 1024;
  double get totalSizeMB => totalSizeKB / 1024;
  
  @override
  String toString() {
    return 'CacheStats(profiles: $profileCount, expired: $expiredCount, '
           'memory: $memoryCount, size: ${totalSizeKB.toStringAsFixed(1)}KB)';
  }
}

// FLUTTER INTEGRATION EXAMPLES

/// Provider for state management
class StudentProfileProvider extends ChangeNotifier {
  final StudentProfileService _service = StudentProfileService();
  Student? _profile;
  bool _loading = false;
  String? _error;

  Student? get profile => _profile;
  bool get loading => _loading;
  String? get error => _error;

  /// Load profile with cache-first strategy
  Future<void> loadProfile(String userId, {bool forceRefresh = false}) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _service.loadProfileWithCache(userId, forceRefresh: forceRefresh);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Load profile offline-first (immediate response)
  Future<void> loadProfileOffline(String userId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _service.loadProfileOfflineFirst(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Update preferences optimistically
  Future<void> updatePreferences(String userId, UserPreferences preferences) async {
    if (_profile != null) {
      // Optimistic UI update
      _profile = _profile!.copyWith(
        settings: _profile!.settings.copyWith(preferences: preferences),
      );
      notifyListeners();
    }

    try {
      await _service.updateUserPreferences(userId, preferences);
    } catch (e) {
      _error = e.toString();
      // Reload profile on error to restore correct state
      await loadProfile(userId);
    }
  }

  /// Get cache statistics
  Future<CacheStats> getCacheStats() => _service.getCacheStats();
  
  /// Clear all cache
  Future<void> clearCache() => _service.clearAllCache();
}