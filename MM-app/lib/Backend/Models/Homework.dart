class Homework {
  final String title;
  final String description;
  final String attachmentURL;
  final String dueDate;
  final String subject;

  const Homework({
    required this.title,
    required this.description,
    required this.attachmentURL,
    required this.dueDate,
    required this.subject,
  });
  
  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      title: json['title'] as String,
      description: json['description'] as String,
      attachmentURL: json['attachmentURL'] as String,
      dueDate: json['dueDate'] as String,
      subject: json['subject'] as String,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'attachmentURL': attachmentURL,
      'dueDate': dueDate,
      'subject': subject,
    };
  }
  
  factory Homework.fromFirestore(Map<String, dynamic> data, [String? id]) {
    return Homework(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      attachmentURL: data['attachmentURL'] ?? '',
      dueDate: data['dueDate'] ?? '',
      subject: data['subject'] ?? '',
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'attachmentURL': attachmentURL,
      'dueDate': dueDate,
      'subject': subject,
    };
  }
}