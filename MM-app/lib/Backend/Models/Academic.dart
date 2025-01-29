enum Status {
  inactive,
  inProgress,
  active,
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
  PerformanceTrends performanceData;

  Classroom({
    required this.classId,
    required this.name,
    required this.teacherId,
    required this.studentIds,
    required this.lessonId,
    required this.upcomingLessonId,
    required this.performanceData,
  });

  factory Classroom.fromFirestore(Map<String, dynamic> data, String id) {
    return Classroom(
      classId: id,
      name: data['Name'],
      teacherId: data['TeacherId'] ?? '',
      studentIds: List<String>.from(data['StudentIds'] ?? []),
      lessonId: data['LessonId'] ?? '',
      upcomingLessonId: data['UpcomingLessonId'] ?? '',
      performanceData:
          PerformanceTrends.fromFirestore(data['PerformanceData'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Name': name,
      'TeacherId': teacherId,
      'StudentIds': studentIds,
      'LessonId': lessonId,
      'UpcomingLessonId': upcomingLessonId,
      'PerformanceData': performanceData.toFirestore(),
    };
  }
}

class PerformanceTrends {
  String label;
  double classAverage;
  double participationRate;
  double lessonCompletion;

  PerformanceTrends({
    required this.label,
    required this.classAverage,
    required this.participationRate,
    required this.lessonCompletion,
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
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Label': label,
      'ClassAverage': classAverage,
      'ParticipationRate': participationRate,
      'LessonCompletion': lessonCompletion,
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

  Unit({
    required this.unitId,
    required this.title,
    required this.description,
    required this.lessonIds,
    required this.difficulty,
    required this.unitStatus,
  });

  factory Unit.fromFirestore(Map<String, dynamic> data, String id) {
    return Unit(
      unitId: id,
      title: data['Title'] ?? '',
      description: data['Description'] ?? '',
      lessonIds: List<String>.from(data['LessonIds'] ?? []),
      difficulty: data['Difficulty'] ?? '',
      unitStatus: statusFromFirestore(data['unitStatus'] ?? 'inactive'),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Title': title,
      'Description': description,
      'LessonIds': lessonIds,
      'Difficulty': difficulty,
      'unitStatus': statusToFirestore(unitStatus),
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

  Lesson({
    required this.lessonId,
    required this.unitId,
    required this.title,
    required this.description,
    required this.lessonStatus,
    required this.components,
    required this.progress,
    required this.discussionQuestions,
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
    };
  }
}

class Component {
  String componentId;
  String lessonId;
  String title;
  String type;
  Status componentStatus;

  Component({
    required this.componentId,
    required this.lessonId,
    required this.title,
    required this.type,
    required this.componentStatus,
  });

  factory Component.fromFirestore(Map<String, dynamic> data, String id) {
    return Component(
      componentId: id,
      lessonId: data['LessonId'] ?? '',
      title: data['Title'] ?? '',
      type: data['Type'] ?? '',
      componentStatus:
          statusFromFirestore(data['ComponentStatus'] ?? 'inactive'),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'LessonId': lessonId,
      'Title': title,
      'Type': type,
      'ComponentStatus': statusToFirestore(componentStatus),
    };
  }
}
