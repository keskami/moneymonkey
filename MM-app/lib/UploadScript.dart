import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'firebase_options.dart';

// Main function to initialize Firebase and upload data
Future<void> uploadDataToFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Starting data upload with improved structure...");
  
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Upload top-level collections first (Teachers, Students, Classrooms)
    await uploadTopLevelCollections(firestore);
    
    // Upload academic structure (Levels > Units > Lessons > Components > SubComponents)
    await uploadAcademicStructure(firestore);
    
    // Create direct access references between entities
    await createCrossReferences(firestore);
    
    print("All data uploaded successfully with improved structure!");
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

// Upload academic structure 
Future<void> uploadAcademicStructure(FirebaseFirestore firestore) async {
  print("\nUploading academic structure...");
  
  try {
    // Create "Curriculum" collection as the root for all academic content
    DocumentReference curriculumRef = firestore.collection('Curriculum').doc('v1');
    await curriculumRef.set({
      'version': '1.0',
      'lastUpdated': Timestamp.now(),
      'description': 'Financial education curriculum materials',
    });
    
    print("Created Curriculum document");
    
    // Create levels collection under Curriculum
    CollectionReference levelsCollection = curriculumRef.collection('Levels');
    
    // Create Advanced level document
    DocumentReference advancedRef = levelsCollection.doc('Advanced');
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
              
              // Upload SubComponents directly under each component
              // Rather than as a separate Questions collection
              int subComponentIndex = 0;
              for (var subComponent in component.questionData) {
                try {
                  // Generate the ID for the subcomponent (e.g., "A.1.2.3.1")
                  String subComponentId = '${componentId}.${subComponentIndex + 1}';
                  DocumentReference subComponentRef = componentRef.collection('SubComponents').doc(subComponentId);
                  
                  // Base data that all SubComponents have
                  Map<String, dynamic> subComponentData = {
                    'subComponentId': subComponentId,
                    'type': subComponent.type.name,
                    'index': subComponentIndex,
                  };
                  
                  // Store the base data
                  await subComponentRef.set(subComponentData);
                  
                  // Then add the specific data based on type
                  Map<String, dynamic> typeSpecificData = convertSubComponentDataToFirestore(subComponent);
                  await subComponentRef.update(typeSpecificData);
                  
                  subComponentIndex++;
                } catch (e) {
                  print("Error uploading SubComponent ${subComponentIndex} in component ${component.componentId}: $e");
                }
              }
              
              print("Uploaded ${subComponentIndex} SubComponents for component ${component.title}");
              
              componentsUploaded++;
            }
          }
          
          print("Uploaded $componentsUploaded components for lesson ${lesson.lessonId}");
        }
      }
    }
    
    print("Academic structure uploaded successfully!");
  } catch (e) {
    print("Error uploading academic structure: $e");
    rethrow;
  }
}

// Create cross-references between entities for easier access
Future<void> createCrossReferences(FirebaseFirestore firestore) async {
  print("\nCreating cross-references for efficient access...");
  
  try {
    // Create mapping between Classrooms and current Lessons
    for (var entry in sampleClassrooms.entries) {
      String classroomId = entry.key;
      Classroom classroom = entry.value;
      
      if (classroom.lessonId.isNotEmpty) {
        // Create a "CurrentLessons" collection that maps classrooms to their current lessons
        DocumentReference classLessonRef = firestore.collection('CurrentLessons').doc(classroomId);
        
        // Find the lesson details
        Lesson? lesson = advancedLessons[classroom.lessonId];
        if (lesson != null) {
          String unitId = classroom.lessonId.split('.').take(2).join('.');
          
          await classLessonRef.set({
            'classroomId': classroomId,
            'lessonId': classroom.lessonId,
            'lessonTitle': lesson.title,
            'unitId': unitId,
            'path': 'Curriculum/v1/Levels/Advanced/Units/$unitId/Lessons/${classroom.lessonId}',
            'lastAccessed': Timestamp.now(),
          });
        }
      }
    }
    
    print("Created classroom to lesson mappings");
    
    // Create a ContentIndex for quick content search and retrieval
    // This replaces the separate LessonsIndex and ComponentsIndex collections
    
    // Index Lessons
    WriteBatch lessonBatch = firestore.batch();
    int itemCount = 0;
    
    for (var entry in advancedLessons.entries) {
      Lesson lesson = entry.value;
      String unitId = lesson.lessonId.split('.').take(2).join('.');
      
      DocumentReference indexRef = firestore.collection('ContentIndex').doc(lesson.lessonId);
      lessonBatch.set(indexRef, {
        'id': lesson.lessonId,
        'title': lesson.title,
        'type': 'lesson',
        'unitId': unitId,
        'status': statusToFirestore(lesson.lessonStatus),
        'path': 'Curriculum/v1/Levels/Advanced/Units/$unitId/Lessons/${lesson.lessonId}',
        'tags': ['lesson', unitId, 'level:Advanced'],
        'componentCount': lesson.components.length,
      });
      
      itemCount++;
      if (itemCount % 500 == 0) {
        // Commit in batches of 500 to avoid hitting limits
        await lessonBatch.commit();
        lessonBatch = firestore.batch();
      }
    }
    
    // Index Components
    for (var entry in advancedComponents.entries) {
      Component component = entry.value;
      String lessonId = component.componentId.split('.').take(3).join('.');
      String unitId = component.componentId.split('.').take(2).join('.');
      
      DocumentReference indexRef = firestore.collection('ContentIndex').doc(component.componentId);
      lessonBatch.set(indexRef, {
        'id': component.componentId,
        'title': component.title,
        'type': 'component',
        'lessonId': lessonId,
        'unitId': unitId,
        'componentType': component.type.name,
        'status': statusToFirestore(component.componentStatus),
        'path': 'Curriculum/v1/Levels/Advanced/Units/$unitId/Lessons/$lessonId/Components/${component.componentId}',
        'tags': ['component', component.type.name, lessonId, unitId],
        'subComponentCount': component.questionData.length,
      });
      
      itemCount++;
      if (itemCount % 500 == 0) {
        // Commit in batches of 500 to avoid hitting limits
        await lessonBatch.commit();
        lessonBatch = firestore.batch();
      }
    }
    
    // Commit any remaining items
    if (itemCount % 500 != 0) {
      await lessonBatch.commit();
    }
    
    print("Created ContentIndex with $itemCount total items");
    
  } catch (e) {
    print("Error creating cross-references: $e");
    rethrow;
  }
}

// Convert SubComponent data to Firestore format based on type
Map<String, dynamic> convertSubComponentDataToFirestore(SubComponent subComponent) {
  try {
    switch (subComponent.type) {
      case SubComponentType.multipleChoice:
        final data = subComponent.data as MultipleChoice;
        return {
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
        
      case SubComponentType.revealCard:
        final data = subComponent.data as RevealCard;
        return {
          'title': data.title,
          'definition': data.definition,
          'tapInstruction': data.tapInstruction,
          'whyMatter': data.whyMatter,
        };
        
      case SubComponentType.iconReveal:
        final data = subComponent.data as IconReveal;
        return {
          'title': data.title,
          'iconLinks': data.iconLinks,
          'contents': data.contents,
        };
        
      case SubComponentType.scenario:
        final data = subComponent.data as Scenario;
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
        
        return {
          'title': data.title,
          'scenarioExplanation': data.scenarioExplanation,
          'questions': questionsList,
        };
        
      case SubComponentType.learningCheck:
        final data = subComponent.data as LearningCheck;
        return {
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
        
      case SubComponentType.keyTakeaways:
        final data = subComponent.data as KeyTakeaways;
        List<Map<String, dynamic>> takeawaysList = [];
        
        for (var takeaway in data.takeaways) {
          takeawaysList.add({
            'title': takeaway.title,
            'description': takeaway.description,
            'imageUrl': takeaway.imageUrl,
          });
        }
        
        return {
          'title': data.title,
          'hint': data.hint,
          'takeaways': takeawaysList,
        };
        
      case SubComponentType.intro:
        final data = subComponent.data as IntroPage;
        return {
          'title': data.title,
          'mintyText': data.mintyText,
          'imageUrl': data.imageUrl,
        };
        
      case SubComponentType.problem:
        final data = subComponent.data as ProblemPage;
        return {
          'title': data.title,
          'subtitle': data.subtitle,
          'scenarioText': data.scenarioText,
          'instructions': data.instructions,
          'problem': data.problem,
        };
        
      case SubComponentType.solution:
        final data = subComponent.data as SolutionPage;
        return {
          'title': data.title,
          'subtitle': data.subtitle,
          'Card1': data.Card1,
          'Card2': data.Card2,
          'Card3': data.Card3,
        };
        
      case SubComponentType.impact:
        final data = subComponent.data as Impact;
        return {
          'title': data.title,
          'subtitle': data.subtitle,
          'beforeContent': data.beforeContent,
          'afterContent': data.afterContent,
        };
        
      case SubComponentType.scenariointro:
        final data = subComponent.data as IntroductionPage;
        List<Map<String, dynamic>> optionsList = [];
        
        for (var option in data.options) {
          optionsList.add({
            'title': option.title,
            'iconUrl': option.iconUrl,
            'score': option.score,
            'type': option.type,
          });
        }
        
        return {
          'scenario': data.scenario,
          'mintyImage': data.mintyImage,
          'options': optionsList,
        };
        
      case SubComponentType.scenarioquestion:
        final data = subComponent.data as ScenarioQuestion;
        List<Map<String, dynamic>> optionsList = [];
        
        for (var option in data.options) {
          optionsList.add({
            'title': option.title,
            'iconUrl': option.iconUrl,
            'score': option.score,
            'type': option.type,
          });
        }
        
        return {
          'questionText': data.questionText,
          'options': optionsList,
          'feedback': data.feedback,
        };
        
      case SubComponentType.scenariochoice:
        final data = subComponent.data as ScenarioChoice;
        return {
          'category': data.category,
          'value': data.value,
          'scoreImpact': data.scoreImpact,
        };
        
      case SubComponentType.scenarioresults:
        final data = subComponent.data as ScenarioResult;
        List<Map<String, dynamic>> selectedChoicesList = [];
        
        for (var choice in data.selectedChoices) {
          selectedChoicesList.add({
            'category': choice.category,
            'value': choice.value,
            'scoreImpact': choice.scoreImpact,
          });
        }
        
        return {
          'selectedChoices': selectedChoicesList,
          'finalScore': data.finalScore,
          'categories': data.categories,
          'feedback': data.feedback,
        };
        
      case SubComponentType.peerintro:
        final data = subComponent.data as PeerReflectionIntro;
        List<Map<String, dynamic>> charactersList = [];
        
        for (var character in data.characters) {
          charactersList.add({
            'name': character.name,
            'role': character.role,
            'story': character.story,
            'imageUrl': character.imageUrl,
          });
        }
        
        return {
          'title': data.title,
          'subTitle': data.subTitle,
          'characters': charactersList,
        };
        
      case SubComponentType.peerstories:
        final data = subComponent.data as PeerStories;
        List<Map<String, dynamic>> charactersList = [];
        
        for (var character in data.characters) {
          charactersList.add({
            'name': character.name,
            'role': character.role,
            'story': character.story,
            'imageUrl': character.imageUrl,
          });
        }
        
        return {
          'title': data.title,
          'characters': charactersList,
        };
        
      case SubComponentType.peermatch:
        final data = subComponent.data as PeerMatch;
        List<Map<String, dynamic>> categoriesList = [];
        
        for (var category in data.categories) {
          categoriesList.add({
            'title': category.title,
            'correctActions': category.correctActions,
          });
        }
        
        return {
          'title': data.title,
          'categories': categoriesList,
          'actions': data.actions,
          'feedbackMessages': data.feedbackMessages,
        };
        
      case SubComponentType.peerreflectionend:
        final data = subComponent.data as PeerReflectionEnd;
        List<Map<String, dynamic>> optionsList = [];
        
        for (var option in data.options) {
          optionsList.add({
            'name': option.name,
            'description': option.description,
            'imageUrl': option.imageUrl,
          });
        }
        
        return {
          'question': data.question,
          'options': optionsList,
          'feedbackMessages': data.feedbackMessages,
          'buttonText': data.buttonText,
        };
        
      case SubComponentType.quizimagemcquestion:
        final data = subComponent.data as QuizMultipleChoice;
        List<Map<String, dynamic>> optionsList = [];
        
        for (var option in data.options) {
          optionsList.add({
            'text': option.text,
            'imageUrl': option.imageUrl,
          });
        }
        
        return {
          'question': data.question,
          'options': optionsList,
          'correctAnswers': data.correctAnswers,
          'feedbackMessages': data.feedbackMessages,
          'isMultiSelect': data.isMultiSelect,
          'buttonText': data.buttonText,
          'imageUrl': data.imageUrl,
        };
        
      case SubComponentType.quiztextmcquestion:
        final data = subComponent.data as TextBasedQuestion;
        return {
          'question': data.question,
          'options': data.options,
          'correctAnswers': data.correctAnswers,
          'feedbackMessages': data.feedbackMessages,
          'isMultiSelect': data.isMultiSelect,
          'buttonText': data.buttonText,
        };
        
      default:
        print("Unknown SubComponent type: ${subComponent.type.name}");
        return {'error': 'Unknown SubComponent type'};
    }
  } catch (e) {
    print("Error converting SubComponent of type ${subComponent.type.name}: $e");
    return {
      'error': 'Failed to convert data: $e',
      'rawData': subComponent.data.toString(),
    };
  }
}