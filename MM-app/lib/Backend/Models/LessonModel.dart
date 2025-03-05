// lesson_model.dart

class LessonModel {
  final String lessonName;
  final int lessonNumber;

  // Each component can be stored as a map of pageNumber -> pageData
  final Map<int, dynamic> conceptPages;
  final Map<int, dynamic> concept2Pages;
  final Map<int, dynamic> storyPages;
  final Map<int, dynamic> scenarioPages;
  final Map<int, dynamic> peerReflectionPages;
  final Map<int, dynamic> quizPages;

  LessonModel({
    required this.lessonName,
    required this.lessonNumber,
    required this.conceptPages,
    required this.concept2Pages,
    required this.storyPages,
    required this.scenarioPages,
    required this.peerReflectionPages,
    required this.quizPages,
  });

  // If you want to parse from Firestore docs, do so here or in the Repository.
  // This example is just a placeholder.
}
