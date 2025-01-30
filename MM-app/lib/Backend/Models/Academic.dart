// Enums and Extensions
enum Status {
  inactive,
  inProgress,
  active,
}

enum ComponentType {
  recap,
  concept,
  interactiveActivity,
  story,
  scenarioSimulation,
  peerReflection,
  toolkit,
  quiz,
}

extension ComponentTypeExtension on ComponentType {
  String get name => toString().split('.').last;

  static ComponentType fromString(String str) {
    return ComponentType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => ComponentType.concept,
    );
  }
}

String statusToFirestore(Status status) {
  return status.toString().split('.').last;
}

Status statusFromFirestore(String status) {
  switch (status) {
    case 'inactive':
      return Status.inactive;
    case 'inProgress':
      return Status.inProgress;
    case 'active':
      return Status.active;
    default:
      throw ArgumentError('Invalid status: $status');
  }
}

class Classroom {
  String classId;
  String name;
  String teacherId;
  List<String> studentIds;
  String lessonId;
  String upcomingLessonId;

  Classroom({
    required this.classId,
    required this.name,
    required this.teacherId,
    required this.studentIds,
    required this.lessonId,
    required this.upcomingLessonId,
  });

  factory Classroom.fromFirestore(Map<String, dynamic> data, String id) {
    return Classroom(
      classId: id,
      name: data['Name'] ?? '',
      teacherId: data['TeacherId'] ?? '',
      studentIds: List<String>.from(data['StudentIds'] ?? []),
      lessonId: data['LessonId'] ?? '',
      upcomingLessonId: data['UpcomingLessonId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Name': name,
      'TeacherId': teacherId,
      'StudentIds': studentIds,
      'LessonId': lessonId,
      'UpcomingLessonId': upcomingLessonId,
    };
  }
}

class Unit {
  String unitId;
  String title;
  String description;
  List<String> lessonIds;
  String difficulty;
  Status unitStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Unit({
    required this.unitId,
    required this.title,
    required this.description,
    required this.lessonIds,
    required this.difficulty,
    required this.unitStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Unit.fromFirestore(Map<String, dynamic> data, String id) {
    return Unit(
      unitId: id,
      title: data['Title'] ?? '',
      description: data['Description'] ?? '',
      lessonIds: List<String>.from(data['LessonIds'] ?? []),
      difficulty: data['Difficulty'] ?? '',
      unitStatus: statusFromFirestore(data['UnitStatus'] ?? 'inactive'),
      createdAt: data['CreatedAt']?.toDate(),
      updatedAt: data['UpdatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Title': title,
      'Description': description,
      'LessonIds': lessonIds,
      'Difficulty': difficulty,
      'UnitStatus': statusToFirestore(unitStatus),
      'CreatedAt': createdAt,
      'UpdatedAt': DateTime.now(),
    };
  }
}

class Lesson {
  String lessonId;
  String unitId;
  String title;
  String description;
  Status lessonStatus;
  Map<String, Component> components;
  double progress;
  List<String> discussionQuestions;
  PerformanceTrends performanceTrends;
  DateTime? startedAt;
  DateTime? completedAt;

  Lesson({
    required this.lessonId,
    required this.unitId,
    required this.title,
    required this.description,
    required this.lessonStatus,
    required this.components,
    required this.progress,
    required this.discussionQuestions,
    required this.performanceTrends,
    this.startedAt,
    this.completedAt,
  });

  factory Lesson.fromFirestore(Map<String, dynamic> data, String id) {
    return Lesson(
      lessonId: id,
      unitId: data['UnitId'] ?? '',
      title: data['Title'] ?? '',
      description: data['Description'] ?? '',
      lessonStatus: statusFromFirestore(data['LessonStatus'] ?? 'inactive'),
      progress: (data['Progress'] is num ? data['Progress'] : 0).toDouble(),
      discussionQuestions: List<String>.from(data['DiscussionQuestions'] ?? []),
      components: (data['Components'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, Component.fromFirestore(value, key)),
          ) ??
          {},
      performanceTrends: data['PerformanceTrends'] != null
          ? PerformanceTrends.fromFirestore(data['PerformanceTrends'])
          : PerformanceTrends(
              label: '',
              classAverage: 0,
              participationRate: 0,
              lessonCompletion: 0,
            ),
      startedAt: data['StartedAt']?.toDate(),
      completedAt: data['CompletedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'UnitId': unitId,
      'Title': title,
      'Description': description,
      'LessonStatus': statusToFirestore(lessonStatus),
      'Progress': progress,
      'DiscussionQuestions': discussionQuestions,
      'Components':
          components.map((key, value) => MapEntry(key, value.toFirestore())),
      'PerformanceTrends': performanceTrends.toFirestore(),
      'StartedAt': startedAt,
      'CompletedAt': completedAt,
    };
  }
}

class PerformanceTrends {
  String label;
  double classAverage;
  double participationRate;
  double lessonCompletion;
  DateTime? lastUpdated;

  PerformanceTrends({
    required this.label,
    required this.classAverage,
    required this.participationRate,
    required this.lessonCompletion,
    this.lastUpdated,
  });

  factory PerformanceTrends.fromFirestore(Map<String, dynamic> data) {
    return PerformanceTrends(
      label: data['Label'] ?? '',
      classAverage:
          (data['ClassAverage'] is num ? data['ClassAverage'] : 0).toDouble(),
      participationRate:
          (data['ParticipationRate'] is num ? data['ParticipationRate'] : 0)
              .toDouble(),
      lessonCompletion:
          (data['LessonCompletion'] is num ? data['LessonCompletion'] : 0)
              .toDouble(),
      lastUpdated: data['LastUpdated']?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Label': label,
      'ClassAverage': classAverage,
      'ParticipationRate': participationRate,
      'LessonCompletion': lessonCompletion,
      'LastUpdated': DateTime.now(),
    };
  }
}

class Component {
  String componentId;
  String lessonId;
  String title;
  ComponentType type;
  Status componentStatus;
  double progress;
  List<String>? discussionQuestions;
  Map<String, dynamic>? questionData;

  Component({
    required this.componentId,
    required this.lessonId,
    required this.title,
    required this.type,
    required this.componentStatus,
    this.progress = 0,
    this.discussionQuestions,
    this.questionData,
  });

  factory Component.fromFirestore(Map<String, dynamic> data, String id) {
    return Component(
      componentId: id,
      lessonId: data['LessonId'] ?? '',
      title: data['Title'] ?? '',
      type: ComponentTypeExtension.fromString(data['Type'] ?? ''),
      componentStatus:
          statusFromFirestore(data['ComponentStatus'] ?? 'inactive'),
      progress: (data['Progress'] is num ? data['Progress'] : 0).toDouble(),
      discussionQuestions: data['DiscussionQuestions'] != null
          ? List<String>.from(data['DiscussionQuestions'])
          : null,
      questionData: data['QuestionData'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'LessonId': lessonId,
      'Title': title,
      'Type': type.name,
      'ComponentStatus': statusToFirestore(componentStatus),
      'Progress': progress,
      if (discussionQuestions != null)
        'DiscussionQuestions': discussionQuestions,
      if (questionData != null) 'QuestionData': questionData,
    };
  }
}
