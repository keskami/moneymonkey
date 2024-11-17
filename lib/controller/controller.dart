import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
 // var selectedOptionIndex = (-1).obs;
 
  var flashcards = <Map<String, dynamic>>[].obs;
  var currentLessonTitle= ''.obs;
  var unitTitle = ''.obs;
  var isChestOpened = false.obs; // Track if the chest is opened
  var quizOptions = <String>[].obs;
   var quizQuestion = ''.obs;
   var correctAnswer = ''.obs;
   var quizQuestions = <Map<String, dynamic>>[].obs;
   var useImageGridFormat = false.obs;


  void setCardsCompleted() {
    cardsCompleted.value = true;
    print("All cards have been flipped and swiped.");
    // You can add additional logic here, like updating the user's progress in Firestore.
    checkCompletion(); // Ensure this is checked after setting the flag
  }

  // Update selected option index
  // void setSelectedOptionIndex(int index) {
  //   selectedOptionIndex.value = index;
  //   isOptionSelected.value = true; // Set that an option is selected
  //   print("option selected");
  // }

// Reset selection
  void resetSelection() {
    selectedOptionIndex.value = -1; // Deselect all options
    isOptionSelected.value = false; // Indicate no option is selected
    //selectedOptionIndex.refresh(); // Force UI to update
  //update();
    print("Selection has been reset.");
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
    update();
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
   // Reset quiz state
  currentQuestionIndex.value = 0;
  selectedOptionIndex.value = -1;
  quizCompleted.value = false;

  // Fetch quiz data for the new lesson
  fetchQuizData('lesson${currentLessonIndex.value + 1}');
  print("Fetching quiz data for lesson${currentLessonIndex.value + 1}");


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
      progress.value += 0.15; // Increase progress by 20%
    }
  }

  void decrementProgress() {
    if (progress.value < 1) {
      progress.value -= 0.2;
    }
  }

  var currentQuestionIndex = 0.obs;

   // Fetch quiz data from Firestore for the current lesson
  Future<void> fetchQuizData(String lessonId) async {
    try {
      final lessonDoc = await FirebaseFirestore.instance
          .collection('lessons')
          .doc(lessonId)
          .get();

      if (lessonDoc.exists) {
        final quizData = lessonDoc.data()?['quiz'] as List<dynamic>?;

        if (quizData != null && quizData.isNotEmpty) {
          quizQuestions.value =
              quizData.map((item) => item as Map<String, dynamic>).toList();
          currentQuestionIndex.value = 0;
          loadQuestion();
        }
      }
    } catch (e) {
      print('Error fetching quiz data: $e');
    }
  }

 // Load the current question and options
void loadQuestion() {
  resetSelection();
  
  // Switch to image grid format for questions 3 and 4
  if (currentQuestionIndex.value == 2 || currentQuestionIndex.value == 3) {
    useImageGridFormat.value = true;
  } else {
    useImageGridFormat.value = false;
  }

  if (currentQuestionIndex.value < quizQuestions.length) {
    final currentQuestion = quizQuestions[currentQuestionIndex.value];

    quizQuestion.value = currentQuestion['question'] ?? 'No question available';
    correctAnswer.value = currentQuestion['correctAnswer'] ?? currentQuestion['CorrectAnswer'] ?? '';
    quizOptions.value = List<String>.from(currentQuestion['option'].values.map((e) => e.toString()));

    resetSelection();
    setDialogShown(false);
    isCorrectSelected.value = false;

    print("Loaded Question: ${quizQuestion.value}");
    print("Correct Answer: ${correctAnswer.value}");
    print("Options: ${quizOptions}");
  } else {
    Get.toNamed("/lessonCompletePageRoute");
  }
}



  // Move to the next question
void nextQuestion() {
  resetSelection();
  if (currentQuestionIndex.value < quizQuestions.length - 1) {
    // Increment question index
    currentQuestionIndex.value += 1;
    // Load the next question
    loadQuestion();
  } else {
    // Mark quiz as completed
    setQuizCompleted();

    // Award bananas and move to next lesson
    awardBananas().then((_) {
      print("Bananas awarded, moving to the next lesson...");
      moveToNextLesson();
    });
  }

  // Reset dialog shown state
  setDialogShown(false);
}
  
 var selectedOptionIndex = ValueNotifier<int>(-1);
  // Set the selected option index
  void setSelectedOptionIndex(int index) {
    selectedOptionIndex.value = index;
    isOptionSelected.value = true;
    bool isCorrect = quizOptions[index] == correctAnswer.value;
    isCorrectSelected.value = isCorrect;
     print("Selected option index: $index, Correct: $isCorrect");
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
