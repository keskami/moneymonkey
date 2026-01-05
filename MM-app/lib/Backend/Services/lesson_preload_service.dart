import 'package:flutter/foundation.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';

/// Service for preloading lesson data to reduce initial load times
class LessonPreloadService {
  static final LessonPreloadService _instance = LessonPreloadService._internal();
  
  factory LessonPreloadService() {
    return _instance;
  }
  
  LessonPreloadService._internal();
  
  final DirectFirebaseService _firebaseService = DirectFirebaseService();
  
  // Cache for preloaded data
  Unit? _cachedUnit;
  List<Lesson>? _cachedLessons;
  Map<String, Component> _cachedComponents = {}; // Cache for components
  String? _cachedUnitId;
  DateTime? _cacheTime;
  
  // Cache expiry time (5 minutes)
  static const Duration _cacheExpiry = Duration(minutes: 5);
  
  /// Preload the initial unit and its lessons with all components
  /// This fetches A.1 unit and all its lessons and components by default
  Future<void> preloadInitialLessons({String unitId = 'A.1'}) async {
    try {
      debugPrint('📚 Starting lesson preload for unit: $unitId');
      final stopwatch = Stopwatch()..start();
      
      // Fetch the unit
      final unit = await _firebaseService.getUnit(unitId);
      debugPrint('  ✓ Fetched unit: ${unit.title}');
      
      // Fetch all lessons for this unit in parallel
      final lessonFutures = unit.lessonIds.map(
        (lessonId) => _firebaseService.getLesson(lessonId)
      );
      
      final lessons = await Future.wait(lessonFutures);
      debugPrint('  ✓ Fetched ${lessons.length} lessons');
      
      // Fetch all components for all lessons in parallel
      final Map<String, Component> components = {};
      final List<Future<void>> componentFutures = [];
      
      for (final lesson in lessons) {
        for (final componentId in lesson.components) {
          componentFutures.add(
            _firebaseService.getComponent(componentId).then((component) {
              components[componentId] = component;
            }).catchError((error) {
              debugPrint('  ⚠️ Failed to fetch component $componentId: $error');
            })
          );
        }
      }
      
      // Wait for all components to load
      await Future.wait(componentFutures);
      debugPrint('  ✓ Fetched ${components.length} components');
      
      // Cache the results
      _cachedUnit = unit;
      _cachedLessons = lessons;
      _cachedComponents = components;
      _cachedUnitId = unitId;
      _cacheTime = DateTime.now();
      
      stopwatch.stop();
      debugPrint('✅ Lesson preload complete! Took ${stopwatch.elapsedMilliseconds}ms');
    } catch (e) {
      debugPrint('❌ Error during lesson preload: $e');
      rethrow;
    }
  }
  
  /// Get cached unit if available and not expired
  Unit? getCachedUnit(String unitId) {
    if (_cachedUnitId == unitId && 
        _cacheTime != null && 
        DateTime.now().difference(_cacheTime!) < _cacheExpiry) {
      debugPrint('📦 Returning cached unit: $unitId');
      return _cachedUnit;
    }
    return null;
  }
  
  /// Get cached lessons if available and not expired
  List<Lesson>? getCachedLessons(String unitId) {
    if (_cachedUnitId == unitId && 
        _cacheTime != null && 
        DateTime.now().difference(_cacheTime!) < _cacheExpiry) {
      debugPrint('📦 Returning ${_cachedLessons?.length ?? 0} cached lessons');
      return _cachedLessons;
    }
    return null;
  }
  
  /// Get cached component if available and not expired
  Component? getCachedComponent(String componentId) {
    if (_cacheTime != null && 
        DateTime.now().difference(_cacheTime!) < _cacheExpiry) {
      final component = _cachedComponents[componentId];
      if (component != null) {
        debugPrint('📦 Returning cached component: $componentId');
      }
      return component;
    }
    return null;
  }
  
  /// Clear the cache
  void clearCache() {
    _cachedUnit = null;
    _cachedLessons = null;
    _cachedComponents.clear();
    _cachedUnitId = null;
    _cacheTime = null;
    debugPrint('🗑️ Lesson cache cleared');
  }
}
