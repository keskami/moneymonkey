
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'firebase_options.dart';

// Main function to initialize Firebase and upload data
Future<void> UploadScript() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Starting data upload with hybrid structure...");
  
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Upload top-level collections first
    await uploadTopLevelCollections(firestore);
    
    // Upload nested academic structure
    await uploadNestedAcademicStructure(firestore);
    
    // Create indexes for direct access
    await createDirectAccessIndexes(firestore);
    
    print("All data uploaded successfully with hybrid structure!");
  } catch (e) {
    print("Error during data upload: $e");
  }
}

// Upload top-level collections (Teachers, Students, Classrooms)
Future<void> uploadTopLevelCollections(FirebaseFirestore firestore) async {
  print("Uploading top-level collections...");
  
  // Upload Teachers
  await uploadTeacher(firestore, sampleTeacher);
  
  // Upload Classrooms
  await uploadClassrooms(firestore, sampleClassrooms);
  
  // Upload Students
  await uploadStudents(firestore, sampleStudents);
  
  print("Top-level collections uploaded successfully");
}

// Upload Teacher
Future<void> uploadTeacher(FirebaseFirestore firestore, Teacher teacher) async {
  try {
    await firestore.collection('Teachers').doc(teacher.id).set({
      'Name': teacher.name,
      'ClassRooms': teacher.classRooms,
      'ProfilePictureLink': teacher.profilePictureLink,
    });
    print("Teacher ${teacher.name} uploaded successfully!");
  } catch (e) {
    print("Error uploading teacher: $e");
    rethrow;
  }
}

// Upload Classrooms
Future<void> uploadClassrooms(FirebaseFirestore firestore, Map<String, Classroom> classrooms) async {
  try {
    // Use batched writes for better performance
    WriteBatch batch = firestore.batch();
    
    classrooms.forEach((id, classroom) {
      DocumentReference docRef = firestore.collection('Classrooms').doc(classroom.classId);
      batch.set(docRef, classroom.toFirestore());
    });
    
    await batch.commit();
    print("Uploaded ${classrooms.length} classrooms successfully!");
  } catch (e) {
    print("Error uploading classrooms: $e");
    rethrow;
  }
}

// Upload Students
Future<void> uploadStudents(FirebaseFirestore firestore, List<Student> students) async {
  try {
    // Use batched writes for better performance
    WriteBatch batch = firestore.batch();
    
    for (var student in students) {
      DocumentReference docRef = firestore.collection('Students').doc(student.studentId);
      
      // Convert student data to Firestore format
      Map<String, dynamic> studentData = {
        'Email': student.email,
        'PhoneNumber': student.phoneNumber,
        'Age': student.age,
        'KnowledgeLevel': student.knowledgeLevel,
        'LearningGoalPerDay': student.learningGoalPerDay,
        'StartingLevel': student.startingLevel,
        'ClassRooms': student.classRooms,
        'Progress': student.progress,
        'Profile': {
          'FullName': student.profile.fullName,
          'Username': student.profile.username,
          'NumberOfFollowers': student.profile.numberOfFollowers,
          'Following': student.profile.following,
          'TopAchievements': student.profile.topAchievements,
          'Streak': student.profile.streak,
          'TotalProfit': student.profile.totalProfit,
          'PortfolioScore': student.profile.portfolioScore,
          'AverageMonthlyGrowth': student.profile.averageMonthlyGrowth,
        },
        'Settings': {
          'Preferences': {
            'SoundEffects': student.settings.preferences.soundEffects,
            'Audio': student.settings.preferences.audio,
            'DarkMode': student.settings.preferences.darkMode,
          },
          'Notifications': {
            'Reminders': {
              'PracticeEmail': student.settings.notifications.reminders.practiceEmail,
              'PracticePhone': student.settings.notifications.reminders.practicePhone,
              'WeeklyProgress': student.settings.notifications.reminders.weeklyProgress,
              'ReminderTime': student.settings.notifications.reminders.reminderTime,
            },
            'Friends': {
              'NewFollowerEmail': student.settings.notifications.friends.newFollowerEmail,
              'NewFollowerPhone': student.settings.notifications.friends.newFollowerPhone,
              'FriendActivityEmail': student.settings.notifications.friends.friendActivityEmail,
              'FriendActivityPhone': student.settings.notifications.friends.friendActivityPhone,
            },
            'Announcements': {
              'MarketingNotificationsEmail': student.settings.notifications.announcements.marketingNotificationsEmail,
              'MarketingNotificationsPhone': student.settings.notifications.announcements.marketingNotificationsPhone,
              'EducationalTipsEmail': student.settings.notifications.announcements.educationalTipsEmail,
              'EducationalTipsPhone': student.settings.notifications.announcements.educationalTipsPhone,
            },
          },
          'PrivacySettings': {
            'PublicProfile': student.settings.privacySettings.publicProfile,
          },
        },
      };
      
      batch.set(docRef, studentData);
    }
    
    await batch.commit();
    print("Uploaded ${students.length} students successfully!");
  } catch (e) {
    print("Error uploading students: $e");
    rethrow;
  }
}

// Upload nested academic structure (Levels > Units > Lessons > Components)
Future<void> uploadNestedAcademicStructure(FirebaseFirestore firestore) async {
  print("\nUploading nested academic structure...");
  
  try {
    // Create levels collection with Advanced document
    DocumentReference advancedRef = firestore.collection('Levels').doc('Advanced');
    await advancedRef.set({
      'name': 'Advanced',
      'description': 'Advanced level financial education curriculum',
      'createdAt': Timestamp.now(),
    });
    
    print("Created Advanced level document");
    
    // Upload units as subcollections of the Advanced level
    for (var entry in advancedUnits.entries) {
      Unit unit = entry.value;
      
      // Create unit document in the Units subcollection
      DocumentReference unitRef = advancedRef.collection('Units').doc(unit.unitId);
      await unitRef.set({
        'unitId': unit.unitId,
        'title': unit.title,
        'description': unit.description,
        'totalLessons': unit.totalLessons,
        'unitStatus': statusToFirestore(unit.unitStatus),
        'createdAt': unit.createdAt != null ? Timestamp.fromDate(unit.createdAt!) : Timestamp.now(),
        'updatedAt': unit.updatedAt != null ? Timestamp.fromDate(unit.updatedAt!) : Timestamp.now(),
      });
      
      print("Created Unit ${unit.title} (${unit.unitId})");
      
      // Upload lessons as subcollections of each unit
      for (String lessonId in unit.lessonIds) {
        Lesson? lesson = advancedLessons[lessonId];
        
        if (lesson != null) {
          // Create lesson document in the Lessons subcollection
          DocumentReference lessonRef = unitRef.collection('Lessons').doc(lessonId);
          await lessonRef.set({
            'lessonId': lesson.lessonId,
            'title': lesson.title,
            'description': lesson.description,
            'lessonStatus': statusToFirestore(lesson.lessonStatus),
            'progress': lesson.progress,
            'totalComponents': lesson.totalComponents,
            'interactiveActivityLinks': lesson.interactiveActivityLinks,
            'teachersGuideLink': lesson.teachersGuideLink,
            'studentWorkshopTemplateLinks': lesson.studentWorkshopTemplateLinks,
          });
          
          print("Created Lesson ${lesson.title} (${lesson.lessonId})");
          
          // Upload components as subcollections of each lesson
          int componentsUploaded = 0;
          for (String componentId in lesson.components) {
            Component? component = advancedComponents[componentId];
            
            if (component != null) {
              // Create component document in the Components subcollection
              DocumentReference componentRef = lessonRef.collection('Components').doc(componentId);
              
              // Convert performance trends
              Map<String, dynamic> performanceTrendsData = {
                'ClassAverage': component.performanceTrends.classAverage,
                'ParticipationRate': component.performanceTrends.participationRate,
                'LessonCompletion': component.performanceTrends.lessonCompletion,
                'LastUpdated': Timestamp.now(),
              };
              
              // Upload component data
              await componentRef.set({
                'componentId': component.componentId,
                'title': component.title,
                'type': component.type.name,
                'componentStatus': statusToFirestore(component.componentStatus),
                'progress': component.progress,
                'discussionQuestions': component.discussionQuestions,
                'PerformanceTrends': performanceTrendsData,
              });
              
              // Upload questions as a separate subcollection instead of embedding in document
              CollectionReference questionsCollection = componentRef.collection('Questions');
              
              int questionIndex = 0;
              for (var question in component.questionData) {
                try {
                  // Create a document for each question in the Questions subcollection
                  DocumentReference questionRef = questionsCollection.doc('q${questionIndex++}');
                  
                  Map<String, dynamic> questionData = {
                    'type': question.type.toString().split('.').last,
                    'index': questionIndex - 1
                  };
                  
                  // Store the type and question index
                  await questionRef.set(questionData);
                  
                  // Then add the specific question data based on type
                  switch (question.type) {
                    case QuestionType.multipleChoice:
                      final data = question.data as MultipleChoice;
                      await questionRef.update({
                        'questionHeading': data.questionHeading,
                        'question': data.question,
                        'questionExplanation': data.questionExplanation,
                        'options': data.options,
                        'correctAnswers': data.correctAnswers,
                        'prompts': {
                          'correct': data.prompts.correct,
                          'incorrect': data.prompts.incorrect,
                        },
                      });
                      break;
                      
                    case QuestionType.revealCard:
                      final data = question.data as RevealCard;
                      await questionRef.update({
                        'title': data.title,
                        'definition': data.definition,
                        'tapInstruction': data.tapInstruction,
                        'whyMatter': data.whyMatter,
                      });
                      break;
                      
                    case QuestionType.iconReveal:
                      final data = question.data as IconReveal;
                      await questionRef.update({
                        'title': data.title,
                        'iconLinks': data.iconLinks,
                        'contents': data.contents,
                      });
                      break;
                      
                    case QuestionType.scenario:
                      final data = question.data as Scenario;
                      List<Map<String, dynamic>> questionsList = [];
                      
                      for (var q in data.questions) {
                        questionsList.add({
                          'questionHeading': q.questionHeading,
                          'question': q.question,
                          'questionExplanation': q.questionExplanation,
                          'options': q.options,
                          'correctAnswers': q.correctAnswers,
                          'prompts': {
                            'correct': q.prompts.correct,
                            'incorrect': q.prompts.incorrect,
                          },
                        });
                      }
                      
                      await questionRef.update({
                        'title': data.title,
                        'scenarioExplanation': data.scenarioExplanation,
                        'questions': questionsList,
                      });
                      break;
                      
                    case QuestionType.learningCheck:
                      final data = question.data as LearningCheck;
                      await questionRef.update({
                        'title': data.title,
                        'question1': data.question1,
                        'question2': data.question2,
                        'options1': data.options1,
                        'options2': data.options2,
                        'correctAns1': data.correctAns1,
                        'correctAns2': data.correctAns2,
                        'feedbackCorrect': data.feedbackCorrect,
                        'feedbackOneIncorrect': data.feedbackOneIncorrect,
                        'feedbackBothIncorrect': data.feedbackBothIncorrect,
                      });
                      break;
                      
                    case QuestionType.keyTakeaways:
                      final data = question.data as KeyTakeaways;
                      List<Map<String, dynamic>> takeawaysList = [];
                      
                      for (var takeaway in data.takeaways) {
                        takeawaysList.add({
                          'title': takeaway.title,
                          'description': takeaway.description,
                          'imageUrl': takeaway.imageUrl,
                        });
                      }
                      
                      await questionRef.update({
                        'title': data.title,
                        'hint': data.hint,
                        'takeaways': takeawaysList,
                      });
                      break;
                      
                    // Handle other question types with separate case statements...
                    case QuestionType.intro:
                      final data = question.data as IntroPage;
                      await questionRef.update({
                        'title': data.title,
                        'mintyText': data.mintyText,
                        'imageUrl': data.imageUrl,
                      });
                      break;
                      
                    case QuestionType.problem:
                      final data = question.data as ProblemPage;
                      await questionRef.update({
                        'title': data.title,
                        'subtitle': data.subtitle,
                        'scenarioText': data.scenarioText,
                        'instructions': data.instructions,
                        'problem': data.problem,
                      });
                      break;
                      
                    case QuestionType.solution:
                      final data = question.data as SolutionPage;
                      await questionRef.update({
                        'title': data.title,
                        'subtitle': data.subtitle,
                        'Card1': data.Card1,
                        'Card2': data.Card2,
                        'Card3': data.Card3,
                      });
                      break;
                      
                    case QuestionType.impact:
                      final data = question.data as Impact;
                      await questionRef.update({
                        'title': data.title,
                        'subtitle': data.subtitle,
                        'beforeContent': data.beforeContent,
                        'afterContent': data.afterContent,
                      });
                      break;
                      
                    case QuestionType.scenariointro:
                      final data = question.data as IntroductionPage;
                      List<Map<String, dynamic>> optionsList = [];
                      
                      for (var option in data.options) {
                        optionsList.add({
                          'title': option.title,
                          'iconUrl': option.iconUrl,
                          'score': option.score,
                          'type': option.type,
                        });
                      }
                      
                      await questionRef.update({
                        'scenario': data.scenario,
                        'mintyImage': data.mintyImage,
                        'options': optionsList,
                      });
                      break;
                      
                    case QuestionType.scenarioquestion:
                      final data = question.data as List<ScenarioQuestion>;
                      List<Map<String, dynamic>> questionsList = [];
                      
                      for (var sq in data) {
                        List<Map<String, dynamic>> optionsList = [];
                        
                        for (var option in sq.options) {
                          optionsList.add({
                            'title': option.title,
                            'iconUrl': option.iconUrl,
                            'score': option.score,
                            'type': option.type,
                          });
                        }
                        
                        questionsList.add({
                          'questionText': sq.questionText,
                          'options': optionsList,
                          'feedback': sq.feedback,
                        });
                      }
                      
                      await questionRef.update({
                        'questions': questionsList,
                      });
                      break;
                      
                    // Add other question types here...
                    
                    default:
                      print("Skipping unsupported question type: ${question.type}");
                      break;
                  }
                  
                } catch (e) {
                  print("Error uploading question ${questionIndex-1} in component ${component.componentId}: $e");
                }
              }
              
              print("Uploaded ${questionIndex} questions for component ${component.title}");
              
              componentsUploaded++;
            }
          }
          
          print("Uploaded $componentsUploaded components for lesson ${lesson.lessonId}");
        }
      }
    }
    
    print("Nested academic structure uploaded successfully!");
  } catch (e) {
    print("Error uploading nested academic structure: $e");
    rethrow;
  }
}

// Create indexes for direct access to lessons and components
Future<void> createDirectAccessIndexes(FirebaseFirestore firestore) async {
  print("\nCreating direct access indexes...");
  
  try {
    // Create lessons index for direct access
    WriteBatch lessonsBatch = firestore.batch();
    int lessonsCount = 0;
    
    for (var entry in advancedLessons.entries) {
      Lesson lesson = entry.value;
      String unitId = lesson.lessonId.split('.').take(2).join('.');
      
      DocumentReference lessonIndexRef = firestore.collection('LessonsIndex').doc(lesson.lessonId);
      lessonsBatch.set(lessonIndexRef, {
        'lessonId': lesson.lessonId,
        'title': lesson.title,
        'description': lesson.description,
        'unitId': unitId,
        'status': statusToFirestore(lesson.lessonStatus),
        'path': 'Levels/Advanced/Units/$unitId/Lessons/${lesson.lessonId}',
        'totalComponents': lesson.totalComponents,
      });
      
      lessonsCount++;
      
      // Commit batch every 500 documents (Firestore batch limit)
      if (lessonsCount % 500 == 0) {
        await lessonsBatch.commit();
        lessonsBatch = firestore.batch();
      }
    }
    
    // Commit any remaining lessons
    if (lessonsCount % 500 != 0) {
      await lessonsBatch.commit();
    }
    
    print("Created index for $lessonsCount lessons");
    
    // Create components index for direct access
    WriteBatch componentsBatch = firestore.batch();
    int componentsCount = 0;
    
    for (var entry in advancedComponents.entries) {
      Component component = entry.value;
      String lessonId = component.componentId.split('.').take(3).join('.');
      String unitId = component.componentId.split('.').take(2).join('.');
      
      DocumentReference componentIndexRef = firestore.collection('ComponentsIndex').doc(component.componentId);
      componentsBatch.set(componentIndexRef, {
        'componentId': component.componentId,
        'title': component.title,
        'type': component.type.name,
        'status': statusToFirestore(component.componentStatus),
        'lessonId': lessonId,
        'unitId': unitId,
        'path': 'Levels/Advanced/Units/$unitId/Lessons/$lessonId/Components/${component.componentId}',
      });
      
      componentsCount++;
      
      // Commit batch every 500 documents
      if (componentsCount % 500 == 0) {
        await componentsBatch.commit();
        componentsBatch = firestore.batch();
      }
    }
    
    // Commit any remaining components
    if (componentsCount % 500 != 0) {
      await componentsBatch.commit();
    }
    
    print("Created index for $componentsCount components");
    
  } catch (e) {
    print("Error creating direct access indexes: $e");
    rethrow;
  }
}

// Convert Question to Firestore data
Map<String, dynamic> convertQuestionToFirestore(Question question) {
  Map<String, dynamic> result = {
    'type': question.type.toString().split('.').last,
  };
  
  try {
    // Handle different question types
    switch (question.type) {
      case QuestionType.multipleChoice:
        final data = question.data as MultipleChoice;
        result['data'] = {
          'questionHeading': data.questionHeading,
          'question': data.question,
          'questionExplanation': data.questionExplanation,
          'options': data.options,
          'correctAnswers': data.correctAnswers,
          'prompts': {
            'correct': data.prompts.correct,
            'incorrect': data.prompts.incorrect,
          },
        };
        break;
        
      case QuestionType.revealCard:
        final data = question.data as RevealCard;
        result['data'] = {
          'title': data.title,
          'definition': data.definition,
          'tapInstruction': data.tapInstruction,
          'whyMatter': data.whyMatter,
        };
        break;
        
      case QuestionType.iconReveal:
        final data = question.data as IconReveal;
        result['data'] = {
          'title': data.title,
          'iconLinks': data.iconLinks,
          'contents': data.contents,
        };
        break;
        
      case QuestionType.scenario:
        final data = question.data as Scenario;
        List<Map<String, dynamic>> questionsList = [];
        
        for (var q in data.questions) {
          questionsList.add({
            'questionHeading': q.questionHeading,
            'question': q.question,
            'questionExplanation': q.questionExplanation,
            'options': q.options,
            'correctAnswers': q.correctAnswers,
            'prompts': {
              'correct': q.prompts.correct,
              'incorrect': q.prompts.incorrect,
            },
          });
        }
        
        result['data'] = {
          'title': data.title,
          'scenarioExplanation': data.scenarioExplanation,
          'questions': questionsList,
        };
        break;
        
      case QuestionType.learningCheck:
        final data = question.data as LearningCheck;
        result['data'] = {
          'title': data.title,
          'question1': data.question1,
          'question2': data.question2,
          'options1': data.options1,
          'options2': data.options2,
          'correctAns1': data.correctAns1,
          'correctAns2': data.correctAns2,
          'feedbackCorrect': data.feedbackCorrect,
          'feedbackOneIncorrect': data.feedbackOneIncorrect,
          'feedbackBothIncorrect': data.feedbackBothIncorrect,
        };
        break;
        
      // Add other question types handling here...
        
      default:
        // For other types, try to convert generically
        result['data'] = convertDynamicToFirestore(question.data);
        break;
    }
  } catch (e) {
    print("Error converting question type ${question.type}: $e");
    // If conversion fails, store as generic object
    result['data'] = {
      'error': 'Failed to convert data: $e',
      'rawData': question.data.toString(),
    };
  }
  
  return result;
}

// Generic converter for dynamic types
dynamic convertDynamicToFirestore(dynamic data) {
  if (data == null) return null;
  
  if (data is Map) {
    Map<String, dynamic> result = {};
    data.forEach((key, value) {
      if (value != null) {
        if (key is String) {
          result[key] = convertDynamicToFirestore(value);
        } else {
          result[key.toString()] = convertDynamicToFirestore(value);
        }
      }
    });
    return result;
  } 
  else if (data is List) {
    return data.map((item) => convertDynamicToFirestore(item)).toList();
  } 
  else if (data is DateTime) {
    return Timestamp.fromDate(data);
  } 
  else {
    return data;
  }
}

// Helper function for advanced queries
// Example: "Find all active components across all lessons in a specific unit"
Future<List<Map<String, dynamic>>> findComponentsByUnitAndStatus(FirebaseFirestore firestore, String unitId, String status) async {
  // Using the ComponentsIndex for efficient querying
  QuerySnapshot snapshot = await firestore.collection('ComponentsIndex')
    .where('unitId', isEqualTo: unitId)
    .where('status', isEqualTo: status)
    .get();
    
  List<Map<String, dynamic>> results = [];
  
  for (var doc in snapshot.docs) {
    // Get the component path from the index
    String path = doc.get('path');
    
    // Fetch the actual component using the path
    DocumentSnapshot componentDoc = await firestore.doc(path).get();
    
    if (componentDoc.exists) {
      // Add component data to results
      Map<String, dynamic> data = componentDoc.data() as Map<String, dynamic>;
      data['id'] = componentDoc.id;
      results.add(data);
    }
  }
  
  return results;
}
