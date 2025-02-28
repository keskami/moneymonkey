enum QuestionType {
  // concept
  multipleChoice,
  revealCard,
  iconReveal,
  learningCheck,
  scenario,
  keyTakeaways,
  // story
  intro,
  newlanding,
  problem,
  solution,
  impact,
  // scenario
  scenariointro,
  scenarioquestion,
  scenarioresults,
  scenariochoice,
  // peer review
  peerintro,
  peerstories,
  peermatch,
  peerreflectionend,
  // quiz
  quizimagemcquestion,
  quiztextmcquestion,
}

extension QuestionTypeExtension on QuestionType {
  String get name => toString().split('.').last;

  static QuestionType fromString(String name) {
    return QuestionType.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () {
        throw Exception("Invalid question type: $name");
      },
    );
  }
}

class Prompt {
  const Prompt({
    required this.correct,
    required this.incorrect,
  });

  final String correct;
  final String incorrect;

  factory Prompt.fromMap(Map<String, dynamic> map) {
    return Prompt(
      correct: map['correct'] as String,
      incorrect: map['incorrect'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'correct': correct,
      'incorrect': incorrect,
    };
  }
}

class MultipleChoice {
  const MultipleChoice({
    required this.questionHeading,
    required this.question,
    required this.questionExplanation,
    required this.options,
    required this.correctAnswers,
    required this.prompts,
  });
  final String questionHeading;
  final String question;
  final String questionExplanation;
  final List<String> correctAnswers;
  final List<String> options;
  final Prompt prompts;

  factory MultipleChoice.fromMap(Map<String, dynamic> map) {
    return MultipleChoice(
      questionHeading: map['questionHeading'],
      question: map['question'],
      questionExplanation: map['questionExplanation'],
      options: List<String>.from(map['options']),
      correctAnswers: List<String>.from(map['correctAnswers']),
      prompts: Prompt.fromMap(map['prompts']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionHeading': questionHeading,
      'question': question,
      'questionExplanation': questionExplanation,
      'options': options,
      'correctAnswers': correctAnswers,
      'prompts': prompts.toMap(),
    };
  }
}

class RevealCard {
  const RevealCard({
    required this.title,
    required this.definition,
    required this.tapInstruction,
    required this.whyMatter,
  });
  final String title;
  final String definition;
  final String tapInstruction;
  final String whyMatter;

  factory RevealCard.fromMap(Map<String, dynamic> map) {
    return RevealCard(
      title: map['title'],
      definition: map['definition'],
      tapInstruction: map['tapInstruction'] as String,
      whyMatter: map['whyMatter']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'definition': definition,
      'tapInstruction': tapInstruction,
      'whyMatter': whyMatter,
    };
  }
}

class IconReveal {
  const IconReveal({
    required this.iconLinks,
    required this.contents, required this.title,
  });

  final List<String> iconLinks;
  final List<String> contents;
  final String title;

  factory IconReveal.fromMap(Map<String, dynamic> map) {
    return IconReveal(
      title: map['title'],
      iconLinks: List<String>.from(map['iconLinks']),
      contents: List<String>.from(map['contents']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'iconLinks': iconLinks,
      'contents': contents,
    };
  }
}

class Scenario {
  const Scenario({
    required this.title,
    required this.scenarioExplanation,
    required this.questions,
  });
  final String title;
  final List<MultipleChoice> questions;
  final String scenarioExplanation;

  factory Scenario.fromMap(Map<String, dynamic> map) {
    print("Parsing Scenario with data: $map");

    List<MultipleChoice> parsedQuestions = [];
    if (map['questions'] != null) {
      final questionsList = map['questions'] as List<dynamic>;
      print("Processing ${questionsList.length} scenario questions");

      parsedQuestions = questionsList.map((questionData) {
        print("Processing scenario question data: $questionData");
        if (questionData is Map<String, dynamic>) {
          try {
            return MultipleChoice.fromMap(questionData);
          } catch (e) {
            print("Error parsing scenario question: $e");
            throw e;
          }
        } else {
          throw Exception(
              "Invalid question data format in scenario: $questionData");
        }
      }).toList();
    }

    return Scenario(
      title: map['title'] as String? ?? "Missing title",
      scenarioExplanation:
          map['scenarioExplanation'] as String? ?? "Missing explanation",
      questions: parsedQuestions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'scenarioExplanation': scenarioExplanation,
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }
}

class LearningCheck {
  const LearningCheck({
    required this.title,
    required this.question1,
    required this.question2,
    required this.options1,
    required this.options2,
    required this.correctAns1,
    required this.correctAns2,
    required this.feedbackCorrect,
    required this.feedbackOneIncorrect,
    required this.feedbackBothIncorrect,
  });

  final String title;
  final String question1;
  final String question2;
  final String correctAns1;
  final String correctAns2;
  final List<String> options1;
  final List<String> options2;
  final String feedbackCorrect;
  final String feedbackOneIncorrect;
  final String feedbackBothIncorrect;

  factory LearningCheck.fromMap(Map<String, dynamic> map) {
    print("Parsing LearningCheck with data: $map"); // Debug log

    return LearningCheck(
      title: map["title"] ?? "Missing title",
      question1: map["question1"] ?? "Missing question",
      question2: map["question2"] ?? "Missing question",
      options1: List<String>.from(map["options1"] ?? []),
      options2: List<String>.from(map["options2"] ?? []),
      correctAns1: map["correctAns1"] ?? "",
      correctAns2: map["correctAns2"] ?? "",
      feedbackCorrect: map["feedbackCorrect"] ?? "Great job! You got both correct!",
      feedbackOneIncorrect: map["feedbackOneIncorrect"] ?? "Almost there! One answer is incorrect.",
      feedbackBothIncorrect: map["feedbackBothIncorrect"] ?? "Be careful! Both answers are incorrect.",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'question1': question1,
      'question2': question2,
      'options1': options1,
      'options2': options2,
      'correctAns1': correctAns1,
      'correctAns2': correctAns2,
      'feedbackCorrect': feedbackCorrect,
      'feedbackOneIncorrect': feedbackOneIncorrect,
      'feedbackBothIncorrect': feedbackBothIncorrect,
    };
  }

  /// **Logic to determine feedback based on user answers**
  String getFeedback(String userAnswer1, String userAnswer2) {
    bool isFirstCorrect = userAnswer1 == correctAns1;
    bool isSecondCorrect = userAnswer2 == correctAns2;

    if (isFirstCorrect && isSecondCorrect) {
      return feedbackCorrect; 
    } else if (isFirstCorrect || isSecondCorrect) {
      return feedbackOneIncorrect;
    } else {
      return feedbackBothIncorrect;
    }
  }
}

class Takeaway {
  const Takeaway({
    required this.title,
    required this.description,
    required this.imageUrl, // Added image property
  });

  final String title;
  final String description;
  final String imageUrl; // New field for icon

  factory Takeaway.fromMap(Map<String, dynamic> map) {
    return Takeaway(
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'], // Fetch image URL from map
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl, // Include image URL in map
    };
  }
}

class KeyTakeaways {
  const KeyTakeaways({
    required this.title,
    required this.hint,
    required this.takeaways,
  });

  final String title;
  final String hint;
  final List<Takeaway> takeaways;

  factory KeyTakeaways.fromMap(Map<String, dynamic> map) {
    final takeawayList = List<Map<String, dynamic>>.from(map['takeaways']);
    return KeyTakeaways(
      title: map['title'],
      hint: map['hint'],
      takeaways: takeawayList.map((takeaway) => Takeaway.fromMap(takeaway)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'hint': hint,
      'takeaways': takeaways.map((t) => t.toMap()).toList(),
    };
  }
}


// Story Page

// ==============================
// Story Models
// ==============================

// Story intro
class IntroPage {
  const IntroPage({
    required this.title,
    required this.mintyText,
    required this.imageUrl,
  });

  final String title;
  final String mintyText;
  final String imageUrl;

  factory IntroPage.fromMap(Map<String, dynamic> map) {
    return IntroPage(
      title: map["title"] ?? "Missing title",
      mintyText: map["mintyText"] ?? "Hello! I'm Minty!",
      imageUrl: map["imageUrl"] ??
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "mintyText": mintyText,
      "imageUrl": imageUrl,
    };
  }
}

class newlanding {
  const newlanding({
    required this.title,
    required this.subtitle,
    required this.meetMinty,
    required this.mintyUrl,
  });

  final String title;
  final String subtitle;
  final String meetMinty;
  final String mintyUrl;

  factory newlanding.fromMap(Map<String, dynamic> map) {
    return newlanding(
      title: map['title'] ?? "Missing title",
      subtitle: map['subtitle'] ?? "",
      meetMinty: map['meetMinty'] ?? "Meet Minty the Money Monkey",
      mintyUrl: map['mintyUrl'] ??
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'meetMinty': meetMinty,
      'mintyUrl': mintyUrl,
    };
  }
}

class ProblemPage {
  const ProblemPage({
    required this.title,
    required this.subtitle,
    required this.scenarioText,
    required this.instructions,
    required this.problem,
  });

  final String title;
  final String subtitle;
  final String scenarioText;
  final String instructions;
  final String problem;

  factory ProblemPage.fromMap(Map<String, dynamic> map) {
    return ProblemPage(
      title: map["title"] ?? "Missing title",
      subtitle: map["subtitle"] ?? "",
      scenarioText: map["scenarioText"] ?? "Missing scenario",
      instructions: map["instructions"] ?? "Missing instructions",
      problem: map["problem"] ?? "No problem defined",
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "subtitle": subtitle,
      "scenarioText": scenarioText,
      "instructions": instructions,
      "problem": problem,
    };
  }
}

class SolutionPage {
  const SolutionPage({
    required this.title,
    required this.subtitle,
    required this.Card1,
    required this.Card2,
    required this.Card3,
    
  });

  final String title;
  final String subtitle;
  final List<String> Card1;
  final List<String> Card2;
  final List<String> Card3; 

  factory SolutionPage.fromMap(Map<String, dynamic> map) {
    return SolutionPage(
      title: map["title"] ?? "Missing title",
      subtitle: map["subtitle"] ?? "Missing subtitle",
      Card1: List<String>.from(map["Card1"] ?? []),
      Card2: List<String>.from(map["Card2"] ?? []),
      Card3: List<String>.from(map["Card3"] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "subtitle": subtitle,
      "titleCard1": Card1,
      "titleCard2": Card2,
      "titleCard3": Card3,
    };
  }
}

class Impact {
  const Impact({
    required this.title,
    required this.subtitle,
    required this.beforeContent,
    required this.afterContent,
  });

  final String title;
  final String subtitle;
  final List<String> beforeContent;
  final List<String> afterContent;

  factory Impact.fromMap(Map<String, dynamic> map) {
    return Impact(
      title: map["title"] ?? "Missing title",
      subtitle: map["subtitle"] ?? "Missing subtitle",
      beforeContent: List<String>.from(map["beforeContent"] ?? []),
      afterContent: List<String>.from(map["afterContent"] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "subtitle": subtitle,
      "beforeContent": beforeContent,
      "afterContent": afterContent,
    };
  }
}

// Scenario Simulation

// ==============================
// SCENARIO MODELS
// ==============================

// Scenario Option (e.g., Sneakers, College, Activities)
class ScenarioOption {
  const ScenarioOption({required this.title, required this.iconUrl, required this.score, required this.type});

  final String title;
  final String iconUrl;
  final int score;
  final String type;

  factory ScenarioOption.fromMap(Map<String, dynamic> map) {
    if (map['title'] == null || map['iconUrl'] == null || map['score'] == null) {
      throw Exception("Missing required fields in ScenarioOption");
    }
    return ScenarioOption(
      title: map['title'],
      iconUrl: map['iconUrl'],
      score: map['score'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'iconUrl': iconUrl, 'score': score, 'type': type};
  }
}

// Scenario Introduction Page
class IntroductionPage {
  const IntroductionPage({
    required this.scenario,
    required this.mintyImage,
    required this.options,
  });

  final String scenario;
  final String mintyImage;
  final List<ScenarioOption> options;

  factory IntroductionPage.fromMap(Map<String, dynamic> map) {
    return IntroductionPage(
      scenario: map['scenario'] ?? "Missing scenario",
      mintyImage: map['mintyImage'] ?? "assets/images/minty.png",
      options: (map['options'] as List<dynamic>)
          .map((option) => ScenarioOption.fromMap(option))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'scenario': scenario,
      'mintyImage': mintyImage,
      'options': options.map((o) => o.toMap()).toList(),
    };
  }
}

// Scenario Question Page

class ScenarioQuestion {
  const ScenarioQuestion({
    required this.questionText,
    required this.options,
    required this.feedback,
  });

  final String questionText;
  final List<ScenarioOption> options;
  final Map<String,String> feedback; // Response message after selecting an option

  factory ScenarioQuestion.fromMap(Map<String, dynamic> map) {
    return ScenarioQuestion(
      questionText: map['questionText'] ?? "No question text",
      options: (map['options'] as List<dynamic>)
          .map((option) => ScenarioOption.fromMap(option))
          .toList(),
      feedback: Map<String, String>.from(map['feedback'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options.map((o) => o.toMap()).toList(),
      'feedback': feedback,
    };
  }
}

class ScenarioResult {
  ScenarioResult({
    required this.selectedChoices, // User's choices affecting finances
    required this.finalScore,
  }) {
    _calculateResults(); // Automatically compute results on initialization
  }

  final List<ScenarioChoice> selectedChoices; // Tracks what the user picked
  int finalScore;
  Map<String, int> categories = {}; // Holds calculated financial breakdown
  String feedback = ""; // Final feedback message

  // Method to calculate the financial impact dynamically
  void _calculateResults() {
    int totalScore = 0;

    for (var choice in selectedChoices) {
      categories[choice.category] = (categories[choice.category] ?? 0) + choice.value;
      totalScore += choice.scoreImpact;
    }

    finalScore = totalScore.clamp(0, 100); // Ensures score stays between 0-100
    feedback = getFeedback(finalScore);
  }

  static String getFeedback(int score) {
    if (score >= 80) {
      return "Amazing! You’re doing a fantastic job at making responsible financial decisions. You’re well on your way to building strong financial habits for the future. Keep up the great work!";
    } else if (score >= 50) {
      return "Good effort! You’re on the right track, but there’s room for improvement. Try focusing more on saving and planning for future expenses. Keep practicing to build stronger financial habits.";
    } else {
      return "You’ve got some work to do when it comes to financial responsibility. Remember, saving and planning are key to avoiding financial stress. Review what you’ve learned and keep practicing to improve.";
    }
  }

  // Fix: fromMap constructor added
  factory ScenarioResult.fromMap(Map<String, dynamic> map) {
    return ScenarioResult(
      selectedChoices: (map['selectedChoices'] as List<dynamic>?)?.map((choice) => ScenarioChoice.fromMap(choice)).toList() ?? [],
      finalScore: map['finalScore'] ?? 0,
    );
  }

  // Fix: toMap conversion
  Map<String, dynamic> toMap() {
    return {
      'selectedChoices': selectedChoices.map((choice) => choice.toMap()).toList(),
      'categories': categories,
      'finalScore': finalScore,
      'feedback': feedback,
    };
  }
}

class ScenarioChoice {
  const ScenarioChoice({
    required this.category, // The category (e.g., "Savings", "Sneakers")
    required this.value, // Amount allocated (e.g., $250)
    required this.scoreImpact, // How much it affects the final score
  });

  final String category;
  final int value;
  final int scoreImpact;

  // Fix: fromMap constructor
  factory ScenarioChoice.fromMap(Map<String, dynamic> map) {
    return ScenarioChoice(
      category: map['category'] ?? "Unknown",
      value: map['value'] ?? 0,
      scoreImpact: map['scoreImpact'] ?? 0,
    );
  }

  // Fix: toMap conversion
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'value': value,
      'scoreImpact': scoreImpact,
    };
  }
}

// Peer Reflection

// ==============================
// Peer Reflection MODELS
// ==============================

// Peer Character Model for Reusability
class PeerCharacter {
  const PeerCharacter({
    required this.name,
    required this.role, // Instead of shortDescription
    required this.story,  // Instead of fullDescription
    required this.imageUrl,
  });

  final String name;
  final String role; // Example: "The Planner", "Family Provider"
  final String story; // The character's financial reflection
  final String imageUrl;

  factory PeerCharacter.fromMap(Map<String, dynamic> map) {
    return PeerCharacter(
      name: map['name'] ?? "Unknown",
      role: map['role'] ?? "No role defined",
      story: map['story'] ?? "No story available",
      imageUrl: map['imageUrl'] ?? "assets/images/default.png",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role,
      'story': story,
      'imageUrl': imageUrl,
    };
  }
}

// Peer Reflection Intro Model (Now Supports Dynamic Characters)
class PeerReflectionIntro {
  const PeerReflectionIntro({
    required this.title,
    required this.subTitle,
    required this.characters, // A dynamic list of peer characters
  });

  final String title;
  final String subTitle;
  final List<PeerCharacter> characters; // Replacing hardcoded names

  factory PeerReflectionIntro.fromMap(Map<String, dynamic> map) {
    return PeerReflectionIntro(
      title: map['title'] ?? "Missing title",
      subTitle: map['subTitle'] ?? "Missing subtitle",
      characters: (map['characters'] as List<dynamic>?)
          ?.map((char) => PeerCharacter.fromMap(char))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'characters': characters.map((char) => char.toMap()).toList(),
    };
  }
}

// Peer Stories

class PeerStories {
  const PeerStories({
    required this.title, // peer stories
    required this.characters, // all of the characters descriptions
  });

  final String title;
  final List<PeerCharacter> characters;

  factory PeerStories.fromMap(Map<String, dynamic> map) {
    return PeerStories(
      title: map['title'] ?? "Missing title",
      characters: (map['characters'] as List<dynamic>)
          .map((character) => PeerCharacter.fromMap(character))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'characters': characters.map((c) => c.toMap()).toList(),
    };
  }
}

// Match category model for components
class MatchCategory {
  const MatchCategory({
    required this.title,
    required this.correctActions,
  });

  final String title;
  final List<String> correctActions;

  factory MatchCategory.fromMap(Map<String, dynamic> map) {
    return MatchCategory(
      title: map['title'] ?? "Unknown Category",
      correctActions: List<String>.from(map['correctActions'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'correctActions': correctActions,
    };
  }
}

// Peer Reflection matching page

class PeerMatch {
  const PeerMatch({
    required this.title,
    required this.categories, // the categories
    required this.actions, // the actions
    required this.feedbackMessages, // the feedback messages, good + bad
  });

  final String title;
  final List<MatchCategory> categories;
  final List<String> actions;
  final Map<String, String> feedbackMessages;

  factory PeerMatch.fromMap(Map<String, dynamic> map) {
    return PeerMatch(
      title: map['title'] ?? "Match Actions to Categories",
      categories: (map['categories'] as List<dynamic>)
          .map((category) => MatchCategory.fromMap(category))
          .toList(),
      actions: List<String>.from(map['actions'] ?? []),
      feedbackMessages: Map<String, String>.from(map['feedbackMessages'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'categories': categories.map((c) => c.toMap()).toList(),
      'actions': actions,
      'feedbackMessages': feedbackMessages,
    };
  }
}

// Dynamic reflection option model for name, description, and image of characters
class ReflectionOption {
  const ReflectionOption({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  final String name;
  final String description;
  final String imageUrl;

  factory ReflectionOption.fromMap(Map<String, dynamic> map) {
    return ReflectionOption(
      name: map['name'] ?? "Unknown",
      description: map['description'] ?? "No description available",
      imageUrl: map['imageUrl'] ?? "assets/images/default.png",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}

// Final peer reflection page
class PeerReflectionEnd {
  const PeerReflectionEnd({
    required this.question, // which one and why
    required this.options,
    required this.feedbackMessages,
    required this.buttonText, // changes continue -> finish
  });

  final String question;
  final List<ReflectionOption> options;
  final Map<String, String> feedbackMessages; // good and bad
  final String buttonText;

  factory PeerReflectionEnd.fromMap(Map<String, dynamic> map) {
    return PeerReflectionEnd(
      question: map['question'] ??
          "Which peer's financial situation do you relate to most? Why?",
      options: (map['options'] as List<dynamic>)
          .map((option) => ReflectionOption.fromMap(option))
          .toList(),
      feedbackMessages: Map<String, String>.from(map['feedbackMessages'] ?? {}),
      buttonText: map['buttonText'] ?? "Finish Peer Reflection",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options.map((o) => o.toMap()).toList(),
      'feedbackMessages': feedbackMessages,
      'buttonText': buttonText,
    };
  }
}

// Final Quiz

// ==============================
// Final Quiz Models
// ==============================

// Quiz option logic for dynamic approach; text and url
class QuizOption {
  const QuizOption({
    required this.text,
    this.imageUrl, // Optional image for the option
  });

  final String text;
  final String? imageUrl; // Optional image

  factory QuizOption.fromMap(Map<String, dynamic> map) {
    return QuizOption(
      text: map['text'] ?? "Missing option",
      imageUrl: map['imageUrl'], // Optional
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'imageUrl': imageUrl, // Can be null
    };
  }
}

// MC Question
class QuizMultipleChoice {
  const QuizMultipleChoice({
    required this.question,
    required this.options,
    required this.correctAnswers,
    required this.feedbackMessages,
    required this.isMultiSelect,
    required this.buttonText,
    this.imageUrl, // Optional image for the question
  });

  final String question;
  final List<QuizOption> options; // List of answer choices
  final List<String> correctAnswers; // Supports multiple correct answers
  final Map<String, String> feedbackMessages; // Feedback for correct/incorrect responses
  final bool isMultiSelect; // Determines if the question allows multiple selections
  final String buttonText; // Text for the submission button
  final String? imageUrl; // Optional image URL

  factory QuizMultipleChoice.fromMap(Map<String, dynamic> map) {
    return QuizMultipleChoice(
      question: map['question'] ?? "Missing question",
      options: (map['options'] as List<dynamic>)
          .map((option) => QuizOption.fromMap(option))
          .toList(),
      correctAnswers: List<String>.from(map['correctAnswers'] ?? []),
      feedbackMessages: Map<String, String>.from(map['feedbackMessages'] ?? {}),
      isMultiSelect: map['isMultiSelect'] ?? false, // Default to single choice
      buttonText: map['buttonText'] ?? "Check",
      imageUrl: map['imageUrl'], // Optional
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options.map((o) => o.toMap()).toList(),
      'correctAnswers': correctAnswers,
      'feedbackMessages': feedbackMessages,
      'isMultiSelect': isMultiSelect,
      'buttonText': buttonText,
      'imageUrl': imageUrl, // Can be null
    };
  }
}

// No image MC Question; only text
class TextBasedQuestion {
  const TextBasedQuestion({
    required this.question,
    required this.options,
    required this.correctAnswers,
    required this.feedbackMessages,
    required this.isMultiSelect,
    required this.buttonText,
  });

  final String question;
  final List<String> options; // Text-only options
  final List<String> correctAnswers; // Supports multiple correct answers
  final Map<String, String> feedbackMessages; // Feedback for correct/incorrect responses
  final bool isMultiSelect; // Determines if multiple answers can be selected
  final String buttonText; // Text for the submission button

  factory TextBasedQuestion.fromMap(Map<String, dynamic> map) {
    return TextBasedQuestion(
      question: map['question'] ?? "Missing question",
      options: List<String>.from(map['options'] ?? []),
      correctAnswers: List<String>.from(map['correctAnswers'] ?? []),
      feedbackMessages: Map<String, String>.from(map['feedbackMessages'] ?? {}),
      isMultiSelect: map['isMultiSelect'] ?? false, // Defaults to single-choice
      buttonText: map['buttonText'] ?? "Check",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswers': correctAnswers,
      'feedbackMessages': feedbackMessages,
      'isMultiSelect': isMultiSelect,
      'buttonText': buttonText,
    };
  }
}

// Question class for dynamic handling
class Question {
  const Question({
    required this.type,
    required this.data,
  });

  final QuestionType type;
  final dynamic data;

  factory Question.fromMap(Map<String, dynamic> map) {
    print("Parsing Question with data: $map"); // Debug log

    final typeStr = map['type'] as String?;
    if (typeStr == null) {
      throw Exception("Question type is missing");
    }

    final type = QuestionTypeExtension.fromString(typeStr);
    final data = map['data'] as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("Question data is missing");
    }

    try {
      switch (type) {
        case QuestionType.multipleChoice:
          print("Parsing MultipleChoice question");
          return Question(
            type: type,
            data: MultipleChoice.fromMap(data),
          );

        case QuestionType.revealCard:
          print("Parsing RevealCard question");
          return Question(
            type: type,
            data: RevealCard.fromMap(data),
          );

        case QuestionType.iconReveal:
          print("Parsing IconReveal question");
          return Question(
            type: type,
            data: IconReveal.fromMap(data),
          );

        case QuestionType.learningCheck:
          print("Parsing LearningCheck question");
          return Question(
            type: type,
            data: LearningCheck.fromMap(data),
          );

        case QuestionType.scenario:
          print("Parsing Scenario question");
          return Question(
            type: type,
            data: Scenario.fromMap(data),
          );

        case QuestionType.keyTakeaways:
          print("Parsing KeyTakeaways question");
          return Question(
            type: type,
            data: KeyTakeaways.fromMap(data),
          );

        case QuestionType.intro:
          print("Parsing Story Intro");
          return Question(
            type: type,
            data: IntroPage.fromMap(data),
        );

        case QuestionType.newlanding:
          print("Parsing Landing Page");
          return Question(
            type: type, 
            data: newlanding.fromMap(data),
        );

        case QuestionType.problem:
          print("Parsing Impact question");
          return Question(
            type: type,
            data: ProblemPage.fromMap(data),
        );

        case QuestionType.solution:
          print("Parsing Solution Page");
          return Question(
            type: type,
            data: SolutionPage.fromMap(data)
        );

        case QuestionType.impact:
          print("Parsing Impact Page");
          return Question(
            type: type,
            data: Impact.fromMap(data)
        );

        case QuestionType.scenariointro:
          print("Parsing Scednario Introoduction Page");
          return Question(
            type: type,
            data: IntroductionPage.fromMap(data)
        );

        case QuestionType.scenarioquestion:
          print("Parsing question page");
          return Question(
              type: type,
              data: ScenarioQuestion.fromMap(data)
        );

        case QuestionType.scenariochoice:
          print("Parsing choices page");
          return Question(
              type: type,
              data: ScenarioChoice.fromMap(data)
        );
        
        
        case QuestionType.scenarioresults:
          print("Parsing results page");
          return Question(
            type: type,
            data: ScenarioResult.fromMap(data),
          );

        case QuestionType.peerintro:
          print("Parsing Peer Intro page");
          return Question(
              type: type,
              data: PeerReflectionIntro.fromMap(data)
        );

        case QuestionType.peerstories:
          print("Parsing Peer Stories page");
          return Question(
              type: type,
              data: PeerStories.fromMap(data)
        );

        case QuestionType.peermatch:
          print("Parsing Peer Matching page");
          return Question(
              type: type,
              data: PeerMatch.fromMap(data)
        );

        case QuestionType.peerreflectionend:
          print("Parsing Peer Refelction End page");
          return Question(
              type: type,
              data: PeerReflectionEnd.fromMap(data)
        );

        case QuestionType.quizimagemcquestion:
          print("Parsing Quiz Image Multiple Choice page");
          return Question(
              type: type,
              data: QuizMultipleChoice.fromMap(data)
        );

        case QuestionType.quiztextmcquestion:
          print("Parsing Quiz Text Multiple Choice page");
          return Question(
              type: type,
              data: TextBasedQuestion.fromMap(data)
        );

        default:
          throw Exception("Unsupported question type: ${type.name}");
      }
    } catch (e, stackTrace) {
      print("Error parsing ${type.name} question: $e");
      print("Stack trace: $stackTrace");
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'data': data.toMap(),
    };
  }
}