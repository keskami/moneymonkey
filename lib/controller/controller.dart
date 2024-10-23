import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  var progress = 0.0.obs;  // Initial progress value
  var cardsCompleted = false.obs;
    var quizCompleted = false.obs;
    var isCorrectSelected = false.obs;
     var attempts = 0.obs; // Track the number of attempts

    
   void setCardsCompleted() {
    cardsCompleted.value = true;
    print("All cards have been flipped and swiped.");
    // You can add additional logic here, like updating the user's progress in Firestore.
      checkCompletion(); // Ensure this is checked after setting the flag
  }

    // Call this method when the correct answer is selected
  void setCorrectSelection(bool isCorrect) {
    isCorrectSelected.value = isCorrect;
  }
// Method to record an attempt
  void recordAttempt(bool isCorrect) {
    if (!isCorrect) {
      attempts.value += 1;  // Increment the attempts only for incorrect answers
    }
  }
   void resetAttempts() {
    attempts.value = 0;  // Reset the attempts when the quiz starts or is retried
  }


  void incrementProgress() {
    if (progress.value < 1) {
      progress.value += 0.2; // Increase progress by 20%
    }
  }

    void setQuizCompleted() {
    quizCompleted.value = true;
    print("Quiz Completed");
    checkCompletion();
  }
  void checkCompletion() {
    if (cardsCompleted.isTrue && quizCompleted.isTrue) {
      awardBananas();  // All conditions met, award bananas
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
      // Reference to the user's Progression sub-collection
      try{
      final progressionRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Progression')
          .doc('progression1');

      final docSnapshot = await progressionRef.get();

      if (docSnapshot.exists) {
         final earnings = docSnapshot.data()?['Earnings from Lesson'] ?? {};
         final currentBananas = earnings['Bananas'] ?? 0;

        await progressionRef.update({
          'Earnings from Lesson.Bananas': currentBananas + 10,
        });
        
        // Update progress bar or notify UI
        progress.value = 1.0;
      }else{
          print('Document does not exist');
      }
      } catch(e){
         print('Error awarding bananas: $e');
      }
    }
  }
}
