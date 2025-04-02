import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Services/DataManager.dart';
import 'package:money_monkey/Backend/Services/SampleDataConverter.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAcademicService {
  final Map<String, Classroom> _classrooms;
  final Map<String, Unit> _units;
  final Map<String, Lesson> _lessons;
  final Map<String, Component> _components;

  LocalAcademicService({
    Map<String, Classroom>? classrooms,
    Map<String, Unit>? units,
    Map<String, Lesson>? lessons,
    Map<String, Component>? components,
  })  : _classrooms = classrooms ?? sampleClassrooms,
        _units = units ?? advancedUnits,
        _lessons = lessons ?? advancedLessons,
        _components = components ?? advancedComponents;

  // Get all classes mapped by their IDs and names
  Map<String, String> getAllClassrooms() => Map.fromEntries(_classrooms.entries
      .map((entry) => MapEntry(entry.key, entry.value.name)));

  // Get methods with consistent error handling
  T _getEntityById<T>(Map<String, T> collection, String id, String entityName) {
    final entity = collection[id];
    if (entity == null) throw Exception('$entityName not found: $id');
    return entity;
  }

  Classroom getClassRoom(String classRoomId) =>
      _getEntityById(_classrooms, classRoomId, 'Classroom');

  Unit getUnit(String unitId) => _getEntityById(_units, unitId, 'Unit');

  Lesson getLesson(String lessonId) =>
      _getEntityById(_lessons, lessonId, 'Lesson');

  Component getComponent(String componentId) =>
      _getEntityById(_components, componentId, 'Component');

  // Simplified name getters
  String getLessonName(String lessonId) => getLesson(lessonId).title;

  String getUnitName(String unitId) => getUnit(unitId).title;

  String getComponentName(String componentId) =>
      getComponent(componentId).title;

  String getNextLessonId(String currentLessonId) {
    final parts = currentLessonId.split('.');
    if (parts.length != 3) throw Exception('Invalid lesson ID format');

    // Try next lesson in same unit
    final nextLessonNumber = int.parse(parts[2]) + 1;
    final nextLessonId = '${parts[0]}.${parts[1]}.$nextLessonNumber';
    if (_lessons.containsKey(nextLessonId)) {
      return nextLessonId;
    }

    // Try first lesson in next unit
    final nextUnitNumber = int.parse(parts[1]) + 1;
    final nextUnitLessonId = '${parts[0]}.$nextUnitNumber.1';
    if (_lessons.containsKey(nextUnitLessonId)) {
      return nextUnitLessonId;
    }

    throw Exception('No next lesson found');
  }
  String getNextLessonDescription(String currentLessonId) {
    final parts = currentLessonId.split('.');
    if (parts.length != 3) throw Exception('Invalid lesson ID format');

    // Try next lesson in same unit
    final nextLessonNumber = int.parse(parts[2]) + 1;
    final nextLessonDescription = '${parts[0]}.${parts[1]}.$nextLessonNumber';
    if (_lessons.containsKey(nextLessonDescription)) {
      return nextLessonDescription;
    }

    // Try first lesson in next unit
    final nextUnitNumber = int.parse(parts[1]) + 1;
    final nextUnitLessonId = '${parts[0]}.$nextUnitNumber.1';
    if (_lessons.containsKey(nextUnitLessonId)) {
      return nextUnitLessonId;
    }

    throw Exception('No next lesson found');
  }

  String getActiveComponentStatus(String componentId) {
    try {
      return statusToFirestore(getComponent(componentId).componentStatus);
    } catch (_) {
      return 'inactive';
    }
  }

  // Status getters with consistent naming
  Status getComponentStatus(String componentId) =>
      getComponent(componentId).componentStatus;

  Status getLessonStatus(String lessonId) => getLesson(lessonId).lessonStatus;

  // Collection filtering
  List<Unit> getUnitsForDifficulty(String difficulty) => _units.values
      .where((unit) => unit.unitId.startsWith(difficulty))
      .toList();

  // Count getters
  int getLessonComponentCount(String lessonId) =>
      getLesson(lessonId).totalComponents;

  int getUnitLessonsCount(String unitId) => getUnit(unitId).totalLessons;

  int getUnitTotalComponents(String unitId) {
    final unit = getUnit(unitId);
    return unit.lessonIds.fold<int>(
        0, (total, lessonId) => total + getLesson(lessonId).totalComponents);
  }

  List<String> getLessonComponents(String lessonId) {
    try {
      return getLesson(lessonId).components;
    } catch (e) {
      return [];
    }
  }

  Map<String, List<String>> getComponentDiscussionQuestionsForLesson(
      String lessonId) {
    try {
      final lesson = getLesson(lessonId);
      final Map<String, List<String>> questionsMap = {};

      for (final componentId in lesson.components) {
        try {
          final component = getComponent(componentId);
          if (component.discussionQuestions != null) {
            questionsMap[componentId] = component.discussionQuestions!;
          }
        } catch (e) {
          // Skip components with errors
        }
      }

      return questionsMap;
    } catch (_) {
      return {};
    }
  }

  List<PerformanceTrends> getAllComponentPerformances(String lessonId) {
    final _lesson = getLesson(lessonId);
    List<PerformanceTrends> trends = [];
    for (String compId in _lesson.components) {
      Component tempComp = getComponent(compId);
      trends.add(tempComp.performanceTrends);
    }
    return trends;
  }
}

class CachedDataService {
  static final CachedDataService _instance = CachedDataService._internal();
  
  factory CachedDataService() {
    return _instance;
  }
  
  CachedDataService._internal();
  
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Local data cache
  late Teacher _teacher;
  late Map<String, Classroom> _classrooms;
  late List<Student> _students;
  late Map<String, Unit> _units;
  late Map<String, Lesson> _lessons;
  late Map<String, Component> _components;
  
  // Cache status
  bool _isInitialized = false;
  DateTime? _lastSyncTime;
  
  // Maximum age of cache before refresh (24 hours)
  static const Duration CACHE_MAX_AGE = Duration(hours: 24);
  
  // Cache keys
  static const String CACHE_KEY = 'academic_data_cache';
  static const String LAST_SYNC_KEY = 'academic_data_last_sync';
  
  /// Check if the cache is initialized
  bool get isInitialized => _isInitialized;
  
  /// Initialize the service and load cached data
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // Load cache from shared preferences
    final loadedFromCache = await _loadCachedData();
    
    // If we failed to load from cache, load bundled data
    if (!loadedFromCache) {
      await _loadBundledData();
    }
    
    // If cache is stale and online, sync with Firebase
    if (_isCacheStale() && await _isOnline()) {
      try {
        await syncWithFirebase();
      } catch (e) {
        print('Error syncing with Firebase: $e');
        // Continue with cached data even if sync fails
      }
    }
    
    _isInitialized = true;
  }
  
  /// Check if the cache is stale based on last sync time
  bool _isCacheStale() {
    if (_lastSyncTime == null) return true;
    
    final now = DateTime.now();
    return now.difference(_lastSyncTime!) > CACHE_MAX_AGE;
  }
  
  /// Check if device is online
  Future<bool> _isOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  
  /// Load data from shared preferences
  Future<bool> _loadCachedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load last sync time
      final lastSyncStr = prefs.getString(LAST_SYNC_KEY);
      _lastSyncTime = lastSyncStr != null ? DateTime.parse(lastSyncStr) : null;
      
      // Load cache data
      final cachedData = prefs.getString(CACHE_KEY);
      if (cachedData == null) return false;
      
      final loadedData = SampleDataConverter.loadFromJsonString(cachedData);
      
      _teacher = loadedData['teacher'];
      _classrooms = loadedData['classrooms'];
      _students = loadedData['students'];
      _units = loadedData['units'];
      _lessons = loadedData['lessons'];
      _components = loadedData['components'];
      
      print('Loaded cached data from shared preferences');
      return true;
    } catch (e) {
      print('Error loading cached data: $e');
      return false;
    }
  }
  
  /// Load bundled data from assets
  Future<void> _loadBundledData() async {
    try {
      // Load data from assets
      final jsonString = await rootBundle.loadString('assets/sample_data.json');
      final loadedData = SampleDataConverter.loadFromJsonString(jsonString);
      
      _teacher = loadedData['teacher'];
      _classrooms = loadedData['classrooms'];
      _students = loadedData['students'];
      _units = loadedData['units'];
      _lessons = loadedData['lessons'];
      _components = loadedData['components'];
      
      print('Loaded bundled data from assets');
    } catch (e) {
      print('Error loading bundled data: $e');
      
      // Fall back to hard-coded sample data if all else fails
      _teacher = sampleTeacher;
      _classrooms = sampleClassrooms;
      _students = sampleStudents;
      _units = advancedUnits;
      _lessons = advancedLessons;
      _components = advancedComponents;
      
      print('Falling back to hardcoded sample data');
    }
  }
  
  /// Save current data to shared preferences
  Future<void> _saveCachedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Save last sync time
      final now = DateTime.now();
      await prefs.setString(LAST_SYNC_KEY, now.toIso8601String());
      _lastSyncTime = now;
      
      // Save cached data
      final jsonString = SampleDataConverter.convertToJsonString(
        _teacher,
        _classrooms,
        _students,
        _units,
        _lessons,
        _components,
      );
      
      await prefs.setString(CACHE_KEY, jsonString);
      print('Saved data to cache');
    } catch (e) {
      print('Error saving cache data: $e');
    }
  }
  
  /// Synchronize all data with Firestore
  Future<void> syncWithFirebase() async {
    if (!await _isOnline()) {
      print('Cannot sync with Firestore: Device is offline');
      return;
    }
    
    print('Syncing data with Firestore...');
    
    try {
      // Sync units
      await _syncUnits();
      
      // Sync lessons
      await _syncLessons();
      
      // Sync components
      await _syncComponents();
      
      // Sync classrooms
      await _syncClassrooms();
      
      // Sync teacher
      await _syncTeacher();
      
      // Save updated data to cache
      await _saveCachedData();
      
      print('Successfully synced all data with Firestore');
    } catch (e) {
      print('Error during Firestore sync: $e');
      throw e;
    }
  }
  
  /// Sync units from Firestore
  Future<void> _syncUnits() async {
    try {
      final querySnapshot = await _firestore.collection('units').get();
      
      final Map<String, Unit> updatedUnits = {};
      for (final doc in querySnapshot.docs) {
        final unit = Unit.fromFirestore(doc.data(), doc.id);
        updatedUnits[unit.unitId] = unit;
      }
      
      // Keep existing units if Firestore returned an empty set
      if (updatedUnits.isNotEmpty) {
        _units = updatedUnits;
      }
    } catch (e) {
      print('Error syncing units: $e');
    }
  }
  
  /// Sync lessons from Firestore
  Future<void> _syncLessons() async {
    try {
      final querySnapshot = await _firestore.collection('lessons').get();
      
      final Map<String, Lesson> updatedLessons = {};
      for (final doc in querySnapshot.docs) {
        final lesson = Lesson.fromFirestore(doc.data(), doc.id);
        updatedLessons[lesson.lessonId] = lesson;
      }
      
      // Keep existing lessons if Firestore returned an empty set
      if (updatedLessons.isNotEmpty) {
        _lessons = updatedLessons;
      }
    } catch (e) {
      print('Error syncing lessons: $e');
    }
  }
  
  /// Sync components from Firestore
  Future<void> _syncComponents() async {
    try {
      final querySnapshot = await _firestore.collection('components').get();
      
      final Map<String, Component> updatedComponents = {};
      for (final doc in querySnapshot.docs) {
        final component = Component.fromFirestore(doc.data(), doc.id);
        updatedComponents[component.componentId] = component;
      }
      
      // Keep existing components if Firestore returned an empty set
      if (updatedComponents.isNotEmpty) {
        _components = updatedComponents;
      }
    } catch (e) {
      print('Error syncing components: $e');
    }
  }
  
  /// Sync classrooms from Firestore
  Future<void> _syncClassrooms() async {
    try {
      final querySnapshot = await _firestore.collection('classrooms').get();
      
      final Map<String, Classroom> updatedClassrooms = {};
      for (final doc in querySnapshot.docs) {
        final classroom = Classroom.fromFirestore(doc.data(), doc.id);
        updatedClassrooms[classroom.classId] = classroom;
      }
      
      // Keep existing classrooms if Firestore returned an empty set
      if (updatedClassrooms.isNotEmpty) {
        _classrooms = updatedClassrooms;
      }
    } catch (e) {
      print('Error syncing classrooms: $e');
    }
  }
  
  /// Sync teacher from Firestore
  Future<void> _syncTeacher() async {
    try {
      final docSnapshot = await _firestore
          .collection('teachers')
          .doc(_teacher.id)
          .get();
      
      if (docSnapshot.exists) {
        _teacher = Teacher.fromFirestore(docSnapshot.data()!, docSnapshot.id);
      }
    } catch (e) {
      print('Error syncing teacher: $e');
    }
  }
  
  /// Get a unit by ID
  Unit getUnit(String unitId) {
    _ensureInitialized();
    final unit = _units[unitId];
    if (unit == null) {
      throw Exception('Unit not found: $unitId');
    }
    return unit;
  }
  
  /// Get all units
  List<Unit> getAllUnits() {
    _ensureInitialized();
    return _units.values.toList();
  }
  
  /// Get all units for a specific difficulty
  List<Unit> getUnitsForDifficulty(String difficulty) {
    _ensureInitialized();
    return _units.values
        .where((unit) => unit.unitId.startsWith(difficulty))
        .toList();
  }
  
  /// Get a lesson by ID
  Lesson getLesson(String lessonId) {
    _ensureInitialized();
    final lesson = _lessons[lessonId];
    if (lesson == null) {
      throw Exception('Lesson not found: $lessonId');
    }
    return lesson;
  }
  
  /// Get all lessons
  List<Lesson> getAllLessons() {
    _ensureInitialized();
    return _lessons.values.toList();
  }
  
  /// Get a component by ID
  Component getComponent(String componentId) {
    _ensureInitialized();
    final component = _components[componentId];
    if (component == null) {
      throw Exception('Component not found: $componentId');
    }
    return component;
  }
  
  /// Get all components for a lesson
  List<Component> getComponentsForLesson(String lessonId) {
    _ensureInitialized();
    final lesson = getLesson(lessonId);
    final components = <Component>[];
    
    for (final componentId in lesson.components) {
      try {
        final component = getComponent(componentId);
        components.add(component);
      } catch (e) {
        print('Error loading component $componentId: $e');
      }
    }
    
    return components;
  }
  
  /// Get a classroom by ID
  Classroom getClassroom(String classroomId) {
    _ensureInitialized();
    final classroom = _classrooms[classroomId];
    if (classroom == null) {
      throw Exception('Classroom not found: $classroomId');
    }
    return classroom;
  }
  
  /// Get all classrooms
  List<Classroom> getAllClassrooms() {
    _ensureInitialized();
    return _classrooms.values.toList();
  }
  
  /// Get all classrooms for a teacher
  List<Classroom> getClassroomsForTeacher(String teacherId) {
    _ensureInitialized();
    return _classrooms.values
        .where((classroom) => classroom.teacherId == teacherId)
        .toList();
  }
  
  /// Get the teacher
  Teacher getTeacher() {
    _ensureInitialized();
    return _teacher;
  }
  
  /// Get a student by ID
  Student getStudent(String studentId) {
    _ensureInitialized();
    final student = _students.firstWhere(
      (s) => s.studentId == studentId,
      orElse: () => throw Exception('Student not found: $studentId'),
    );
    return student;
  }
  
  /// Update student progress (still goes to Firestore)
  Future<void> updateStudentProgress(String studentId, String progress) async {
    if (!await _isOnline()) {
      throw Exception('Cannot update progress while offline');
    }
    
    // Update in Firestore
    await _firestore
        .collection('students')
        .doc(studentId)
        .update({'progress': progress});
        
    // Update local cache
    final studentIndex = _students.indexWhere((s) => s.studentId == studentId);
    if (studentIndex >= 0) {
      // Since Student is immutable (final fields), we need to create a new one
      // Ideally, we'd refactor Student to have a copyWith method
      final currentStudent = _students[studentIndex];
      _students[studentIndex] = Student(
        studentId: currentStudent.studentId,
        email: currentStudent.email,
        phoneNumber: currentStudent.phoneNumber,
        age: currentStudent.age,
        knowledgeLevel: currentStudent.knowledgeLevel,
        learningGoalPerDay: currentStudent.learningGoalPerDay,
        startingLevel: currentStudent.startingLevel,
        classRooms: currentStudent.classRooms,
        progress: progress, // Update the progress
        profile: currentStudent.profile,
        settings: currentStudent.settings,
      );
      
      // Save updated cache
      await _saveCachedData();
    }
  }
  
  /// Ensure the service is initialized
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('CachedDataService not initialized. Call initialize() first.');
    }
  }
  
  /// Clear the cache (for testing or logout)
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(CACHE_KEY);
    await prefs.remove(LAST_SYNC_KEY);
    _isInitialized = false;
  }
}
class CachedAcademicService {
  final SimplifiedDataManager _dataManager;
  
  CachedAcademicService({SimplifiedDataManager? dataManager}) 
      : _dataManager = dataManager ?? SimplifiedDataManager();
  
  // Initialize the service
  Future<void> initialize() async {
    await _dataManager.initialize();
  }
  
  // Get methods with error handling
  T _getEntityById<T>(T? entity, String id, String entityName) {
    if (entity == null) {
      throw Exception('$entityName not found: $id');
    }
    return entity;
  }
  
  // Get a classroom by ID
  Classroom getClassRoom(String classRoomId) {
    return _getEntityById(
      _dataManager.getClassroom(classRoomId), 
      classRoomId, 
      'Classroom'
    );
  }
  
  // Get a unit by ID
  Unit getUnit(String unitId) {
    return _getEntityById(
      _dataManager.getUnit(unitId), 
      unitId, 
      'Unit'
    );
  }
  
  // Get a lesson by ID
  Lesson getLesson(String lessonId) {
    return _getEntityById(
      _dataManager.getLesson(lessonId), 
      lessonId, 
      'Lesson'
    );
  }
  
  // Get a component by ID
  Component getComponent(String componentId) {
    return _getEntityById(
      _dataManager.getComponent(componentId), 
      componentId, 
      'Component'
    );
  }
  
  // Get all classrooms (compatible with your existing API)
  Map<String, String> getAllClassrooms() {
    final classrooms = _dataManager.getClassroomsForTeacher('temporaryTeacherId2025');
    return Map.fromEntries(classrooms
        .map((classroom) => MapEntry(classroom.classId, classroom.name)));
  }
  
  // Name getters
  String getLessonName(String lessonId) => getLesson(lessonId).title;
  String getUnitName(String unitId) => getUnit(unitId).title;
  String getComponentName(String componentId) => getComponent(componentId).title;
  
  // Get next lesson ID
  String getNextLessonId(String currentLessonId) {
    final parts = currentLessonId.split('.');
    if (parts.length != 3) throw Exception('Invalid lesson ID format');

    // Try next lesson in same unit
    final nextLessonNumber = int.parse(parts[2]) + 1;
    final nextLessonId = '${parts[0]}.${parts[1]}.$nextLessonNumber';
    if (_dataManager.getLesson(nextLessonId) != null) {
      return nextLessonId;
    }

    // Try first lesson in next unit
    final nextUnitNumber = int.parse(parts[1]) + 1;
    final nextUnitLessonId = '${parts[0]}.$nextUnitNumber.1';
    if (_dataManager.getLesson(nextUnitLessonId) != null) {
      return nextUnitLessonId;
    }

    throw Exception('No next lesson found');
  }
  
  // Get next lesson description (same as ID function)
  String getNextLessonDescription(String currentLessonId) {
    return getNextLessonId(currentLessonId);
  }
  
  // Get lesson components
  List<String> getLessonComponents(String lessonId) {
    try {
      return getLesson(lessonId).components;
    } catch (e) {
      return [];
    }
  }
  
  // Get component status
  String getActiveComponentStatus(String componentId) {
    try {
      return statusToFirestore(getComponent(componentId).componentStatus);
    } catch (_) {
      return 'inactive';
    }
  }

  // Status getters
  Status getComponentStatus(String componentId) => 
      getComponent(componentId).componentStatus;

  Status getLessonStatus(String lessonId) => 
      getLesson(lessonId).lessonStatus;
  
  // Collection filtering
  List<Unit> getUnitsForDifficulty(String difficulty) {
    return _dataManager.getAllUnits()
        .where((unit) => unit.unitId.startsWith(difficulty))
        .toList();
  }
  
  // Count getters
  int getLessonComponentCount(String lessonId) =>
      getLesson(lessonId).totalComponents;

  int getUnitLessonsCount(String unitId) => 
      getUnit(unitId).totalLessons;

  int getUnitTotalComponents(String unitId) {
    final unit = getUnit(unitId);
    return unit.lessonIds.fold<int>(
        0, (total, lessonId) => total + getLesson(lessonId).totalComponents);
  }
  
  // Get discussion questions for lesson components
  Map<String, List<String>> getComponentDiscussionQuestionsForLesson(String lessonId) {
    try {
      final lesson = getLesson(lessonId);
      final Map<String, List<String>> questionsMap = {};

      for (final componentId in lesson.components) {
        try {
          final component = getComponent(componentId);
          if (component.discussionQuestions != null) {
            questionsMap[componentId] = component.discussionQuestions!;
          }
        } catch (e) {
          // Skip components with errors
        }
      }

      return questionsMap;
    } catch (_) {
      return {};
    }
  }
  
  // Get performance trends for all components in a lesson
  List<PerformanceTrends> getAllComponentPerformances(String lessonId) {
    final lesson = getLesson(lessonId);
    List<PerformanceTrends> trends = [];
    for (String compId in lesson.components) {
      Component tempComp = getComponent(compId);
      trends.add(tempComp.performanceTrends);
    }
    return trends;
  }
  
  // Force sync with Firebase
  Future<void> syncWithFirebase() async {
    await _dataManager.syncAllData();
  }
}