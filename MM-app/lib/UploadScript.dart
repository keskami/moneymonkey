// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:money_monkey/Backend/Models/Academic.dart';
// import 'package:money_monkey/Backend/Models/StudentData.dart';
// import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
// import 'package:money_monkey/Backend/Models/Teacher.dart';
// import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
// import 'firebase_options.dart';

// // Main function to initialize Firebase and upload data
// Future<void> uploadDataToFirebase() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   print("Starting data upload with improved structure...");
  
//   try {
//     // Get Firestore instance
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
//     // Upload top-level collections first (Teachers, Students, Classrooms)
//     await uploadTopLevelCollections(firestore);
    
//     // Upload academic structure (Levels > Units > Lessons > Components > SubComponents)
//     await uploadAcademicStructure(firestore);
    
//     // Create direct access references between entities
//     await createCrossReferences(firestore);
    
//     print("All data uploaded successfully with improved structure!");
//   } catch (e) {
//     print("Error during data upload: $e");
//   }
// }

// // Upload top-level collections (Teachers, Students, Classrooms)
// Future<void> uploadTopLevelCollections(FirebaseFirestore firestore) async {
//   print("Uploading top-level collections...");
  
//   // Upload Teachers
//   await uploadTeacher(firestore, sampleTeacher);
  
//   // Upload Classrooms
//   await uploadClassrooms(firestore, sampleClassrooms);
  
//   // Upload Students
//   await uploadStudents(firestore, sampleStudents);
  
//   print("Top-level collections uploaded successfully");
// }

// // Upload Teacher
// Future<void> uploadTeacher(FirebaseFirestore firestore, Teacher teacher) async {
//   try {
//     await firestore.collection('Teachers').doc(teacher.id).set({
//       'Name': teacher.name,
//       'ClassRooms': teacher.classRooms,
//       'ProfilePictureLink': teacher.profilePictureLink,
//     });
//     print("Teacher ${teacher.name} uploaded successfully!");
//   } catch (e) {
//     print("Error uploading teacher: $e");
//     rethrow;
//   }
// }

// // Upload Classrooms
// Future<void> uploadClassrooms(FirebaseFirestore firestore, Map<String, Classroom> classrooms) async {
//   try {
//     // Use batched writes for better performance
//     WriteBatch batch = firestore.batch();
    
//     classrooms.forEach((id, classroom) {
//       DocumentReference docRef = firestore.collection('Classrooms').doc(classroom.classId);
//       batch.set(docRef, classroom.toFirestore());
//     });
    
//     await batch.commit();
//     print("Uploaded ${classrooms.length} classrooms successfully!");
//   } catch (e) {
//     print("Error uploading classrooms: $e");
//     rethrow;
//   }
// }

// // Upload Students
// Future<void> uploadStudents(FirebaseFirestore firestore, List<Student> students) async {
//   try {
//     // Use batched writes for better performance
//     WriteBatch batch = firestore.batch();
    
//     for (var student in students) {
//       DocumentReference docRef = firestore.collection('Students').doc(student.studentId);
      
//       // Convert student data to Firestore format
//       Map<String, dynamic> studentData = {
//         'Email': student.email,
//         'Phone Number': student.phoneNumber,
//         'Age': student.age,
//         'Knowledge Level': student.knowledgeLevel,
//         'Learning Goal Per Day': student.learningGoalPerDay,
//         'Starting Level': student.startingLevel,
//         'ClassRooms': student.classRooms,
//         'progress': student.progress,
//         'Profile': {
//           'Full Name': student.profile.fullName,
//           'Username': student.profile.username,
//           'Number of Followers': student.profile.numberOfFollowers,
//           'Following': student.profile.following,
//           'Top Achievements': student.profile.topAchievements,
//           'Streak': student.profile.streak,
//           'Total Profit': student.profile.totalProfit,
//           'Portfolio Score': student.profile.portfolioScore,
//           'Average Monthly Growth': student.profile.averageMonthlyGrowth,
//         },
//         'Settings': {
//           'Preferences': {
//             'Sound Effects': student.settings.preferences.soundEffects,
//             'Audio': student.settings.preferences.audio,
//             'Dark Mode': student.settings.preferences.darkMode,
//           },
//           'Notifications': {
//             'Reminders': {
//               'Practice Email': student.settings.notifications.reminders.practiceEmail,
//               'Practice Phone': student.settings.notifications.reminders.practicePhone,
//               'Weekly Progress': student.settings.notifications.reminders.weeklyProgress,
//               'Reminder Time': student.settings.notifications.reminders.reminderTime,
//             },
//             'Friends': {
//               'New Follower Email': student.settings.notifications.friends.newFollowerEmail,
//               'New Follower Phone': student.settings.notifications.friends.newFollowerPhone,
//               'Friend Activity Email': student.settings.notifications.friends.friendActivityEmail,
//               'Friend Activity Phone': student.settings.notifications.friends.friendActivityPhone,
//             },
//             'Announcements': {
//               'Marketing Notifications Email': student.settings.notifications.announcements.marketingNotificationsEmail,
//               'Marketing Notifications Phone': student.settings.notifications.announcements.marketingNotificationsPhone,
//               'Educational Tips Email': student.settings.notifications.announcements.educationalTipsEmail,
//               'Educational Tips Phone': student.settings.notifications.announcements.educationalTipsPhone,
//             },
//           },
//           'Privacy Settings': {
//             'Public Profile': student.settings.privacySettings.publicProfile,
//           },
//         },
//       };
      
//       batch.set(docRef, studentData);
//     }
    
//     await batch.commit();
//     print("Uploaded ${students.length} students successfully!");
//   } catch (e) {
//     print("Error uploading students: $e");
//     rethrow;
//   }
// }

// // Upload academic structure 
// Future<void> uploadAcademicStructure(FirebaseFirestore firestore) async {
//   print("\nUploading academic structure...");
  
//   try {
//     // First, create simpler Lessons and Components collections for direct access
//     // Upload Units
//     WriteBatch unitsBatch = firestore.batch();
//     for (var entry in advancedUnits.entries) {
//       Unit unit = entry.value;
//       DocumentReference unitRef = firestore.collection('Units').doc(unit.unitId);
//       unitsBatch.set(unitRef, {
//         'UnitId': unit.unitId,
//         'Title': unit.title,
//         'Description': unit.description,
//         'LessonIds': unit.lessonIds,
//         'UnitStatus': statusToFirestore(unit.unitStatus),
//         'totalComponents': unit.totalLessons,
//         'CreatedAt': unit.createdAt != null ? Timestamp.fromDate(unit.createdAt!) : Timestamp.now(),
//         'UpdatedAt': unit.updatedAt != null ? Timestamp.fromDate(unit.updatedAt!) : Timestamp.now(),
//       });
//     }
//     await unitsBatch.commit();
//     print("Uploaded ${advancedUnits.length} units to Units collection");
    
//     // Upload Lessons
//     WriteBatch lessonsBatch = firestore.batch();
//     for (var entry in advancedLessons.entries) {
//       Lesson lesson = entry.value;
//       DocumentReference lessonRef = firestore.collection('Lessons').doc(lesson.lessonId);
//       lessonsBatch.set(lessonRef, {
//         'Title': lesson.title,
//         'Description': lesson.description,
//         'LessonStatus': statusToFirestore(lesson.lessonStatus),
//         'Progress': lesson.progress,
//         'Components': lesson.components,
//         'totalComponents': lesson.totalComponents,
//         'interactiveActivityLinks': lesson.interactiveActivityLinks,
//         'TeachersGuideLink': lesson.teachersGuideLink,
//         'StudentWorkshopTemplateLinks': lesson.studentWorkshopTemplateLinks,
//       });
//     }
//     await lessonsBatch.commit();
//     print("Uploaded ${advancedLessons.length} lessons to Lessons collection");
    
//     // Upload Components
//     WriteBatch componentsBatch = firestore.batch();
//     int componentsCounter = 0;
//     for (var entry in advancedComponents.entries) {
//       Component component = entry.value;
//       DocumentReference componentRef = firestore.collection('Components').doc(component.componentId);
      
//       // Convert performance trends
//       Map<String, dynamic> performanceTrendsData = {
//         'ClassAverage': component.performanceTrends.classAverage,
//         'ParticipationRate': component.performanceTrends.participationRate,
//         'LessonCompletion': component.performanceTrends.lessonCompletion,
//         'LastUpdated': Timestamp.now(),
//       };
      
//       // Create base component data
//       Map<String, dynamic> componentData = {
//         'Title': component.title,
//         'Type': component.type.name,
//         'ComponentStatus': statusToFirestore(component.componentStatus),
//         'Progress': component.progress,
//         'PerformanceTrends': performanceTrendsData,
//       };
      
//       // Add discussion questions if present
//       if (component.discussionQuestions != null) {
//         componentData['DiscussionQuestions'] = component.discussionQuestions;
//       }
      
//       // Store question data
//       List<Map<String, dynamic>> questionDataList = [];
//       for (var subComponent in component.questionData) {
//         Map<String, dynamic> subComponentData = {
//           'type': subComponent.type.name,
//           'data': convertSubComponentDataToFirestore(subComponent),
//         };
//         questionDataList.add(subComponentData);
//       }
      
//       componentData['QuestionData'] = questionDataList;
      
//       // Add to batch
//       componentsBatch.set(componentRef, componentData);
      
//       componentsCounter++;
//       if (componentsCounter % 500 == 0) {
//         // Commit batch to avoid size limitations
//         await componentsBatch.commit();
//         componentsBatch = firestore.batch();
//         print("Uploaded batch of components (${componentsCounter})");
//       }
//     }
    
//     // Commit any remaining components
//     if (componentsCounter % 500 != 0) {
//       await componentsBatch.commit();
//       print("Uploaded final batch of components (${componentsCounter})");
//     }
    
//     print("Uploaded ${advancedComponents.length} components to Components collection");
    
//     print("Academic structure uploaded successfully!");
//   } catch (e) {
//     print("Error uploading academic structure: $e");
//     rethrow;
//   }
// }

// // Create cross-references between entities for easier access
// Future<void> createCrossReferences(FirebaseFirestore firestore) async {
//   print("\nCreating cross-references for efficient access...");
  
//   try {
//     // Create indexed collections for faster lookups
    
//     // Create LessonsIndex for quick lesson access
//     WriteBatch lessonsBatch = firestore.batch();
//     int lessonsCounter = 0;
    
//     for (var entry in advancedLessons.entries) {
//       String lessonId = entry.key;
//       Lesson lesson = entry.value;
      
//       String unitId = lessonId.split('.').take(2).join('.');
//       DocumentReference indexRef = firestore.collection('LessonsIndex').doc(lessonId);
      
//       lessonsBatch.set(indexRef, {
//         'lessonId': lessonId,
//         'title': lesson.title,
//         'status': statusToFirestore(lesson.lessonStatus),
//         'unitId': unitId,
//         'path': 'Lessons/$lessonId', // Points to the direct collection path
//         'componentCount': lesson.components.length,
//       });
      
//       lessonsCounter++;
//       if (lessonsCounter % 500 == 0) {
//         await lessonsBatch.commit();
//         lessonsBatch = firestore.batch();
//       }
//     }
    
//     if (lessonsCounter % 500 != 0) {
//       await lessonsBatch.commit();
//     }
    
//     print("Created LessonsIndex with $lessonsCounter entries");
    
//     // Create ComponentsIndex for quick component access
//     WriteBatch componentsBatch = firestore.batch();
//     int componentsCounter = 0;
    
//     for (var entry in advancedComponents.entries) {
//       String componentId = entry.key;
//       Component component = entry.value;
      
//       String lessonId = componentId.split('.').take(3).join('.');
//       String unitId = componentId.split('.').take(2).join('.');
//       DocumentReference indexRef = firestore.collection('ComponentsIndex').doc(componentId);
      
//       componentsBatch.set(indexRef, {
//         'componentId': componentId,
//         'title': component.title,
//         'type': component.type.name,
//         'status': statusToFirestore(component.componentStatus),
//         'lessonId': lessonId,
//         'unitId': unitId,
//         'path': 'Components/$componentId', // Points to the direct collection path
//       });
      
//       componentsCounter++;
//       if (componentsCounter % 500 == 0) {
//         await componentsBatch.commit();
//         componentsBatch = firestore.batch();
//       }
//     }
    
//     if (componentsCounter % 500 != 0) {
//       await componentsBatch.commit();
//     }
    
//     print("Created ComponentsIndex with $componentsCounter entries");
    
//   } catch (e) {
//     print("Error creating cross-references: $e");
//     rethrow;
//   }
// }

// // Convert SubComponent data to Firestore format based on type
// Map<String, dynamic> convertSubComponentDataToFirestore(SubComponent subComponent) {
//   try {
//     switch (subComponent.type) {
//       case SubComponentType.multipleChoice:
//         final data = subComponent.data as MultipleChoice;
//         return {
//           'questionHeading': data.questionHeading,
//           'question': data.question,
//           'questionExplanation': data.questionExplanation,
//           'options': data.options,
//           'correctAnswers': data.correctAnswers,
//           'prompts': {
//             'correct': data.prompts.correct,
//             'incorrect': data.prompts.incorrect,
//           },
//         };
        
//       case SubComponentType.revealCard:
//         final data = subComponent.data as RevealCard;
//         return {
//           'title': data.title,
//           'definition': data.definition,
//           'tapInstruction': data.tapInstruction,
//           'whyMatter': data.whyMatter,
//         };
        
//       case SubComponentType.iconReveal:
//         final data = subComponent.data as IconReveal;
//         return {
//           'title': data.title,
//           'iconLinks': data.iconLinks,
//           'contents': data.contents,
//         };
        
//       case SubComponentType.scenario:
//         final data = subComponent.data as Scenario;
//         List<Map<String, dynamic>> questionsList = [];
        
//         for (var q in data.questions) {
//           questionsList.add({
//             'questionHeading': q.questionHeading,
//             'question': q.question,
//             'questionExplanation': q.questionExplanation,
//             'options': q.options,
//             'correctAnswers': q.correctAnswers,
//             'prompts': {
//               'correct': q.prompts.correct,
//               'incorrect': q.prompts.incorrect,
//             },
//           });
//         }
        
//         return {
//           'title': data.title,
//           'scenarioExplanation': data.scenarioExplanation,
//           'questions': questionsList,
//         };
        
//       case SubComponentType.learningCheck:
//         final data = subComponent.data as LearningCheck;
//         return {
//           'title': data.title,
//           'question1': data.question1,
//           'question2': data.question2,
//           'options1': data.options1,
//           'options2': data.options2,
//           'correctAns1': data.correctAns1,
//           'correctAns2': data.correctAns2,
//           'feedbackCorrect': data.feedbackCorrect,
//           'feedbackOneIncorrect': data.feedbackOneIncorrect,
//           'feedbackBothIncorrect': data.feedbackBothIncorrect,
//         };
        
//       case SubComponentType.keyTakeaways:
//         final data = subComponent.data as KeyTakeaways;
//         List<Map<String, dynamic>> takeawaysList = [];
        
//         for (var takeaway in data.takeaways) {
//           takeawaysList.add({
//             'title': takeaway.title,
//             'description': takeaway.description,
//             'imageUrl': takeaway.imageUrl,
//           });
//         }
        
//         return {
//           'title': data.title,
//           'hint': data.hint,
//           'takeaways': takeawaysList,
//         };
        
//       case SubComponentType.intro:
//         final data = subComponent.data as IntroPage;
//         return {
//           'title': data.title,
//           'mintyText': data.mintyText,
//           'imageUrl': data.imageUrl,
//         };
        
//       case SubComponentType.problem:
//         final data = subComponent.data as ProblemPage;
//         return {
//           'title': data.title,
//           'subtitle': data.subtitle,
//           'scenarioText': data.scenarioText,
//           'instructions': data.instructions,
//           'problem': data.problem,
//         };
        
//       case SubComponentType.solution:
//         final data = subComponent.data as SolutionPage;
//         return {
//           'title': data.title,
//           'subtitle': data.subtitle,
//           'Card1': data.Card1,
//           'Card2': data.Card2,
//           'Card3': data.Card3,
//         };
        
//       case SubComponentType.impact:
//         final data = subComponent.data as Impact;
//         return {
//           'title': data.title,
//           'subtitle': data.subtitle,
//           'beforeContent': data.beforeContent,
//           'afterContent': data.afterContent,
//         };
        
//       case SubComponentType.scenariointro:
//         final data = subComponent.data as IntroductionPage;
//         List<Map<String, dynamic>> optionsList = [];
        
//         for (var option in data.options) {
//           optionsList.add({
//             'title': option.title,
//             'iconUrl': option.iconUrl,
//             'score': option.score,
//             'type': option.type,
//           });
//         }
        
//         return {
//           'scenario': data.scenario,
//           'mintyImage': data.mintyImage,
//           'options': optionsList,
//         };
        
//       case SubComponentType.scenarioquestion:
//         final data = subComponent.data as ScenarioQuestion;
//         List<Map<String, dynamic>> optionsList = [];
        
//         for (var option in data.options) {
//           optionsList.add({
//             'title': option.title,
//             'iconUrl': option.iconUrl,
//             'score': option.score,
//             'type': option.type,
//           });
//         }
        
//         return {
//           'questionText': data.questionText,
//           'options': optionsList,
//           'feedback': data.feedback,
//         };
        
//       case SubComponentType.scenariochoice:
//         final data = subComponent.data as ScenarioChoice;
//         return {
//           'category': data.category,
//           'value': data.value,
//           'scoreImpact': data.scoreImpact,
//         };
        
//       case SubComponentType.scenarioresults:
//         final data = subComponent.data as ScenarioResult;
//         List<Map<String, dynamic>> selectedChoicesList = [];
        
//         for (var choice in data.selectedChoices) {
//           selectedChoicesList.add({
//             'category': choice.category,
//             'value': choice.value,
//             'scoreImpact': choice.scoreImpact,
//           });
//         }
        
//         return {
//           'selectedChoices': selectedChoicesList,
//           'finalScore': data.finalScore,
//           'categories': data.categories,
//           'feedback': data.feedback,
//         };
        
//       case SubComponentType.peerintro:
//         final data = subComponent.data as PeerReflectionIntro;
//         List<Map<String, dynamic>> charactersList = [];
        
//         for (var character in data.characters) {
//           charactersList.add({
//             'name': character.name,
//             'role': character.role,
//             'story': character.story,
//             'imageUrl': character.imageUrl,
//           });
//         }
        
//         return {
//           'title': data.title,
//           'subTitle': data.subTitle,
//           'characters': charactersList,
//         };
        
//       case SubComponentType.peerstories:
//         final data = subComponent.data as PeerStories;
//         List<Map<String, dynamic>> charactersList = [];
        
//         for (var character in data.characters) {
//           charactersList.add({
//             'name': character.name,
//             'role': character.role,
//             'story': character.story,
//             'imageUrl': character.imageUrl,
//           });
//         }
        
//         return {
//           'title': data.title,
//           'characters': charactersList,
//         };
        
//       case SubComponentType.peermatch:
//         final data = subComponent.data as PeerMatch;
//         List<Map<String, dynamic>> categoriesList = [];
        
//         for (var category in data.categories) {
//           categoriesList.add({
//             'title': category.title,
//             'correctActions': category.correctActions,
//           });
//         }
        
//         return {
//           'title': data.title,
//           'categories': categoriesList,
//           'actions': data.actions,
//           'feedbackMessages': data.feedbackMessages,
//         };
        
//       case SubComponentType.peerreflectionend:
//         final data = subComponent.data as PeerReflectionEnd;
//         List<Map<String, dynamic>> optionsList = [];
        
//         for (var option in data.options) {
//           optionsList.add({
//             'name': option.name,
//             'description': option.description,
//             'imageUrl': option.imageUrl,
//           });
//         }
        
//         return {
//           'question': data.question,
//           'options': optionsList,
//           'feedbackMessages': data.feedbackMessages,
//           'buttonText': data.buttonText,
//         };
        
//       case SubComponentType.quizimagemcquestion:
//         final data = subComponent.data as QuizMultipleChoice;
//         List<Map<String, dynamic>> optionsList = [];
        
//         for (var option in data.options) {
//           optionsList.add({
//             'text': option.text,
//             'imageUrl': option.imageUrl,
//           });
//         }
        
//         return {
//           'question': data.question,
//           'options': optionsList,
//           'correctAnswers': data.correctAnswers,
//           'feedbackMessages': data.feedbackMessages,
//           'isMultiSelect': data.isMultiSelect,
//           'buttonText': data.buttonText,
//           'imageUrl': data.imageUrl,
//         };
        
//       case SubComponentType.quiztextmcquestion:
//         final data = subComponent.data as TextBasedQuestion;
//         return {
//           'question': data.question,
//           'options': data.options,
//           'correctAnswers': data.correctAnswers,
//           'feedbackMessages': data.feedbackMessages,
//           'isMultiSelect': data.isMultiSelect,
//           'buttonText': data.buttonText,
//         };
        
//       default:
//         print("Unknown SubComponent type: ${subComponent.type.name}");
//         return {'error': 'Unknown SubComponent type'};
//     }
//   } catch (e) {
//     print("Error converting SubComponent of type ${subComponent.type.name}: $e");
//     return {
//       'error': 'Failed to convert data: $e',
//       'rawData': subComponent.data.toString(),
//     };
//   }
// }