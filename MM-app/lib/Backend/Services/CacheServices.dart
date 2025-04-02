import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class TeacherCacheBuilder {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Main function to build the cache
  Future<void> buildTeacherCache(String teacherId) async {
    try {
      // Validate teacherId first
      if (teacherId.isEmpty) {
        throw Exception('Teacher ID cannot be empty. Please provide a valid teacher ID.');
      }

      // Initialize the cache structure
      final Map<String, dynamic> cache = {
        'teacher': {},
        'classrooms': {},
        'students': [],
        'units': {},
        'lessons': {},
        'components': {},
        'metadata': {
          'version': '1.0.0',
          'generatedAt': DateTime.now().toIso8601String(),
        }
      };

      print('Starting cache build for teacher: $teacherId');

      // 1. Fetch teacher data
      print('Fetching teacher data...');
      final Teacher teacher = await _fetchTeacher(teacherId);
      cache['teacher'] = teacher.toJson();
      print('Teacher data fetched successfully.');

      // 2. Fetch classrooms
      print('Fetching ${teacher.classRooms.length} classrooms...');
      final Map<String, Classroom> classrooms = await _fetchClassrooms(teacher.classRooms);
      cache['classrooms'] = _mapToJson(classrooms);
      print('Fetched ${classrooms.length} classrooms successfully.');

      // 3. Fetch students from all classrooms
      print('Extracting student IDs from classrooms...');
      final Set<String> studentIds = _extractStudentIds(classrooms);
      print('Fetching ${studentIds.length} students...');
      final List<Student> students = await _fetchStudents(studentIds);
      cache['students'] = students.map((student) => student.toJson()).toList();
      print('Fetched ${students.length} students successfully.');

      // 4. Fetch lessons from classrooms
      print('Extracting lesson IDs from classrooms...');
      final Set<String> lessonIds = _extractLessonIds(classrooms);
      print('Fetching ${lessonIds.length} lessons...');
      final Map<String, Lesson> lessons = await _fetchLessons(lessonIds);
      cache['lessons'] = _mapToJson(lessons);
      print('Fetched ${lessons.length} lessons successfully.');

      // 5. Extract unit IDs from lessons and fetch units
      print('Extracting unit IDs from lessons...');
      final Set<String> unitIds = _extractUnitIds(lessons);
      print('Fetching ${unitIds.length} units...');
      final Map<String, Unit> units = await _fetchUnits(unitIds);
      cache['units'] = _mapToJson(units);
      print('Fetched ${units.length} units successfully.');

      // 6. Extract component IDs from lessons and fetch components
      print('Extracting component IDs from lessons...');
      final Set<String> componentIds = _extractComponentIds(lessons);
      print('Fetching ${componentIds.length} components...');
      final Map<String, Component> components = await _fetchComponents(componentIds);
      cache['components'] = _mapToJson(components);
      print('Fetched ${components.length} components successfully.');

      // Store to SharedPreferences instead of file (for web compatibility)
      print('Storing cache in web-compatible storage...');
      await TeacherDashboardCache.storeCache(cache);

      print('Teacher cache successfully built!');
      print('Cache details:');
      print('- Teacher: ${teacher.name} (${teacher.id})');
      print('- Classrooms: ${classrooms.length}');
      print('- Students: ${students.length}');
      print('- Units: ${units.length}');
      print('- Lessons: ${lessons.length}');
      print('- Components: ${components.length}');
      print('- Generated at: ${cache["metadata"]["generatedAt"]}');
    } catch (e) {
      print('Error building teacher cache: $e');
      throw Exception('Failed to build teacher cache: $e');
    }
  }
  
  // Fetch teacher data
  Future<Teacher> _fetchTeacher(String teacherId) async {
    try {
      // Double-check the teacherId before sending to Firestore
      if (teacherId.isEmpty) {
        throw Exception('Teacher ID cannot be empty');
      }
      
      final DocumentSnapshot doc = await _firestore.collection('Teachers').doc(teacherId).get();

      if (!doc.exists) {
        throw Exception('Teacher not found with ID: $teacherId');
      }

      // The upload script uses a slightly different naming convention
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Teacher(
        name: data['Name'] ?? '',
        id: doc.id,
        classRooms: List<String>.from(data['ClassRooms'] ?? []),
        profilePictureLink: data['ProfilePictureLink'] ?? '',
      );
    } catch (e) {
      print('Error fetching teacher: $e');
      rethrow;
    }
  }

  // Fetch classrooms
  Future<Map<String, Classroom>> _fetchClassrooms(List<String> classroomIds) async {
    try {
      Map<String, Classroom> classrooms = {};

      for (String id in classroomIds) {
        if (id.isEmpty) {
          print('Skipping empty classroom ID');
          continue;
        }

        final DocumentSnapshot doc = await _firestore.collection('Classrooms').doc(id).get();

        if (doc.exists) {
          classrooms[id] = Classroom.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
        } else {
          print('Classroom with ID $id not found');
        }
      }

      return classrooms;
    } catch (e) {
      print('Error fetching classrooms: $e');
      rethrow;
    }
  }

  // Extract all student IDs from classrooms
  Set<String> _extractStudentIds(Map<String, Classroom> classrooms) {
    final Set<String> studentIds = {};

    for (final classroom in classrooms.values) {
      studentIds.addAll(classroom.studentIds.where((id) => id.isNotEmpty));
    }

    return studentIds;
  }

  // Fetch student data
  Future<List<Student>> _fetchStudents(Set<String> studentIds) async {
    try {
      List<Student> students = [];

      for (String id in studentIds) {
        if (id.isEmpty) {
          print('Skipping empty student ID');
          continue;
        }

        final DocumentSnapshot doc = await _firestore.collection('Students').doc(id).get();

        if (doc.exists) {
          students.add(Student.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
        } else {
          print('Student with ID $id not found');
        }
      }

      return students;
    } catch (e) {
      print('Error fetching students: $e');
      rethrow;
    }
  }

  // Extract all lesson IDs from classrooms
  Set<String> _extractLessonIds(Map<String, Classroom> classrooms) {
    final Set<String> lessonIds = {};

    for (final classroom in classrooms.values) {
      if (classroom.lessonId.isNotEmpty) {
        lessonIds.add(classroom.lessonId);
      }
    }

    return lessonIds;
  }

  // Fetch lessons using the LessonsIndex collection for direct access
  Future<Map<String, Lesson>> _fetchLessons(Set<String> lessonIds) async {
    try {
      Map<String, Lesson> lessons = {};

      for (String id in lessonIds) {
        if (id.isEmpty) {
          print('Skipping empty lesson ID');
          continue;
        }

        // First try the LessonsIndex for the path
        try {
          final DocumentSnapshot indexDoc = await _firestore.collection('LessonsIndex').doc(id).get();

          if (indexDoc.exists) {
            final indexData = indexDoc.data() as Map<String, dynamic>;
            final String path = indexData['path'] ?? '';

            if (path.isNotEmpty) {
              // Use the path to get the full lesson document
              final DocumentSnapshot lessonDoc = await _firestore.doc(path).get();

              if (lessonDoc.exists) {
                lessons[id] = Lesson.fromFirestore(lessonDoc.data() as Map<String, dynamic>, id);
                continue;
              }
            }
          }
        } catch (e) {
          print('Error fetching lesson $id from LessonsIndex: $e');
        }

        // Fallback - try to construct the path based on the lesson ID pattern (e.g., "A.1.2")
        final parts = id.split('.');
        if (parts.length >= 3) {
          final String unitId = '${parts[0]}.${parts[1]}';
          final String path = 'Levels/Advanced/Units/$unitId/Lessons/$id';

          try {
            final DocumentSnapshot lessonDoc = await _firestore.doc(path).get();

            if (lessonDoc.exists) {
              lessons[id] = Lesson.fromFirestore(lessonDoc.data() as Map<String, dynamic>, id);
              continue; // Successfully fetched, move to next
            }
          } catch (e) {
            print('Error fetching lesson $id using constructed path: $e');
          }

          // Try one more approach - direct collection
          try {
            final DocumentSnapshot directDoc = await _firestore.collection('Lessons').doc(id).get();

            if (directDoc.exists) {
              lessons[id] = Lesson.fromFirestore(directDoc.data() as Map<String, dynamic>, id);
            } else {
              print('Lesson with ID $id not found in any location');
            }
          } catch (innerE) {
            print('Error fetching lesson $id from direct collection: $innerE');
          }
        } else {
          print('Lesson ID $id has invalid format');
        }
      }

      return lessons;
    } catch (e) {
      print('Error fetching lessons: $e');
      rethrow;
    }
  }

  // Extract unit IDs from lessons
  Set<String> _extractUnitIds(Map<String, Lesson> lessons) {
    final Set<String> unitIds = {};

    for (String lessonId in lessons.keys) {
      // Extract unit ID from lesson ID (e.g., "A.1.2" -> "A.1")
      final List<String> parts = lessonId.split('.');
      if (parts.length >= 2) {
        final String unitId = '${parts[0]}.${parts[1]}';
        unitIds.add(unitId);
      }
    }

    return unitIds;
  }

  // Fetch units from the nested structure
  Future<Map<String, Unit>> _fetchUnits(Set<String> unitIds) async {
    try {
      Map<String, Unit> units = {};

      for (String id in unitIds) {
        if (id.isEmpty) {
          print('Skipping empty unit ID');
          continue;
        }

        // Fetch from nested structure first
        try {
          final String path = 'Levels/Advanced/Units/$id';
          final DocumentSnapshot doc = await _firestore.doc(path).get();

          if (doc.exists) {
            final unitData = doc.data() as Map<String, dynamic>;

            // Fetch lesson IDs from the Lessons subcollection
            final QuerySnapshot lessonsSnapshot = await _firestore.collection('$path/Lessons').get();
            final List<String> lessonIds = lessonsSnapshot.docs.map((doc) => doc.id).toList();

            // Create the unit with the lesson IDs
            units[id] = Unit(
              unitId: id,
              title: unitData['title'] ?? '',
              description: unitData['description'] ?? '',
              lessonIds: lessonIds,
              unitStatus: statusFromFirestore(unitData['unitStatus'] ?? 'inactive'),
              totalLessons: unitData['totalLessons'] ?? 0,
              createdAt: unitData['createdAt']?.toDate(),
              updatedAt: unitData['updatedAt']?.toDate(),
            );
            continue; // Skip fallback if successful
          }
        } catch (e) {
          print('Error fetching unit $id from nested structure: $e');
        }

        // Fallback to top-level collection
        try {
          final DocumentSnapshot doc = await _firestore.collection('Units').doc(id).get();

          if (doc.exists) {
            units[id] = Unit.fromFirestore(doc.data() as Map<String, dynamic>, id);
          } else {
            print('Unit with ID $id not found in any location');
          }
        } catch (e) {
          print('Error fetching unit $id from top-level collection: $e');
        }
      }

      return units;
    } catch (e) {
      print('Error fetching units: $e');
      rethrow;
    }
  }

  // Extract component IDs from lessons
  Set<String> _extractComponentIds(Map<String, Lesson> lessons) {
    final Set<String> componentIds = {};

    for (final lesson in lessons.values) {
      componentIds.addAll(lesson.components.where((id) => id.isNotEmpty));
    }

    return componentIds;
  }

  // Fetch components using the ComponentsIndex collection for direct access
  Future<Map<String, Component>> _fetchComponents(Set<String> componentIds) async {
    try {
      Map<String, Component> components = {};

      for (String id in componentIds) {
        if (id.isEmpty) {
          print('Skipping empty component ID');
          continue;
        }

        // First try the ComponentsIndex for the path
        try {
          final DocumentSnapshot indexDoc = await _firestore.collection('ComponentsIndex').doc(id).get();

          if (indexDoc.exists) {
            final indexData = indexDoc.data() as Map<String, dynamic>;
            final String path = indexData['path'] ?? '';

            if (path.isNotEmpty) {
              // Use the path to get the full component document
              final DocumentSnapshot componentDoc = await _firestore.doc(path).get();

              if (componentDoc.exists) {
                Component component = Component.fromFirestore(componentDoc.data() as Map<String, dynamic>, id);

                // Fetch associated questions from the Questions subcollection
                try {
                  final QuerySnapshot questionsSnapshot = await _firestore
                      .doc(path)
                      .collection('Questions')
                      .orderBy('index')
                      .get();

                  if (questionsSnapshot.docs.isNotEmpty) {
                    List<SubComponent> questionsList = [];

                    for (final questionDoc in questionsSnapshot.docs) {
                      final questionData = questionDoc.data() as Map<String, dynamic>;
                      try {
                        final String typeString = questionData['type'] ?? '';
                        final SubComponentType type = SubComponentTypeExtension.fromString(typeString);

                        // Create the appropriate data object based on the component type
                        dynamic parsedData;
                        try {
                          switch (type) {
                            case SubComponentType.multipleChoice:
                              parsedData = MultipleChoice.fromMap(questionData);
                              break;
                            case SubComponentType.revealCard:
                              parsedData = RevealCard.fromMap(questionData);
                              break;
                            case SubComponentType.iconReveal:
                              parsedData = IconReveal.fromMap(questionData);
                              break;
                            case SubComponentType.learningCheck:
                              parsedData = LearningCheck.fromMap(questionData);
                              break;
                            case SubComponentType.scenario:
                              parsedData = Scenario.fromMap(questionData);
                              break;
                            case SubComponentType.keyTakeaways:
                              parsedData = KeyTakeaways.fromMap(questionData);
                              break;
                            case SubComponentType.intro:
                              parsedData = IntroPage.fromMap(questionData);
                              break;
                            case SubComponentType.newlanding:
                              parsedData = newlanding.fromMap(questionData);
                              break;
                            case SubComponentType.problem:
                              parsedData = ProblemPage.fromMap(questionData);
                              break;
                            case SubComponentType.solution:
                              parsedData = SolutionPage.fromMap(questionData);
                              break;
                            case SubComponentType.impact:
                              parsedData = Impact.fromMap(questionData);
                              break;
                            case SubComponentType.scenariointro:
                              parsedData = IntroductionPage.fromMap(questionData);
                              break;
                            case SubComponentType.scenarioquestion:
                              parsedData = ScenarioQuestion.fromMap(questionData);
                              break;
                            case SubComponentType.scenariochoice:
                              parsedData = ScenarioChoice.fromMap(questionData);
                              break;
                            case SubComponentType.scenarioresults:
                              parsedData = ScenarioResult.fromMap(questionData);
                              break;
                            case SubComponentType.peerintro:
                              parsedData = PeerReflectionIntro.fromMap(questionData);
                              break;
                            case SubComponentType.peerstories:
                              parsedData = PeerStories.fromMap(questionData);
                              break;
                            case SubComponentType.peermatch:
                              parsedData = PeerMatch.fromMap(questionData);
                              break;
                            case SubComponentType.peerreflectionend:
                              parsedData = PeerReflectionEnd.fromMap(questionData);
                              break;
                            case SubComponentType.quizimagemcquestion:
                              parsedData = QuizMultipleChoice.fromMap(questionData);
                              break;
                            case SubComponentType.quiztextmcquestion:
                              parsedData = TextBasedQuestion.fromMap(questionData);
                              break;
                            default:
                              print("Unknown component type: $type, using raw data");
                              parsedData = questionData;
                              break;
                          }
                          questionsList.add(SubComponent(type: type, data: parsedData));
                        } catch (e) {
                          print("Error parsing component of type $type: $e");
                          // Add with raw data as fallback
                          questionsList.add(SubComponent(type: type, data: questionData));
                        }
                      } catch (e) {
                        print('Error parsing question in component $id: $e');
                      }
                    }

                    // Update the component with the questions
                    component = Component(
                      componentId: component.componentId,
                      title: component.title,
                      type: component.type,
                      componentStatus: component.componentStatus,
                      progress: component.progress,
                      discussionQuestions: component.discussionQuestions,
                      questionData: questionsList,
                      performanceTrends: component.performanceTrends,
                    );
                  }
                } catch (e) {
                  print('Error fetching questions for component $id: $e');
                }

                components[id] = component;
                continue; // Skip fallback methods if successful
              }
            }
          }
        } catch (e) {
          print('Error fetching component $id from ComponentsIndex: $e');
        }

        // Fallback - try to construct the path based on the component ID pattern (e.g., "A.1.2.3")
        final parts = id.split('.');
        if (parts.length >= 4) {
          final String unitId = '${parts[0]}.${parts[1]}';
          final String lessonId = '${parts[0]}.${parts[1]}.${parts[2]}';
          final String path = 'Levels/Advanced/Units/$unitId/Lessons/$lessonId/Components/$id';

          try {
            final DocumentSnapshot componentDoc = await _firestore.doc(path).get();

            if (componentDoc.exists) {
              Component component = Component.fromFirestore(componentDoc.data() as Map<String, dynamic>, id);

              // Fetch associated questions
              try {
                final QuerySnapshot questionsSnapshot = await _firestore
                    .doc(path)
                    .collection('Questions')
                    .orderBy('index')
                    .get();

                if (questionsSnapshot.docs.isNotEmpty) {
                  List<SubComponent> questionsList = [];

                  for (final questionDoc in questionsSnapshot.docs) {
                    final questionData = questionDoc.data() as Map<String, dynamic>;
                    try {
                      final String typeString = questionData['type'] ?? '';
                      final SubComponentType type = SubComponentTypeExtension.fromString(typeString);

                      // Create the appropriate data object based on the component type
                      dynamic parsedData;
                      try {
                        switch (type) {
                          case SubComponentType.multipleChoice:
                            parsedData = MultipleChoice.fromMap(questionData);
                            break;
                          case SubComponentType.revealCard:
                            parsedData = RevealCard.fromMap(questionData);
                            break;
                          case SubComponentType.iconReveal:
                            parsedData = IconReveal.fromMap(questionData);
                            break;
                          case SubComponentType.learningCheck:
                            parsedData = LearningCheck.fromMap(questionData);
                            break;
                          case SubComponentType.scenario:
                            parsedData = Scenario.fromMap(questionData);
                            break;
                          case SubComponentType.keyTakeaways:
                            parsedData = KeyTakeaways.fromMap(questionData);
                            break;
                          case SubComponentType.intro:
                            parsedData = IntroPage.fromMap(questionData);
                            break;
                          case SubComponentType.newlanding:
                            parsedData = newlanding.fromMap(questionData);
                            break;
                          case SubComponentType.problem:
                            parsedData = ProblemPage.fromMap(questionData);
                            break;
                          case SubComponentType.solution:
                            parsedData = SolutionPage.fromMap(questionData);
                            break;
                          case SubComponentType.impact:
                            parsedData = Impact.fromMap(questionData);
                            break;
                          case SubComponentType.scenariointro:
                            parsedData = IntroductionPage.fromMap(questionData);
                            break;
                          case SubComponentType.scenarioquestion:
                            parsedData = ScenarioQuestion.fromMap(questionData);
                            break;
                          case SubComponentType.scenariochoice:
                            parsedData = ScenarioChoice.fromMap(questionData);
                            break;
                          case SubComponentType.scenarioresults:
                            parsedData = ScenarioResult.fromMap(questionData);
                            break;
                          case SubComponentType.peerintro:
                            parsedData = PeerReflectionIntro.fromMap(questionData);
                            break;
                          case SubComponentType.peerstories:
                            parsedData = PeerStories.fromMap(questionData);
                            break;
                          case SubComponentType.peermatch:
                            parsedData = PeerMatch.fromMap(questionData);
                            break;
                          case SubComponentType.peerreflectionend:
                            parsedData = PeerReflectionEnd.fromMap(questionData);
                            break;
                          case SubComponentType.quizimagemcquestion:
                            parsedData = QuizMultipleChoice.fromMap(questionData);
                            break;
                          case SubComponentType.quiztextmcquestion:
                            parsedData = TextBasedQuestion.fromMap(questionData);
                            break;
                          default:
                            print("Unknown component type: $type, using raw data");
                            parsedData = questionData;
                            break;
                        }
                        questionsList.add(SubComponent(type: type, data: parsedData));
                      } catch (e) {
                        print("Error parsing component of type $type: $e");
                        // Add with raw data as fallback
                        questionsList.add(SubComponent(type: type, data: questionData));
                      }
                    } catch (e) {
                      print('Error parsing question in component $id: $e');
                    }
                  }

                  // Update the component with the questions
                  component = Component(
                    componentId: component.componentId,
                    title: component.title,
                    type: component.type,
                    componentStatus: component.componentStatus,
                    progress: component.progress,
                    discussionQuestions: component.discussionQuestions,
                    questionData: questionsList,
                    performanceTrends: component.performanceTrends,
                  );
                }
              } catch (e) {
                print('Error fetching questions for component $id: $e');
              }

              components[id] = component;
              continue; // Skip final fallback if successful
            }
          } catch (e) {
            print('Error fetching component $id using constructed path: $e');
          }

          // Final fallback - direct collection
          try {
            final DocumentSnapshot directDoc = await _firestore.collection('Components').doc(id).get();

            if (directDoc.exists) {
              components[id] = Component.fromFirestore(directDoc.data() as Map<String, dynamic>, id);
            } else {
              print('Component with ID $id not found in any location');
            }
          } catch (innerE) {
            print('Error fetching component $id from direct collection: $innerE');
          }
        } else {
          print('Component ID $id has invalid format');
        }
      }

      return components;
    } catch (e) {
      print('Error fetching components: $e');
      rethrow;
    }
  }

  // Convert a map to JSON-serializable format
  Map<String, dynamic> _mapToJson(Map<String, dynamic> map) {
    Map<String, dynamic> result = {};
    
    map.forEach((key, value) {
      if (value is Map) {
        result[key] = value;
      } else {
        // Using toJson method of the object
        result[key] = value.toJson();
      }
    });
    
    return result;
  }

  // Helper method to update the cache
  Future<void> updateTeacherCache(String teacherId) async {
    print('Updating teacher cache...');
    await buildTeacherCache(teacherId);
  }

  // Helper method to schedule regular cache updates
  void scheduleRegularUpdates(String teacherId, {Duration interval = const Duration(hours: 24)}) {
    print('Scheduling regular cache updates every ${interval.inHours} hours');

    // Set up a timer for regular updates
    Future.delayed(interval, () async {
      try {
        print('Running scheduled cache update...');
        await updateTeacherCache(teacherId);
        print('Scheduled cache update completed successfully.');
      } catch (e) {
        print('Error during scheduled cache update: $e');
      } finally {
        // Schedule the next update regardless of success/failure
        scheduleRegularUpdates(teacherId, interval: interval);
      }
    });
  }

  // Helper method to fetch and update only specific lessons
  Future<void> updateSpecificLessons(String teacherId, List<String> lessonIds) async {
    try {
      print('Updating specific lessons: $lessonIds');

      // In web, we need to get the current cache from SharedPreferences
      // Attempt to initialize the cache first
      final currentCache = TeacherDashboardCache();
      try {
        await currentCache.initialize();
      } catch (e) {
        // If we can't initialize, build a complete new cache
        print('Existing cache not found, building complete cache instead');
        await buildTeacherCache(teacherId);
        return;
      }

      // Convert the existing cache to a modifiable map
      final Map<String, dynamic> cacheMap = {
        'teacher': currentCache.teacher.toJson(),
        'classrooms': _mapToJson(currentCache.classrooms),
        'students': currentCache.students.map((s) => s.toJson()).toList(),
        'units': _mapToJson(currentCache.units),
        'lessons': _mapToJson(currentCache.lessons),
        'components': _mapToJson(currentCache.components),
        'metadata': currentCache.metadata,
      };

      // Fetch updated lessons
      final Map<String, Lesson> updatedLessons = await _fetchLessons(Set.from(lessonIds));

      // Extract any new component IDs
      final Set<String> newComponentIds = {};
      for (final lesson in updatedLessons.values) {
        for (final componentId in lesson.components) {
          if (!currentCache.components.containsKey(componentId)) {
            newComponentIds.add(componentId);
          }
        }
      }

      // Fetch new components
      final Map<String, Component> newComponents = await _fetchComponents(newComponentIds);

      // Update lessons in cache
      final Map<String, dynamic> lessonsMap = cacheMap['lessons'] as Map<String, dynamic>;
      updatedLessons.forEach((id, lesson) {
        lessonsMap[id] = lesson.toJson();
      });

      // Update components in cache
      final Map<String, dynamic> componentsMap = cacheMap['components'] as Map<String, dynamic>;
      newComponents.forEach((id, component) {
        componentsMap[id] = component.toJson();
      });

      // Update metadata
      final Map<String, String> metadataMap = Map<String, String>.from(cacheMap['metadata']);
      metadataMap['updatedAt'] = DateTime.now().toIso8601String();
      cacheMap['metadata'] = metadataMap;

      // Store updated cache in SharedPreferences
      await TeacherDashboardCache.storeCache(cacheMap);

      print('Successfully updated ${updatedLessons.length} lessons and ${newComponents.length} new components.');
    } catch (e) {
      print('Error updating specific lessons: $e');
      throw Exception('Failed to update specific lessons: $e');
    }
  }
}
class TeacherDashboardCache {

  // Singleton instance
  static final TeacherDashboardCache _instance = TeacherDashboardCache._internal();

  factory TeacherDashboardCache() {
    return _instance;
  }

  TeacherDashboardCache._internal();

  // Cache data
  late Teacher teacher;
  Map<String, Classroom> classrooms = {};
  List<Student> students = [];
  Map<String, Unit> units = {};
  Map<String, Lesson> lessons = {};
  Map<String, Component> components = {};
  Map<String, String> metadata = {};

  bool _isInitialized = false;
  
  // Cache key for web storage
  static const String _cacheKey = 'teacher_dashboard_cache';

  // Initialize by loading from the cache
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      String? jsonString;
      
      // Try to load from shared preferences first (works for web)
      if (kIsWeb) {
        final prefs = await SharedPreferences.getInstance();
        jsonString = prefs.getString(_cacheKey);
        
        // If not found in shared preferences, try to build it
        if (jsonString == null) {
          print('Cache not found in SharedPreferences. Either build a new cache or use default data.');
          throw Exception('Cache not found in web storage');
        }
      } else {
        // For mobile/desktop, try to load from assets
        try {
          jsonString = await rootBundle.loadString("assets/lib/Resources/TeacherCache.json");
        } catch (e) {
          print('Failed to load from assets: $e');
          
          // Try shared preferences as fallback for mobile
          final prefs = await SharedPreferences.getInstance();
          jsonString = prefs.getString(_cacheKey);
          
          if (jsonString == null) {
            throw Exception('Cache not found in assets or shared preferences');
          }
        }
      }
      
      // Parse the cache data
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      // Parse the teacher data
      teacher = Teacher.fromJson(jsonData['teacher']);

      // Parse classrooms
      final classroomsData = jsonData['classrooms'] as Map<String, dynamic>;
      classrooms = classroomsData
          .map((key, value) => MapEntry(key, Classroom.fromJson(value)));

      // Parse students
      final studentsData = jsonData['students'] as List;
      students = studentsData.map((data) => Student.fromJson(data)).toList();

      // Parse units
      final unitsData = jsonData['units'] as Map<String, dynamic>;
      units = unitsData.map((key, value) => MapEntry(key, Unit.fromJson(value)));

      // Parse lessons
      final lessonsData = jsonData['lessons'] as Map<String, dynamic>;
      lessons = lessonsData
          .map((key, value) => MapEntry(key, Lesson.fromJson(value)));

      // Parse components
      final componentsData = jsonData['components'] as Map<String, dynamic>;
      components = componentsData
          .map((key, value) => MapEntry(key, Component.fromJson(value)));

      // Parse metadata
      final metadataData = jsonData['metadata'] as Map<String, dynamic>;
      metadata = metadataData.map((key, value) => MapEntry(key, value.toString()));

      _isInitialized = true;
      print('Teacher dashboard cache initialized successfully');
      print('Cache version: ${metadata['version']}');
      print('Cache generated at: ${metadata['generatedAt']}');
    } catch (e) {
      print('Error initializing teacher dashboard cache: $e');
      throw Exception('Failed to load teacher dashboard cache: $e');
    }
  }

  // Store cache data in SharedPreferences (works for web and mobile)
  static Future<void> storeCache(Map<String, dynamic> cache) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(cache);
      await prefs.setString(_cacheKey, jsonString);
      print('Cache stored in SharedPreferences successfully');
    } catch (e) {
      print('Error storing cache in SharedPreferences: $e');
      throw Exception('Failed to store cache: $e');
    }
  }

  // Clear cached data
  static Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      print('Cache cleared from SharedPreferences');
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  // Rest of your methods remain the same
  
  // Get a classroom by ID
  Classroom? getClassroom(String classroomId) {
    _ensureInitialized();
    return classrooms[classroomId];
  }

  // Get all classrooms for the teacher
  List<Classroom> getTeacherClassrooms() {
    _ensureInitialized();
    return classrooms.values
        .where((classroom) => classroom.teacherId == teacher.id)
        .toList();
  }

  // Get students in a classroom
  List<Student> getStudentsInClassroom(String classroomId) {
    _ensureInitialized();
    final classroom = classrooms[classroomId];
    if (classroom == null) return [];

    return students
        .where((student) => classroom.studentIds.contains(student.studentId))
        .toList();
  }

  // Get a lesson by ID
  Lesson? getLesson(String lessonId) {
    _ensureInitialized();
    return lessons[lessonId];
  }

  // Get components for a lesson
  List<Component> getComponentsForLesson(String lessonId) {
    _ensureInitialized();
    final lesson = lessons[lessonId];
    if (lesson == null) return [];

    return lesson.components
        .map((id) => components[id])
        .where((comp) => comp != null)
        .cast<Component>()
        .toList();
  }

  // Get the current lesson for a classroom
  Lesson? getCurrentLessonForClassroom(String classroomId) {
    _ensureInitialized();
    final classroom = classrooms[classroomId];
    if (classroom == null) return null;

    return lessons[classroom.lessonId];
  }

  // Get unit by ID
  Unit? getUnit(String unitId) {
    _ensureInitialized();
    return units[unitId];
  }

  // Get unit for a lesson
  Unit? getUnitForLesson(String lessonId) {
    _ensureInitialized();
    final lessonUnit = lessonId.split('.').take(2).join('.');
    return units[lessonUnit];
  }

  // Ensure the cache is initialized
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception(
          'TeacherDashboardCache not initialized. Call initialize() first.');
    }
  }
}





// class TeacherCacheBuilder {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Main function to build the cache
//   Future<void> buildTeacherCache(String teacherId) async {
//     try {
//       // Validate teacherId first
//       if (teacherId.isEmpty) {
//         throw Exception('Teacher ID cannot be empty. Please provide a valid teacher ID.');
//       }

//       // Initialize the cache structure
//       final Map<String, dynamic> cache = {
//         'teacher': {},
//         'classrooms': {},
//         'students': [],
//         'units': {},
//         'lessons': {},
//         'components': {},
//         'metadata': {
//           'version': '1.0.0',
//           'generatedAt': DateTime.now().toIso8601String(),
//         }
//       };

//       print('Starting cache build for teacher: $teacherId');

//       // 1. Fetch teacher data
//       print('Fetching teacher data...');
//       final Teacher teacher = await _fetchTeacher(teacherId);
//       cache['teacher'] = teacher.toJson();
//       print('Teacher data fetched successfully.');

//       // 2. Fetch classrooms
//       print('Fetching ${teacher.classRooms.length} classrooms...');
//       final Map<String, Classroom> classrooms = await _fetchClassrooms(teacher.classRooms);
//       cache['classrooms'] = _mapToJson(classrooms);
//       print('Fetched ${classrooms.length} classrooms successfully.');

//       // 3. Fetch students from all classrooms
//       print('Extracting student IDs from classrooms...');
//       final Set<String> studentIds = _extractStudentIds(classrooms);
//       print('Fetching ${studentIds.length} students...');
//       final List<Student> students = await _fetchStudents(studentIds);
//       cache['students'] = students.map((student) => student.toJson()).toList();
//       print('Fetched ${students.length} students successfully.');

//       // 4. Fetch lessons from classrooms
//       print('Extracting lesson IDs from classrooms...');
//       final Set<String> lessonIds = _extractLessonIds(classrooms);
//       print('Fetching ${lessonIds.length} lessons...');
//       final Map<String, Lesson> lessons = await _fetchLessons(lessonIds);
//       cache['lessons'] = _mapToJson(lessons);
//       print('Fetched ${lessons.length} lessons successfully.');

//       // 5. Extract unit IDs from lessons and fetch units
//       print('Extracting unit IDs from lessons...');
//       final Set<String> unitIds = _extractUnitIds(lessons);
//       print('Fetching ${unitIds.length} units...');
//       final Map<String, Unit> units = await _fetchUnits(unitIds);
//       cache['units'] = _mapToJson(units);
//       print('Fetched ${units.length} units successfully.');

//       // 6. Extract component IDs from lessons and fetch components
//       print('Extracting component IDs from lessons...');
//       final Set<String> componentIds = _extractComponentIds(lessons);
//       print('Fetching ${componentIds.length} components...');
//       final Map<String, Component> components = await _fetchComponents(componentIds);
//       cache['components'] = _mapToJson(components);
//       print('Fetched ${components.length} components successfully.');

//       // Store to SharedPreferences instead of file (for web compatibility)
//       print('Storing cache in web-compatible storage...');
//       await TeacherDashboardCache.storeCache(cache);

//       print('Teacher cache successfully built!');
//       print('Cache details:');
//       print('- Teacher: ${teacher.name} (${teacher.id})');
//       print('- Classrooms: ${classrooms.length}');
//       print('- Students: ${students.length}');
//       print('- Units: ${units.length}');
//       print('- Lessons: ${lessons.length}');
//       print('- Components: ${components.length}');
//       print('- Generated at: ${cache["metadata"]["generatedAt"]}');
//     } catch (e) {
//       print('Error building teacher cache: $e');
//       throw Exception('Failed to build teacher cache: $e');
//     }
//   }

//   // The rest of your methods remain the same as before...
  
//   // (Include all the fetch methods from your original TeacherCacheBuilder)
  
//   // Helper method to update the cache
//   Future<void> updateTeacherCache(String teacherId) async {
//     print('Updating teacher cache...');
//     await buildTeacherCache(teacherId);
//   }
  
//   // Helper method to update only specific lessons
//   Future<void> updateSpecificLessons(String teacherId, List<String> lessonIds) async {
//     try {
//       print('Updating specific lessons: $lessonIds');
      
//       // In web, we need to get the current cache from SharedPreferences
//       // Attempt to initialize the cache first
//       final currentCache = TeacherDashboardCache();
//       try {
//         await currentCache.initialize();
//       } catch (e) {
//         // If we can't initialize, build a complete new cache
//         print('Existing cache not found, building complete cache instead');
//         await buildTeacherCache(teacherId);
//         return;
//       }
      
//       // Convert the existing cache to a modifiable map
//       final Map<String, dynamic> cacheMap = {
//         'teacher': currentCache.teacher.toJson(),
//         'classrooms': _mapToJson(currentCache.classrooms),
//         'students': currentCache.students.map((s) => s.toJson()).toList(),
//         'units': _mapToJson(currentCache.units),
//         'lessons': _mapToJson(currentCache.lessons),
//         'components': _mapToJson(currentCache.components),
//         'metadata': currentCache.metadata,
//       };
      
//       // Fetch updated lessons
//       final Map<String, Lesson> updatedLessons = await _fetchLessons(Set.from(lessonIds));
      
//       // Extract any new component IDs
//       final Set<String> newComponentIds = {};
//       for (final lesson in updatedLessons.values) {
//         for (final componentId in lesson.components) {
//           if (!currentCache.components.containsKey(componentId)) {
//             newComponentIds.add(componentId);
//           }
//         }
//       }
      
//       // Fetch new components
//       final Map<String, Component> newComponents = await _fetchComponents(newComponentIds);
      
//       // Update lessons in cache
//       final Map<String, dynamic> lessonsMap = cacheMap['lessons'] as Map<String, dynamic>;
//       updatedLessons.forEach((id, lesson) {
//         lessonsMap[id] = lesson.toJson();
//       });
      
//       // Update components in cache
//       final Map<String, dynamic> componentsMap = cacheMap['components'] as Map<String, dynamic>;
//       newComponents.forEach((id, component) {
//         componentsMap[id] = component.toJson();
//       });
      
//       // Update metadata
//       final Map<String, String> metadataMap = Map<String, String>.from(cacheMap['metadata']);
//       metadataMap['updatedAt'] = DateTime.now().toIso8601String();
//       cacheMap['metadata'] = metadataMap;
      
//       // Store updated cache in SharedPreferences
//       await TeacherDashboardCache.storeCache(cacheMap);
      
//       print('Successfully updated ${updatedLessons.length} lessons and ${newComponents.length} new components.');
//     } catch (e) {
//       print('Error updating specific lessons: $e');
//       throw Exception('Failed to update specific lessons: $e');
//     }
//   }
  
//   // Convert a map to JSON-serializable format
//   Map<String, dynamic> _mapToJson(Map<String, dynamic> map) {
//     Map<String, dynamic> result = {};
    
//     map.forEach((key, value) {
//       if (value is Map) {
//         result[key] = value;
//       } else {
//         // Using toJson method of the object
//         result[key] = value.toJson();
//       }
//     });
    
//     return result;
//   }

//   // Fetch teacher data
//   Future<Teacher> _fetchTeacher(String teacherId) async {
//     try {
//       // Double-check the teacherId before sending to Firestore
//       if (teacherId.isEmpty) {
//         throw Exception('Teacher ID cannot be empty');
//       }
      
//       final DocumentSnapshot doc = await _firestore.collection('Teachers').doc(teacherId).get();

//       if (!doc.exists) {
//         throw Exception('Teacher not found with ID: $teacherId');
//       }

//       // The upload script uses a slightly different naming convention
//       final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       return Teacher(
//         name: data['Name'] ?? '',
//         id: doc.id,
//         classRooms: List<String>.from(data['ClassRooms'] ?? []),
//         profilePictureLink: data['ProfilePictureLink'] ?? '',
//       );
//     } catch (e) {
//       print('Error fetching teacher: $e');
//       rethrow;
//     }
//   }
  
//   // Include the other fetch methods here...
// }
