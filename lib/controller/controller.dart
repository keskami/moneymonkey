import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  var progress = 0.0.obs; // Initial progress value
  var cardsCompleted = false.obs;
  var quizCompleted = false.obs;
  var isCorrectSelected = false.obs;
  var attempts = 0.obs; // Track the number of attempts
  var isOptionSelected = false.obs;
  var currentLessonIndex = 0.obs;
  var isDialogShown = false.obs;
  var isChestUnlocked = false.obs;
  var selectedOptionIndex = (-1).obs;
  var flashcards = <Map<String, dynamic>>[].obs;
  var currentLessonTitle= ''.obs;
  var unitTitle = ''.obs;

  void setCardsCompleted() {
    cardsCompleted.value = true;
    print("All cards have been flipped and swiped.");
    // You can add additional logic here, like updating the user's progress in Firestore.
    checkCompletion(); // Ensure this is checked after setting the flag
  }

  // Update selected option index
  void setSelectedOptionIndex(int index) {
    selectedOptionIndex.value = index;
    isOptionSelected.value = true; // Set that an option is selected
    print("option selected");
  }

// Reset selection
  void resetSelection() {
    selectedOptionIndex.value = -1; // Deselect all options
    isOptionSelected.value = false; // Indicate no option is selected
  }

  void setOptionSelected(bool value) {
    isOptionSelected.value = value;
  }

  // Call this method when the correct answer is selected
  void setCorrectSelection(bool isCorrect) {
    isCorrectSelected.value = isCorrect;
    print("Correct option selected: $isCorrect");
    if (!isCorrect) {
      isDialogShown.value =
          false; // Reset dialog shown status for incorrect answers
    }
  }

  void setDialogShown(bool value) {
    isDialogShown.value = value;
  }

  void setQuizCompleted() {
    quizCompleted.value = true;
    print("Quiz Completed");
    checkCompletion();
  }

  void checkCompletion() {
    print("Checking completion...");
    print("cardsCompleted: ${cardsCompleted.value}");
    print("quizCompleted: ${quizCompleted.value}");

    if (cardsCompleted.isTrue && quizCompleted.isTrue) {
      print("Conditions met, awarding bananas...");
      awardBananas();
      moveToNextLesson();
      print("Lesson Completed");
    }
  }

void moveToNextLesson() {
  if (currentLessonIndex.value == 2) {
    // Unlock the chest and enable the fourth lesson after completing the third lesson
    isChestUnlocked.value = true;
    currentLessonIndex.value = 3; // Move to the chest (index 3)
  } else if (currentLessonIndex.value == 3) {
    // Move to the fourth lesson after clicking the chest
    currentLessonIndex.value = 4;
  } else if (currentLessonIndex.value == 4) {
    // After completing the fourth lesson, move to the first lesson of the next section
    currentLessonIndex.value += 1;
  } else {
    // Increment the lesson index normally
    currentLessonIndex.value += 1;
  }

  print("Moved to lesson ${currentLessonIndex.value}");

  // Update progress and UI
  progress.refresh();
  update();

  // Fetch the flashcards for the new lesson
  fetchFlashcards('lesson${currentLessonIndex.value + 1}');
  print("Fetching flashcards for lesson ${currentLessonIndex.value + 1}");
}

// Method to record an attempt
  void recordAttempt(bool isCorrect) {
    if (!isCorrect) {
      attempts.value += 1; // Increment the attempts only for incorrect answers
    }
  }

  void resetAttempts() {
    attempts.value = 0; // Reset the attempts when the quiz starts or is retried
  }

  void incrementProgress() {
    if (progress.value < 1) {
      progress.value += 0.2; // Increase progress by 20%
    }
  }

  void decrementProgress() {
    if (progress.value < 1) {
      progress.value -= 0.2;
    }
  }

 Future<void> fetchUnitTitle(String unitId) async {
    try {
      final unitDoc = await FirebaseFirestore.instance
          .collection('Unit')
          .doc(unitId)
          .get();

      if (unitDoc.exists) {
        unitTitle.value = unitDoc.data()?['title'] ?? 'Untitled Unit';
        print(unitTitle.value);
      } else {
        unitTitle.value = 'Unit not found';
      }
    } catch (e) {
      print('Error fetching unit title: $e');
      unitTitle.value = 'Error loading title';
    }
  }


// Fetch flashcards from Firestore based on the current lesson
  Future<void> fetchFlashcards(String lessonId) async {
    try {
      String lessonId = 'lesson${currentLessonIndex.value + 1}'; // Generate the lesson ID
      print(lessonId);
      final lessonDoc = await FirebaseFirestore.instance
          .collection('lessons')
          .doc(lessonId)
          .get();

      if (lessonDoc.exists) {
        final lessonTitle= lessonDoc.data()?['title'] ?? "Untitled Lesson";
        final flashcardsData = lessonDoc.data()?['flashcards'] as List<dynamic>?;
        if (flashcardsData != null) {
          flashcards.value = flashcardsData.map((item) {
            return {
              'front': item['front'] ?? '',
              'back': item['back'] ?? '',
              
            };
          }).toList();
         currentLessonTitle.value=lessonTitle;
        }
      }
    } catch (e) {
      print('Error fetching flashcards: $e');
    }
  }


  Future<void> fetchProgressFromFirestore() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    String? userId = currentUser?.uid;

    if (userId != null) {
      final progressionRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Progression')
          .doc('progression1'); // or other document related to progress

      final docSnapshot = await progressionRef.get();

      if (docSnapshot.exists) {
        // Assume you store progress as a percentage (0.0 to 1.0)
        progress.value = docSnapshot.data()?['progress'] ?? 0.0;
      }
    }
  }

//     Future<void> awardBananas() async {
//     var currentUser = FirebaseAuth.instance.currentUser;
//     String? userId = currentUser?.uid;

//     if (userId != null) {
//       // Reference to the user's Progression sub-collection
//       try{
//       final progressionRef = FirebaseFirestore.instance
//           .collection('Users')
//           .doc(userId)
//           .collection('Progression')
//           .doc('progression1');

//       final docSnapshot = await progressionRef.get();

//       if (docSnapshot.exists) {
//          final earnings = docSnapshot.data()?['Earnings from Lesson'] ?? {};
//          final currentBananas = earnings['Bananas'] ?? 0;

//         await progressionRef.update({
//           'Earnings from Lesson.Bananas': currentBananas + 10,
//         });

//         // Update progress bar or notify UI
//         progress.value = 1.0;
//       }else{
//           print('Document does not exist');
//       }
//       } catch(e){
//          print('Error awarding bananas: $e');
//       }
//     }
//   }
// }

  Future<void> awardBananas() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    String? userId = currentUser?.uid;

    if (userId != null) {
      try {
        // Reference to the user's Progression and Portfolio fields
        final userDocRef =
            FirebaseFirestore.instance.collection('Users').doc(userId);
        final progressionRef =
            userDocRef.collection('Progression').doc('progression1');

        // Fetch current values
        final docSnapshot = await progressionRef.get();
        final userSnapshot = await userDocRef.get();

        if (docSnapshot.exists && userSnapshot.exists) {
          // Update 'Earnings from Lesson.Bananas'
          final earnings = docSnapshot.data()?['Earnings from Lesson'] ?? {};
          final currentLessonBananas = earnings['Bananas'] ?? 0;
          await progressionRef.update({
            'Earnings from Lesson.Bananas': currentLessonBananas + 10,
          });

          // Update 'Portfolio.Total Bananas'
          final portfolio = userSnapshot.data()?['Portfolio'] ?? {};
          final currentTotalBananas = portfolio['Total Bananas'] ?? 0;
          await userDocRef.update({
            'Portfolio.Total Bananas': currentTotalBananas + 10,
          });

          // Update progress bar or notify UI
          progress.value = 1.0;
        } else {
          print('Document or User data does not exist');
        }
      } catch (e) {
        print('Error awarding bananas: $e');
      }
    }
  }
}
