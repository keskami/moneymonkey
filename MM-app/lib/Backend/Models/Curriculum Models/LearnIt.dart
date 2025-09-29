import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents the Learn It component with cards
class LearnIt {
  final String id;
  final List<LearnItCard> cards;
  final bool enableAiHelp;

  LearnIt({
    required this.id,
    required this.cards,
    this.enableAiHelp = true,
  });

  factory LearnIt.fromMap(Map<String, dynamic> data) {
    return LearnIt(
      id: data['id'] ?? '',
      cards: (data['cards'] as List)
          .map((card) => LearnItCard.fromMap(card))
          .toList(),
      enableAiHelp: data['enableAiHelp'] ?? true,
    );
  }

  factory LearnIt.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return LearnIt(
      id: doc.id,
      cards: (data['cards'] as List)
          .map((card) => LearnItCard.fromMap(card))
          .toList(),
      enableAiHelp: data['enableAiHelp'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cards': cards.map((card) => card.toMap()).toList(),
      'enableAiHelp': enableAiHelp,
    };
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }
}

/// Represents an individual card in the Learn It section
class LearnItCard {
  final String title;
  final String content;
  final String imageUrl;

  const LearnItCard({
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  factory LearnItCard.fromMap(Map<String, dynamic> data) {
    return LearnItCard(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
    };
  }
}
