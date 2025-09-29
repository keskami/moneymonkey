import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';

/// A service for direct Firebase interactions without local caching
/// This replaces the existing caching mechanisms to ensure real-time data access
class DirectFirebaseService {
  // Singleton pattern implementation
  static final DirectFirebaseService _instance =
      DirectFirebaseService._internal();

  factory DirectFirebaseService() {
    return _instance;
  }

  DirectFirebaseService._internal();

  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ======================================
  // TEACHER METHODS
  // ======================================

  /// Get a teacher by ID directly from Firebase
  Future<Teacher> getTeacher(String teacherId) async {
    try {
      final doc = await _firestore.collection('Teachers').doc(teacherId).get();

      if (!doc.exists) {
        throw Exception('Teacher not found with ID: $teacherId');
      }

      return Teacher.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print('Error fetching teacher: $e');
      rethrow;
    }
  }

  // ======================================
  // CLASSROOM METHODS
  // ======================================

  /// Get all classrooms for a teacher directly from Firebase
  Future<Map<String, Classroom>> getClassroomsForTeacher(
      String teacherId) async {
    try {
      final querySnapshot = await _firestore
          .collection('Classrooms')
          .where('TeacherId', isEqualTo: teacherId)
          .get();

      Map<String, Classroom> classrooms = {};

      for (final doc in querySnapshot.docs) {
        classrooms[doc.id] = Classroom.fromFirestore(doc.data(), doc.id);
      }

      return classrooms;
    } catch (e) {
      print('Error fetching classrooms: $e');
      rethrow;
    }
  }

  /// Get a classroom by ID directly from Firebase
  Future<Classroom> getClassroom(String classroomId) async {
    try {
      final doc =
          await _firestore.collection('Classrooms').doc(classroomId).get();

      if (!doc.exists) {
        throw Exception('Classroom not found with ID: $classroomId');
      }

      return Classroom.fromFirestore(
          doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print('Error fetching classroom: $e');
      rethrow;
    }
  }

  // ======================================
  // STUDENT METHODS
  // ======================================

  /// Get all students in a classroom directly from Firebase
  Future<List<Student>> getStudentsInClassroom(String classroomId) async {
    try {
      final classroom = await getClassroom(classroomId);
      List<Student> students = [];

      for (final studentId in classroom.studentIds) {
        try {
          final student = await getStudent(studentId);
          students.add(student);
        } catch (e) {
          print('Error fetching student $studentId: $e');
          // Continue with next student if one fails
        }
      }

      return students;
    } catch (e) {
      print('Error fetching students in classroom: $e');
      rethrow;
    }
  }

  /// Get a student by ID directly from Firebase
  Future<Student> getStudent(String studentId) async {
    try {
      final doc = await _firestore.collection('Students').doc(studentId).get();

      if (!doc.exists) {
        throw Exception('Student not found with ID: $studentId');
      }

      return Student.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print('Error fetching student: $e');
      rethrow;
    }
  }

  /// Update student progress directly in Firebase
  Future<void> updateStudentProgress(String studentId, String progress) async {
    try {
      await _firestore
          .collection('Students')
          .doc(studentId)
          .update({'progress': progress});

      print('Updated progress for student $studentId to $progress');
    } catch (e) {
      print('Error updating student progress: $e');
      rethrow;
    }
  }

  // ======================================
  // UNIT METHODS
  // ======================================

  /// Get all units directly from Firebase
  Future<Map<String, Unit>> getAllUnits() async {
    try {
      final querySnapshot = await _firestore.collection('Units').get();

      Map<String, Unit> units = {};

      for (final doc in querySnapshot.docs) {
        units[doc.id] = Unit.fromFirestore(doc.data(), doc.id);
      }

      return units;
    } catch (e) {
      print('Error fetching all units: $e');
      rethrow;
    }
  }

  /// Get units for a specific difficulty level directly from Firebase
  Future<List<Unit>> getUnitsForDifficulty(String difficulty) async {
    try {
      final querySnapshot = await _firestore
          .collection('Units')
          .where('UnitId', isGreaterThanOrEqualTo: difficulty)
          .where('UnitId',
              isLessThan: difficulty +
                  'z') // This covers all strings starting with the difficulty letter
          .get();

      List<Unit> units = [];

      for (final doc in querySnapshot.docs) {
        units.add(Unit.fromFirestore(doc.data(), doc.id));
      }

      return units;
    } catch (e) {
      print('Error fetching units for difficulty $difficulty: $e');
      rethrow;
    }
  }

  /// Get a unit by ID directly from Firebase
  Future<Unit> getUnit(String unitId) async {
    try {
      // First try the nested path based on the unit ID pattern (e.g., "A.1")
      final String path = 'Units/$unitId';

      try {
        final doc = await _firestore.doc(path).get();

        if (doc.exists) {
          return Unit.fromFirestore(doc.data() as Map<String, dynamic>, unitId);
        }
      } catch (e) {
        print('Unit not found at nested path, trying top-level collection...');
      }

      // Fall back to top-level collection
      final doc = await _firestore.collection('Units').doc(unitId).get();

      if (!doc.exists) {
        throw Exception('Unit not found with ID: $unitId');
      }

      return Unit.fromFirestore(doc.data() as Map<String, dynamic>, unitId);
    } catch (e) {
      print('Error fetching unit: $e');
      rethrow;
    }
  }

  // ======================================
  // LESSON METHODS
  // ======================================

  /// Get all lessons directly from Firebase
  Future<Map<String, Lesson>> getAllLessons() async {
    try {
      final querySnapshot = await _firestore.collection('Lessons').get();

      Map<String, Lesson> lessons = {};

      for (final doc in querySnapshot.docs) {
        lessons[doc.id] = Lesson.fromFirestore(doc.data(), doc.id);
      }

      return lessons;
    } catch (e) {
      print('Error fetching all lessons: $e');
      rethrow;
    }
  }

  /// Get a lesson by ID directly from Firebase
  Future<Lesson> getLesson(String lessonId) async {
    try {
      // First try the LessonsIndex for the path
      try {
        final indexDoc =
            await _firestore.collection('LessonsIndex').doc(lessonId).get();

        if (indexDoc.exists) {
          final indexData = indexDoc.data() as Map<String, dynamic>;
          final String path = indexData['path'] ?? '';

          if (path.isNotEmpty) {
            final lessonDoc = await _firestore.doc(path).get();

            if (lessonDoc.exists) {
              return Lesson.fromFirestore(
                  lessonDoc.data() as Map<String, dynamic>, lessonId);
            }
          }
        }
      } catch (e) {
        print('Lesson not found in index, trying constructed path...');
      }

      // Try to construct the path based on the lesson ID pattern (e.g., "A.1.2")
      final parts = lessonId.split('.');
      if (parts.length >= 3) {
        final String unitId = '${parts[0]}.${parts[1]}';
        final String path = 'Levels/Advanced/Units/$unitId/Lessons/$lessonId';

        try {
          final lessonDoc = await _firestore.doc(path).get();

          if (lessonDoc.exists) {
            return Lesson.fromFirestore(
                lessonDoc.data() as Map<String, dynamic>, lessonId);
          }
        } catch (e) {
          print(
              'Lesson not found at constructed path, trying direct collection...');
        }
      }

      // Fall back to direct collection
      final doc = await _firestore.collection('Lessons').doc(lessonId).get();

      if (!doc.exists) {
        throw Exception('Lesson not found with ID: $lessonId');
      }

      return Lesson.fromFirestore(doc.data() as Map<String, dynamic>, lessonId);
    } catch (e) {
      print('Error fetching lesson: $e');
      rethrow;
    }
  }

  /// Get the next lesson ID based on the current lesson ID
  Future<String> getNextLessonId(String currentLessonId) async {
    final parts = currentLessonId.split('.');
    if (parts.length != 3) throw Exception('Invalid lesson ID format');

    // Try next lesson in same unit
    final nextLessonNumber = int.parse(parts[2]) + 1;
    final nextLessonId = '${parts[0]}.${parts[1]}.$nextLessonNumber';

    try {
      await getLesson(nextLessonId);
      return nextLessonId;
    } catch (e) {
      // Next lesson doesn't exist, try first lesson in next unit
    }

    // Try first lesson in next unit
    final nextUnitNumber = int.parse(parts[1]) + 1;
    final nextUnitLessonId = '${parts[0]}.$nextUnitNumber.1';

    try {
      await getLesson(nextUnitLessonId);
      return nextUnitLessonId;
    } catch (e) {
      throw Exception('No next lesson found');
    }
  }

  // ======================================
  // COMPONENT METHODS
  // ======================================

  /// Get all components for a lesson directly from Firebase
  Future<List<Component>> getComponentsForLesson(String lessonId) async {
    try {
      final lesson = await getLesson(lessonId);
      List<Component> components = [];

      for (final componentId in lesson.components) {
        try {
          final component = await getComponent(componentId);
          components.add(component);
        } catch (e) {
          print('Error fetching component $componentId: $e');
          // Continue with next component if one fails
        }
      }

      return components;
    } catch (e) {
      print('Error fetching components for lesson: $e');
      rethrow;
    }
  }

  /// Get a component by ID directly from Firebase
  Future<Component> getComponent(String componentId) async {
    try {
      // First try the ComponentsIndex for the path
      try {
        final indexDoc = await _firestore
            .collection('Components')
            .doc(componentId)
            .get();

        if (indexDoc.exists) {
          final indexData = indexDoc.data() as Map<String, dynamic>;
          final String path = indexData['path'] ?? '';

          if (path.isNotEmpty) {
            final componentDoc = await _firestore.doc(path).get();

            if (componentDoc.exists) {
              final component = Component.fromFirestore(
                  componentDoc.data() as Map<String, dynamic>, componentId);

              // Fetch associated questions from the Questions subcollection if exists
              try {
                final questionsSnapshot = await _firestore
                    .doc(path)
                    .collection('Questions')
                    .orderBy('index')
                    .get();

                if (questionsSnapshot.docs.isNotEmpty) {
                  // Process and attach questions to the component
                  // This would require additional implementation based on your data model
                }
              } catch (e) {
                print(
                    'Error fetching questions for component $componentId: $e');
              }

              return component;
            }
          }
        }
      } catch (e) {
        print('Component not found in index, trying constructed path...');
      }

      // Try to construct the path based on the component ID pattern (e.g., "A.1.2.3")
      final parts = componentId.split('.');
      if (parts.length >= 4) {
        final String unitId = '${parts[0]}.${parts[1]}';
        final String lessonId = '${parts[0]}.${parts[1]}.${parts[2]}';
        final String path =
            'Levels/Advanced/Units/$unitId/Lessons/$lessonId/Components/$componentId';

        try {
          final componentDoc = await _firestore.doc(path).get();

          if (componentDoc.exists) {
            return Component.fromFirestore(
                componentDoc.data() as Map<String, dynamic>, componentId);
          }
        } catch (e) {
          print(
              'Component not found at constructed path, trying direct collection...');
        }
      }

      // Fall back to direct collection
      final doc =
          await _firestore.collection('Components').doc(componentId).get();

      if (!doc.exists) {
        throw Exception('Component not found with ID: $componentId');
      }

      return Component.fromFirestore(
          doc.data() as Map<String, dynamic>, componentId);
    } catch (e) {
      print('Error fetching component: $e');
      rethrow;
    }
  }

  Future<void> updateComponentStatus(
      String componentId, Status newStatus) async {
    try {
      print(
          'Attempting to update component $componentId to status: ${statusToFirestore(newStatus)}');

      // The correct path based on your Firebase structure
      final String correctPath =
          'Curriculum/v1/Levels/Advanced/Units/${componentId.split('.')[0]}.${componentId.split('.')[1]}/Lessons/${componentId.split('.')[0]}.${componentId.split('.')[1]}.${componentId.split('.')[2]}/Components/$componentId';

      print('Using correct path: $correctPath');

      // Verify document exists at the path
      final docSnapshot = await _firestore.doc(correctPath).get();

      if (!docSnapshot.exists) {
        print('Warning: Document does not exist at path: $correctPath');
        throw Exception('Document not found at correct path');
      }

      // Update the component status with the correct field name (lowercase)
      await _firestore.doc(correctPath).update({
        'componentStatus':
            statusToFirestore(newStatus) // Note the lowercase 'c'
      });

      print(
          'Successfully updated status for component $componentId to ${statusToFirestore(newStatus)}');
    } catch (e) {
      print('Error updating component status: $e');

      // Fallback to check all possible paths
      try {
        // Try different potential paths
        final List<String> potentialPaths = [
          // Original path construction with curriculum prefix
          'Curriculum/v1/Levels/Advanced/Units/${componentId.split('.')[0]}.${componentId.split('.')[1]}/Lessons/${componentId.split('.')[0]}.${componentId.split('.')[1]}.${componentId.split('.')[2]}/Components/$componentId',

          // Direct path in Components collection
          'Components/$componentId',

          // Components subcollection under curriculum
          'Curriculum/v1/Components/$componentId'
        ];

        bool updated = false;

        for (final path in potentialPaths) {
          try {
            final doc = await _firestore.doc(path).get();

            if (doc.exists) {
              print('Found document at path: $path');

              // Try both field names (upper and lowercase C)
              try {
                await _firestore
                    .doc(path)
                    .update({'componentStatus': statusToFirestore(newStatus)});
                print('Updated with lowercase field name at: $path');
                updated = true;
                break;
              } catch (fieldError) {
                print(
                    'Lowercase field update failed, trying uppercase: $fieldError');

                try {
                  await _firestore.doc(path).update(
                      {'ComponentStatus': statusToFirestore(newStatus)});
                  print('Updated with uppercase field name at: $path');
                  updated = true;
                  break;
                } catch (upperFieldError) {
                  print('Uppercase field update failed: $upperFieldError');
                }
              }
            }
          } catch (pathError) {
            print('Error checking path $path: $pathError');
          }
        }

        if (!updated) {
          throw Exception(
              'Could not update component status at any known path');
        }
      } catch (fallbackError) {
        print('All fallback attempts failed: $fallbackError');
        rethrow;
      }
    }
  }

  /// Update multiple component statuses directly in Firebase

  /// Update multiple component statuses directly in Firebase
  Future<void> updateMultipleComponentStatuses(
      Map<String, Status> updates) async {
    try {
      print('Attempting to update ${updates.length} components');

      // Use a batch to perform multiple updates
      final batch = _firestore.batch();
      bool allDocumentsFound = true;

      // Process each component update
      for (final entry in updates.entries) {
        final componentId = entry.key;
        final newStatus = entry.value;

        // Construct the correct path based on Firebase structure
        final parts = componentId.split('.');
        if (parts.length >= 4) {
          final String unitId = '${parts[0]}.${parts[1]}';
          final String lessonId = '${parts[0]}.${parts[1]}.${parts[2]}';
          final String correctPath =
              'Curriculum/v1/Levels/Advanced/Units/$unitId/Lessons/$lessonId/Components/$componentId';

          print('Checking path for $componentId: $correctPath');

          // Verify document exists
          try {
            final docSnapshot = await _firestore.doc(correctPath).get();

            if (docSnapshot.exists) {
              // Add update to batch with correct field name (lowercase)
              batch.update(_firestore.doc(correctPath),
                  {'componentStatus': statusToFirestore(newStatus)});
              print('Added component $componentId to batch update');
            } else {
              print('Warning: Document does not exist at path: $correctPath');
              allDocumentsFound = false;
            }
          } catch (e) {
            print('Error verifying document for batch update: $e');
            allDocumentsFound = false;
          }
        } else {
          print('Invalid component ID format: $componentId');
          allDocumentsFound = false;
        }
      }

      if (!allDocumentsFound) {
        print(
            'Some documents were not found, still proceeding with batch update for found documents');
      }

      // Commit the batch
      await batch.commit();

      print('Successfully updated status for components in batch');
    } catch (e) {
      print('Error updating multiple component statuses: $e');

      // Fall back to individual updates if batch fails
      print('Falling back to individual updates...');

      for (final entry in updates.entries) {
        try {
          await updateComponentStatus(entry.key, entry.value);
          print('Updated component ${entry.key} via individual update');
        } catch (innerError) {
          print('Failed to update component ${entry.key}: $innerError');
          // Continue with next component
        }
      }
    }
  }
}
