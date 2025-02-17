enum SubComponentType {
  multipleChoice,
  revealCard,
  iconReveal,
  lerningCheck,
  scenario,
  keyTakeaways,
  revealCardStory,
  tapToRevealStory,
}

extension QuestionTypeExtension on SubComponentType {
  String get name => toString().split('.').last;

  static SubComponentType fromString(String name) {
    return SubComponentType.values.firstWhere((e) => e.name == name, orElse: () {
      throw Exception("Invalid question type: $name");
    });
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
    required this.question,
    required this.questionExplanation,
    required this.options,
    required this.correctAnswers,
    required this.prompts,
  });
  final String question;
  final String questionExplanation;
  final List<String> correctAnswers;
  final List<String> options;
  final Prompt prompts;

  factory MultipleChoice.fromMap(Map<String, dynamic> map) {
    return MultipleChoice(
      question: map['question'],
      questionExplanation: map['questionExplanation'],
      options: List<String>.from(map['options']),
      correctAnswers: List<String>.from(map['correctAnswers']),
      prompts: Prompt.fromMap(map['prompts']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
    required this.definition,
    required this.tapInstruction,
    required this.revealInformation,
  });
  final String definition;
  final String tapInstruction;
  final List<String> revealInformation;

  factory RevealCard.fromMap(Map<String, dynamic> map) {
    return RevealCard(
      definition: map['definition'],
      tapInstruction: map['tapInstruction'] as String,
      revealInformation: List<String>.from(map['revealInformation']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'definition': definition,
      'tapInstruction': tapInstruction,
      'revealInformation': revealInformation,
    };
  }
}

class IconReveal {
  const IconReveal({
    required this.iconLinks,
    required this.contents,
  });

  final List<String> iconLinks;
  final List<String> contents;

  factory IconReveal.fromMap(Map<String, dynamic> map) {
    return IconReveal(
      iconLinks: List<String>.from(map['iconLinks']),
      contents: List<String>.from(map['contents']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
    required this.question1,
    required this.question2,
    required this.options1,
    required this.options2,
    required this.correctAns1,
    required this.correctAns2,
  });

  final String question1;
  final String question2;
  final String correctAns1;
  final String correctAns2;
  final List<String> options1;
  final List<String> options2;

  factory LearningCheck.fromMap(Map<String, dynamic> map) {
    print("Parsing LearningCheck with data: $map"); // Debug log

    return LearningCheck(
      question1: map["question1"] ?? "Missing question",
      question2: map["question2"] ?? "Missing question",
      options1: List<String>.from(map["options1"] ?? []),
      options2: List<String>.from(map["options2"] ?? []),
      correctAns1:
          map["correctAns1"] ?? "", // Note: Fixed typo from "corectAns1"
      correctAns2:
          map["correctAns2"] ?? "", // Note: Fixed typo from "corectAns2"
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question1': question1,
      'question2': question2,
      'options1': options1,
      'options2': options2,
      'correctAns1': correctAns1, // Fixed typo
      'correctAns2': correctAns2, // Fixed typo
    };
  }
}

class KeyTakeaways {
  const KeyTakeaways({
    required this.takeaway,
  });

  final Map<String, String> takeaway;

  factory KeyTakeaways.fromMap(Map<String, dynamic> map) {
    final takeawayMap = Map<String, String>.from(map['takeaway'] as Map);

    return KeyTakeaways(
      takeaway: takeawayMap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'takeaway': takeaway,
    };
  }
}

class SubComponent {
  const SubComponent({
    required this.type,
    required this.data,
  });

  final SubComponentType type;
  final dynamic data;

  factory SubComponent.fromMap(Map<String, dynamic> map) {
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
        case SubComponentType.multipleChoice:
          print("Parsing MultipleChoice question");
          return SubComponent(
            type: type,
            data: MultipleChoice.fromMap(data),
          );

        case SubComponentType.revealCard:
          print("Parsing RevealCard question");
          return SubComponent(
            type: type,
            data: RevealCard.fromMap(data),
          );

        case SubComponentType.iconReveal:
          print("Parsing IconReveal question");
          return SubComponent(
            type: type,
            data: IconReveal.fromMap(data),
          );

        case SubComponentType.lerningCheck:
          print("Parsing LearningCheck question");
          return SubComponent(
            type: type,
            data: LearningCheck.fromMap(data),
          );

        case SubComponentType.scenario:
          print("Parsing Scenario question");
          return SubComponent(
            type: type,
            data: Scenario.fromMap(data),
          );

        case SubComponentType.keyTakeaways:
          print("Parsing KeyTakeaways question");
          return SubComponent(
            type: type,
            data: KeyTakeaways.fromMap(data),
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
