enum QuestionType {
  multipleChoice,
  revealCard,
  iconReveal,
  knowledgeCheck,
  keyTakeaways,
}

extension QuestionTypeExtension on QuestionType {
  String get name => toString().split('.').last;

  static QuestionType fromString(String name) {
    return QuestionType.values.firstWhere((e) => e.name == name, orElse: () {
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
    required this.options,
    required this.correctAnswers,
    required this.prompts,
  });

  final List<String> correctAnswers;
  final List<String> options;
  final Prompt prompts;

  factory MultipleChoice.fromMap(Map<String, dynamic> map) {
    return MultipleChoice(
      options: List<String>.from(map['options']),
      correctAnswers: List<String>.from(map['correctAnswers']),
      prompts: Prompt.fromMap(map['prompts']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'options': options,
      'correctAnswers': correctAnswers,
      'prompts': prompts.toMap(),
    };
  }
}

class RevealCard {
  const RevealCard({
    required this.tapInstruction,
    required this.revealInformation,
  });

  final String tapInstruction;
  final String revealInformation;

  factory RevealCard.fromMap(Map<String, dynamic> map) {
    return RevealCard(
      tapInstruction: map['tapInstruction'] as String,
      revealInformation: map['revealInformation'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
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

class KeyTakeaways {
  const KeyTakeaways({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  factory KeyTakeaways.fromMap(Map<String, dynamic> map) {
    return KeyTakeaways(
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}

class Question {
  const Question({
    required this.type,
    required this.data,
  });

  final QuestionType type;
  final dynamic data;

  factory Question.fromMap(Map<String, dynamic> map) {
    final type = QuestionTypeExtension.fromString(map['type'] as String);
    final data = map['data'] as Map<String, dynamic>;

    switch (type) {
      case QuestionType.multipleChoice:
        return Question(
          type: type,
          data: MultipleChoice.fromMap(data),
        );
      case QuestionType.revealCard:
        return Question(
          type: type,
          data: RevealCard.fromMap(data),
        );
      case QuestionType.iconReveal:
        return Question(
          type: type,
          data: IconReveal.fromMap(data),
        );
      case QuestionType.keyTakeaways:
        return Question(
          type: type,
          data: KeyTakeaways.fromMap(data),
        );
      default:
        throw Exception("Unsupported question type: ${type.name}");
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'data': data.toMap(),
    };
  }
}
