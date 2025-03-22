import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';

class SimplifiedDataManager {
  static final SimplifiedDataManager _instance =
      SimplifiedDataManager._internal();

  factory SimplifiedDataManager() {
    return _instance;
  }

  SimplifiedDataManager._internal();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cache collections
  Map<String, Classroom> _classrooms = {};
  Map<String, Unit> _units = {};
  Map<String, Lesson> _lessons = {};
  Map<String, Component> _components = {};
  Map<String, Teacher> _teachers = {};
  Map<String, Student> _students = {};

  // Cache flags
  bool _isInitialized = false;
  DateTime? _lastSyncTime;

  // Maximum age of cache before refresh (24 hours)
  static const Duration CACHE_MAX_AGE = Duration(hours: 24);

  /// Initialize the data manager and load cached data

  // Add these improved methods to the SimplifiedDataManager class in DataManager.dart

// Enhanced component status update with better error handling and offline support
  Future<void> updateComponentStatus(
      String componentId, Status newStatus) async {
    // Ensure initialization
    if (!_isInitialized) {
      await initialize();
    }

    // Validate component existence
    if (!_components.containsKey(componentId)) {
      throw Exception('Component not found: $componentId');
    }

    // Get the current component
    final component = _components[componentId];

    // Update in memory cache immediately (optimistic update)
    _components[componentId] = Component(
      componentId: component!.componentId,
      title: component.title,
      type: component.type,
      componentStatus: newStatus,
      progress: component.progress,
      discussionQuestions: component.discussionQuestions,
      questionData: component.questionData,
      performanceTrends: component.performanceTrends,
    );

    // Try to save to local storage
    try {
      await _saveCollection(
        await SharedPreferences.getInstance(),
        'components_cache',
        _components.values.map((c) => c.toJson()).toList(),
      );
    } catch (e) {
      print('Error saving component to cache: $e');
      // Continue despite cache save error
    }

    // Check if online
    final isOnlineNow = await isOnline();
    if (isOnlineNow) {
      try {
        // Update in Firestore
        await _firestore
            .collection('components')
            .doc(componentId)
            .update({'ComponentStatus': statusToFirestore(newStatus)});

        print(
            'Component status updated in Firestore: $componentId -> ${statusToFirestore(newStatus)}');

        // Mark this update as synchronized
        _markSynchronized('components', componentId);
      } catch (e) {
        print('Error updating component in Firestore: $e');
        // Add to pending updates queue for later sync
        _addPendingUpdate('components', componentId,
            {'ComponentStatus': statusToFirestore(newStatus)});
      }
    } else {
      // No connection - add to pending updates for later sync
      _addPendingUpdate('components', componentId,
          {'ComponentStatus': statusToFirestore(newStatus)});
    }
  }

// Add these methods to track pending updates for offline mode
  final Map<String, Map<String, Map<String, dynamic>>> _pendingUpdates = {};

  void _addPendingUpdate(
      String collection, String docId, Map<String, dynamic> updates) {
    if (!_pendingUpdates.containsKey(collection)) {
      _pendingUpdates[collection] = {};
    }

    if (!_pendingUpdates[collection]!.containsKey(docId)) {
      _pendingUpdates[collection]![docId] = {};
    }

    // Merge the new updates with any existing ones
    _pendingUpdates[collection]![docId]!.addAll(updates);

    // Save pending updates to SharedPreferences
    _savePendingUpdates();

    print('Added pending update for $collection/$docId to be synced later');
  }

  void _markSynchronized(String collection, String docId) {
    if (_pendingUpdates.containsKey(collection) &&
        _pendingUpdates[collection]!.containsKey(docId)) {
      _pendingUpdates[collection]!.remove(docId);

      // If collection is empty, remove it
      if (_pendingUpdates[collection]!.isEmpty) {
        _pendingUpdates.remove(collection);
      }

      // Save updated pending updates
      _savePendingUpdates();
    }
  }

  Future<void> _savePendingUpdates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(_pendingUpdates);
      await prefs.setString('pending_updates', jsonString);
    } catch (e) {
      print('Error saving pending updates: $e');
    }
  }

  Future<void> _loadPendingUpdates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('pending_updates');

      if (jsonString != null) {
        final decoded = jsonDecode(jsonString);

        // Clear existing pending updates
        _pendingUpdates.clear();

        // Populate from saved data
        decoded.forEach((String collection, dynamic collectionData) {
          _pendingUpdates[collection] = {};

          collectionData.forEach((String docId, dynamic updates) {
            _pendingUpdates[collection]![docId] =
                Map<String, dynamic>.from(updates);
          });
        });

        print('Loaded ${_countPendingUpdates()} pending updates');
      }
    } catch (e) {
      print('Error loading pending updates: $e');
    }
  }

  int _countPendingUpdates() {
    int count = 0;
    _pendingUpdates.forEach((_, collectionData) {
      count += collectionData.length;
    });
    return count;
  }

// Add this to the initialize method in SimplifiedDataManager
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _loadFromLocalStorage();
    await _loadPendingUpdates(); // Load any pending updates

    // If cache is empty or stale, sync with Firebase
    if (_isCacheEmpty() || _isCacheStale()) {
      await syncAllData();
    } else {
      // Try to process any pending updates
      await _processPendingUpdates();
    }

    _isInitialized = true;

    // Setup connectivity listener for automatic sync when connection returns
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
          if (result != ConnectivityResult.none) {
            print('Connection restored. Syncing pending updates...');
            _processPendingUpdates();
          }
        } as void Function(List<ConnectivityResult> event)?);
  }

// Method to process pending updates when online
  Future<void> _processPendingUpdates() async {
    if (!await isOnline() || _pendingUpdates.isEmpty) {
      return;
    }

    print('Processing ${_countPendingUpdates()} pending updates...');

    // Make a copy to avoid concurrent modification
    final updatesCopy =
        Map<String, Map<String, Map<String, dynamic>>>.from(_pendingUpdates);

    for (final collection in updatesCopy.keys) {
      for (final docId in updatesCopy[collection]!.keys) {
        final updates = updatesCopy[collection]![docId]!;

        try {
          // Update in Firestore
          await _firestore.collection(collection).doc(docId).update(updates);

          // Mark as synchronized
          _markSynchronized(collection, docId);

          print('Successfully synced update for $collection/$docId');
        } catch (e) {
          print('Failed to sync update for $collection/$docId: $e');
          // Keep in pending updates
        }
      }
    }

    print(
        'Finished processing pending updates. Remaining: ${_countPendingUpdates()}');
  }

// Update multiple component statuses with batch processing
  Future<void> updateMultipleComponentStatuses(
      Map<String, Status> updates) async {
    // Ensure initialization
    if (!_isInitialized) {
      await initialize();
    }

    // Update in-memory cache immediately for all valid components
    final validUpdates = <String, Status>{};

    for (final entry in updates.entries) {
      final componentId = entry.key;
      final newStatus = entry.value;

      if (_components.containsKey(componentId)) {
        final component = _components[componentId];

        _components[componentId] = Component(
          componentId: component!.componentId,
          title: component.title,
          type: component.type,
          componentStatus: newStatus,
          progress: component.progress,
          discussionQuestions: component.discussionQuestions,
          questionData: component.questionData,
          performanceTrends: component.performanceTrends,
        );

        validUpdates[componentId] = newStatus;
      } else {
        print('Warning: Component not found in cache: $componentId');
      }
    }

    // Save to local storage
    try {
      await _saveCollection(
        await SharedPreferences.getInstance(),
        'components_cache',
        _components.values.map((c) => c.toJson()).toList(),
      );
    } catch (e) {
      print('Error saving components to cache: $e');
    }

    // Check if online
    final isOnlineNow = await isOnline();
    if (isOnlineNow && validUpdates.isNotEmpty) {
      try {
        // Create a batch
        final batch = _firestore.batch();

        // Add each update to the batch
        for (final entry in validUpdates.entries) {
          final componentId = entry.key;
          final newStatus = entry.value;

          final docRef = _firestore.collection('components').doc(componentId);
          batch.update(
              docRef, {'ComponentStatus': statusToFirestore(newStatus)});
        }

        // Commit the batch
        await batch.commit();

        print(
            'Successfully updated ${validUpdates.length} components in Firestore');

        // Mark all as synchronized
        for (final componentId in validUpdates.keys) {
          _markSynchronized('components', componentId);
        }
      } catch (e) {
        print('Error batch updating components in Firestore: $e');

        // Add all to pending updates
        for (final entry in validUpdates.entries) {
          _addPendingUpdate('components', entry.key,
              {'ComponentStatus': statusToFirestore(entry.value)});
        }
      }
    } else if (validUpdates.isNotEmpty) {
      // Offline - add all to pending updates
      for (final entry in validUpdates.entries) {
        _addPendingUpdate('components', entry.key,
            {'ComponentStatus': statusToFirestore(entry.value)});
      }
    }
  }

  /// Check if cache is completely empty
  bool _isCacheEmpty() {
    return _units.isEmpty || _lessons.isEmpty || _components.isEmpty;
  }

  /// Check if cache is stale based on last sync time
  bool _isCacheStale() {
    if (_lastSyncTime == null) return true;

    final now = DateTime.now();
    return now.difference(_lastSyncTime!) > CACHE_MAX_AGE;
  }

  /// Load cached data from local storage
  Future<void> _loadFromLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load last sync time
      final lastSyncStr = prefs.getString('last_sync_time');
      _lastSyncTime = lastSyncStr != null ? DateTime.parse(lastSyncStr) : null;

      // Load collections
      await _loadCollection<Unit>(prefs, 'units_cache',
          (json) => Unit.fromJson(json), (unit) => _units[unit.unitId] = unit);

      await _loadCollection<Lesson>(
          prefs,
          'lessons_cache',
          (json) => Lesson.fromJson(json),
          (lesson) => _lessons[lesson.lessonId] = lesson);

      await _loadCollection<Component>(
          prefs,
          'components_cache',
          (json) => Component.fromJson(json),
          (component) => _components[component.componentId] = component);

      await _loadCollection<Classroom>(
          prefs,
          'classrooms_cache',
          (json) => Classroom.fromJson(json),
          (classroom) => _classrooms[classroom.classId] = classroom);

      await _loadCollection<Teacher>(
          prefs,
          'teachers_cache',
          (json) => Teacher.fromJson(json),
          (teacher) => _teachers[teacher.id] = teacher);

      print(
          'Loaded ${_units.length} units, ${_lessons.length} lessons, ${_components.length} components from cache');
    } catch (e) {
      print('Error loading cached data: $e');
      // Clear collections on error
      _clearCollections();
    }
  }

  /// Helper to load a collection from SharedPreferences
  Future<void> _loadCollection<T>(
      SharedPreferences prefs,
      String key,
      T Function(Map<String, dynamic>) fromJson,
      void Function(T) addToCollection) async {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return;

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      for (final json in jsonList) {
        final item = fromJson(json);
        addToCollection(item);
      }
    } catch (e) {
      print('Error loading $key: $e');
    }
  }

  /// Save all collections to local storage
  Future<void> _saveToLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save last sync time
      await prefs.setString('last_sync_time', DateTime.now().toIso8601String());

      // Save collections
      await _saveCollection(
          prefs, 'units_cache', _units.values.map((u) => u.toJson()).toList());
      await _saveCollection(prefs, 'lessons_cache',
          _lessons.values.map((l) => l.toJson()).toList());
      await _saveCollection(prefs, 'components_cache',
          _components.values.map((c) => c.toJson()).toList());
      await _saveCollection(prefs, 'classrooms_cache',
          _classrooms.values.map((c) => c.toJson()).toList());
      await _saveCollection(prefs, 'teachers_cache',
          _teachers.values.map((t) => t.toJson()).toList());

      print(
          'Saved ${_units.length} units, ${_lessons.length} lessons, ${_components.length} components to cache');
    } catch (e) {
      print('Error saving cached data: $e');
    }
  }

  /// Helper to save a collection to SharedPreferences
  Future<void> _saveCollection(SharedPreferences prefs, String key,
      List<Map<String, dynamic>> jsonList) async {
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(key, jsonString);
  }

  /// Clear all cached collections
  void _clearCollections() {
    _units = {};
    _lessons = {};
    _components = {};
    _classrooms = {};
    _teachers = {};
    _students = {};
  }

  /// Check if device is online
  Future<bool> isOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  /// Synchronize all data with Firestore
  Future<void> syncAllData() async {
    if (!await isOnline()) {
      print('Cannot sync with Firestore: Device is offline');
      return;
    }

    try {
      // Fetch all collections
      await _syncUnits();
      await _syncLessons();
      await _syncComponents();
      await _syncClassrooms();
      await _syncTeachers();

      // Update last sync time
      _lastSyncTime = DateTime.now();

      // Save to local storage
      await _saveToLocalStorage();

      print('Successfully synced all data with Firestore');
    } catch (e) {
      print('Error syncing with Firestore: $e');
    }
  }

  /// Sync units from Firestore
  Future<void> _syncUnits() async {
    final querySnapshot = await _firestore.collection('units').get();
    _units.clear();

    for (final doc in querySnapshot.docs) {
      final unit = Unit.fromFirestore(doc.data(), doc.id);
      _units[unit.unitId] = unit;
    }
  }

  /// Sync lessons from Firestore
  Future<void> _syncLessons() async {
    final querySnapshot = await _firestore.collection('lessons').get();
    _lessons.clear();

    for (final doc in querySnapshot.docs) {
      final lesson = Lesson.fromFirestore(doc.data(), doc.id);
      _lessons[lesson.lessonId] = lesson;
    }
  }

  /// Sync components from Firestore
  Future<void> _syncComponents() async {
    final querySnapshot = await _firestore.collection('components').get();
    _components.clear();

    for (final doc in querySnapshot.docs) {
      final component = Component.fromFirestore(doc.data(), doc.id);
      _components[component.componentId] = component;
    }
  }

  /// Sync classrooms from Firestore
  Future<void> _syncClassrooms() async {
    final querySnapshot = await _firestore.collection('classrooms').get();
    _classrooms.clear();

    for (final doc in querySnapshot.docs) {
      final classroom = Classroom.fromFirestore(doc.data(), doc.id);
      _classrooms[classroom.classId] = classroom;
    }
  }

  /// Sync teachers from Firestore
  Future<void> _syncTeachers() async {
    final querySnapshot = await _firestore.collection('teachers').get();
    _teachers.clear();

    for (final doc in querySnapshot.docs) {
      final teacher = Teacher.fromFirestore(doc.data(), doc.id);
      _teachers[teacher.id] = teacher;
    }
  }

  // Data access methods

  /// Get a unit by ID
  Unit? getUnit(String unitId) {
    _ensureInitialized();
    return _units[unitId];
  }

  /// Get all units
  List<Unit> getAllUnits() {
    _ensureInitialized();
    return _units.values.toList();
  }

  /// Get units for a specific difficulty level
  List<Unit> getUnitsForDifficulty(String difficulty) {
    _ensureInitialized();
    return _units.values
        .where((unit) => unit.unitId.startsWith(difficulty))
        .toList();
  }

  /// Get a lesson by ID
  Lesson? getLesson(String lessonId) {
    _ensureInitialized();
    return _lessons[lessonId];
  }

  /// Get all lessons
  List<Lesson> getAllLessons() {
    _ensureInitialized();
    return _lessons.values.toList();
  }

  /// Get a component by ID
  Component? getComponent(String componentId) {
    _ensureInitialized();
    return _components[componentId];
  }

  /// Get all components for a specific lesson
  List<Component> getComponentsForLesson(String lessonId) {
    _ensureInitialized();
    final lesson = _lessons[lessonId];
    if (lesson == null) return [];

    return lesson.components
        .map((id) => _components[id])
        .where((comp) => comp != null)
        .cast<Component>()
        .toList();
  }

  /// Get a classroom by ID
  Classroom? getClassroom(String classroomId) {
    _ensureInitialized();
    return _classrooms[classroomId];
  }

  /// Get all classrooms for a teacher
  List<Classroom> getClassroomsForTeacher(String teacherId) {
    _ensureInitialized();
    return _classrooms.values
        .where((classroom) => classroom.teacherId == teacherId)
        .toList();
  }

  /// Get a teacher by ID
  Teacher? getTeacher(String teacherId) {
    _ensureInitialized();
    return _teachers[teacherId];
  }

  /// Get a student by ID (may load from Firebase if not cached)
  Future<Student?> getStudent(String studentId) async {
    _ensureInitialized();

    // Try cache first
    if (_students.containsKey(studentId)) {
      return _students[studentId];
    }

    // If online, fetch from Firestore
    if (await isOnline()) {
      try {
        final doc =
            await _firestore.collection('students').doc(studentId).get();
        if (!doc.exists) return null;

        final student = Student.fromFirestore(doc.data()!, doc.id);
        _students[studentId] = student;
        return student;
      } catch (e) {
        print('Error fetching student from Firestore: $e');
        return null;
      }
    }

    return null;
  }

  /// Update student progress (always goes to Firestore)
  Future<void> updateStudentProgress(String studentId, String progress) async {
    if (!await isOnline()) {
      throw Exception('Cannot update progress while offline');
    }

    await _firestore
        .collection('students')
        .doc(studentId)
        .update({'progress': progress});

    // Update local cache if student exists
    if (_students.containsKey(studentId)) {
      // We'd need a setter for this in the Student class
      // For now, we'll just refetch the student
      final doc = await _firestore.collection('students').doc(studentId).get();
      if (doc.exists) {
        _students[studentId] = Student.fromFirestore(doc.data()!, doc.id);
      }
    }
  }

  /// Ensure the data manager is initialized
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('DataManager not initialized. Call initialize() first.');
    }
  }

  /// Clear the cache (for testing or logout)
  Future<void> clearCache() async {
    _clearCollections();
    _lastSyncTime = null;
    _isInitialized = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_sync_time');
    await prefs.remove('units_cache');
    await prefs.remove('lessons_cache');
    await prefs.remove('components_cache');
    await prefs.remove('classrooms_cache');
    await prefs.remove('teachers_cache');
  }
}
