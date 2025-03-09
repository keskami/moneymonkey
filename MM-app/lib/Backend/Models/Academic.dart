// Enums and Extensions
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';

enum Status {
  Inactive,
  InProgress,
  Active,
  Completed,
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
  switch (status.toLowerCase()) {
    case 'inactive':
      return Status.Inactive;
    case 'inprogress':
      return Status.InProgress;
    case 'active':
      return Status.Active;
    case 'completed':
      return Status.Completed;
    default:
      throw ArgumentError('Invalid status: $status');
  }
}

// Utility for handling null DateTime values
DateTime? parseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  return null;
}

class Classroom {
  String classId;
  String name;
  String teacherId;
  List<String> studentIds;
  List<String> studentRequests;
  String lessonId;

  Classroom({
    required this.classId,
    required this.name,
    required this.teacherId,
    required this.studentIds,
    required this.studentRequests,
    required this.lessonId,
  });

  factory Classroom.fromFirestore(Map<String, dynamic> data, String id) {
    return Classroom(
      classId: id,
      name: data['Name'] ?? '',
      teacherId: data['TeacherId'] ?? '',
      studentIds: List<String>.from(data['StudentIds'] ?? []),
      studentRequests: List<String>.from(data['StudentRequests'] ?? []),
      lessonId: data['LessonId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Name': name,
      'TeacherId': teacherId,
      'StudentIds': studentIds,
      'StudentRequests': studentRequests,
      'LessonId': lessonId,
    };
  }
  
  // Additional methods for JSON serialization/deserialization
  Map<String, dynamic> toJson() {
    return {
      'classId': classId,
      'name': name,
      'teacherId': teacherId,
      'studentIds': studentIds,
      'studentRequests': studentRequests,
      'lessonId': lessonId,
    };
  }
  
  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      classId: json['classId'] ?? json['id'] ?? '',
      name: json['name'] ?? json['Name'] ?? '',
      teacherId: json['teacherId'] ?? json['TeacherId'] ?? '',
      studentIds: List<String>.from(json['studentIds'] ?? json['StudentIds'] ?? []),
      studentRequests: List<String>.from(json['studentRequests'] ?? json['studentRequests'] ?? []),
      lessonId: json['lessonId'] ?? json['LessonId'] ?? '',
    );
  }
}

class Unit {
  String unitId; //"A.1"
  String title;
  String description;
  List<String> lessonIds;
  Status unitStatus;
  int totalLessons;
  DateTime? createdAt;
  DateTime? updatedAt;

  Unit({
    required this.unitId,
    required this.title,
    required this.description,
    required this.lessonIds,
    required this.unitStatus,
    required this.totalLessons,
    this.createdAt,
    this.updatedAt,
  });

  factory Unit.fromFirestore(Map<String, dynamic> data, String id) {
    return Unit(
      unitId: id,
      title: data['Title'] ?? '',
      description: data['Description'] ?? '',
      lessonIds: List<String>.from(data['LessonIds'] ?? []),
      unitStatus: statusFromFirestore(data['UnitStatus'] ?? 'inactive'),
      totalLessons: data['totalComponents'] ?? 0,
      createdAt: data['CreatedAt']?.toDate(),
      updatedAt: data['UpdatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Title': title,
      'Description': description,
      'LessonIds': lessonIds,
      'UnitStatus': statusToFirestore(unitStatus),
      'CreatedAt': createdAt,
      'totalComponents': totalLessons,
      'UpdatedAt': DateTime.now(),
    };
  }

  String getDifficulty() {
    switch (unitId[0]) {
      case 'A':
        return "Advanced";
      case "I":
        return "Intermediate";
      default:
        return "Beginner";
    }
  }
  
  // Additional methods for JSON serialization/deserialization
  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'title': title,
      'description': description,
      'lessonIds': lessonIds,
      'unitStatus': statusToFirestore(unitStatus),
      'totalLessons': totalLessons,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
  
  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      unitId: json['unitId'] ?? json['id'] ?? '',
      title: json['title'] ?? json['Title'] ?? '',
      description: json['description'] ?? json['Description'] ?? '',
      lessonIds: List<String>.from(json['lessonIds'] ?? json['LessonIds'] ?? []),
      unitStatus: statusFromFirestore(json['unitStatus'] ?? json['UnitStatus'] ?? 'inactive'),
      totalLessons: json['totalLessons'] ?? json['totalComponents'] ?? 0,
      createdAt: parseDateTime(json['createdAt'] ?? json['CreatedAt']),
      updatedAt: parseDateTime(json['updatedAt'] ?? json['UpdatedAt']),
    );
  }
}

class Lesson {
  final String lessonId;
  final String title;
  final String description;
  final Status lessonStatus;
  final List<String> components;
  final double progress;
  final int totalComponents;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final List<String> interactiveActivityLinks;
  final String teachersGuideLink;
  final String studentWorkshopTemplateLinks;

  Lesson({
    required this.lessonId,
    required this.title,
    required this.description,
    required this.lessonStatus,
    required this.components,
    required this.progress,
    required this.totalComponents,
    this.startedAt,
    this.completedAt,
    required this.interactiveActivityLinks,
    required this.teachersGuideLink,
    required this.studentWorkshopTemplateLinks,
  });

  factory Lesson.fromFirestore(Map<String, dynamic> data, String id) {
    return Lesson(
      lessonId: id,
      title: data['Title'] ?? '',
      description: data['Description'] ?? '',
      lessonStatus: statusFromFirestore(data['LessonStatus'] ?? 'inactive'),
      progress: (data['Progress'] is num ? data['Progress'] : 0).toDouble(),
      components: List<String>.from(data['Components'] ?? []),
      totalComponents: int.parse((data['totalComponents'] ?? '0').toString()),
      startedAt: data['StartedAt']?.toDate(),
      completedAt: data['CompletedAt']?.toDate(),
      interactiveActivityLinks: List<String>.from(data['interactiveActivityLinks'] ?? []),
      teachersGuideLink: data['TeachersGuideLink'] ?? '',
      studentWorkshopTemplateLinks: data['StudentWorkshopTemplateLinks'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Title': title,
      'Description': description,
      'LessonStatus': statusToFirestore(lessonStatus),
      'Progress': progress,
      'Components': components,
      'totalComponents': totalComponents,
      'StartedAt': startedAt,
      'CompletedAt': completedAt,
      'interactiveActivityLinks': interactiveActivityLinks,
      'TeachersGuideLink': teachersGuideLink,
      'StudentWorkshopTemplateLinks': studentWorkshopTemplateLinks,
    };
  }
  
  // Additional methods for JSON serialization/deserialization
  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'title': title,
      'description': description,
      'lessonStatus': statusToFirestore(lessonStatus),
      'components': components,
      'progress': progress,
      'totalComponents': totalComponents,
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'interactiveActivityLinks': interactiveActivityLinks,
      'teachersGuideLink': teachersGuideLink,
      'studentWorkshopTemplateLinks': studentWorkshopTemplateLinks,
    };
  }
  
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lessonId'] ?? json['id'] ?? '',
      title: json['title'] ?? json['Title'] ?? '',
      description: json['description'] ?? json['Description'] ?? '',
      lessonStatus: statusFromFirestore(json['lessonStatus'] ?? json['LessonStatus'] ?? 'inactive'),
      progress: (json['progress'] is num ? json['progress'] : (json['Progress'] is num ? json['Progress'] : 0)).toDouble(),
      components: List<String>.from(json['components'] ?? json['Components'] ?? []),
      totalComponents: int.parse((json['totalComponents'] ?? '0').toString()),
      startedAt: parseDateTime(json['startedAt'] ?? json['StartedAt']),
      completedAt: parseDateTime(json['completedAt'] ?? json['CompletedAt']),
      interactiveActivityLinks: List<String>.from(json['interactiveActivityLinks'] ?? []),
      teachersGuideLink: json['teachersGuideLink'] ?? json['TeachersGuideLink'] ?? '',
      studentWorkshopTemplateLinks: json['studentWorkshopTemplateLinks'] ?? json['StudentWorkshopTemplateLinks'] ?? '',
    );
  }
}

class PerformanceTrends {
  double classAverage;
  double participationRate;
  double lessonCompletion;
  DateTime? lastUpdated;

  PerformanceTrends({
    required this.classAverage,
    required this.participationRate,
    required this.lessonCompletion,
    this.lastUpdated,
  });

  factory PerformanceTrends.fromFirestore(Map<String, dynamic> data) {
    return PerformanceTrends(
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
      'ClassAverage': classAverage,
      'ParticipationRate': participationRate,
      'LessonCompletion': lessonCompletion,
      'LastUpdated': DateTime.now(),
    };
  }
  
  // Additional methods for JSON serialization/deserialization
  Map<String, dynamic> toJson() {
    return {
      'classAverage': classAverage,
      'participationRate': participationRate,
      'lessonCompletion': lessonCompletion,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }
  
  factory PerformanceTrends.fromJson(Map<String, dynamic> json) {
    return PerformanceTrends(
      classAverage: (json['classAverage'] is num ? json['classAverage'] : 
                    (json['ClassAverage'] is num ? json['ClassAverage'] : 0)).toDouble(),
      participationRate: (json['participationRate'] is num ? json['participationRate'] : 
                         (json['ParticipationRate'] is num ? json['ParticipationRate'] : 0)).toDouble(),
      lessonCompletion: (json['lessonCompletion'] is num ? json['lessonCompletion'] : 
                        (json['LessonCompletion'] is num ? json['LessonCompletion'] : 0)).toDouble(),
      lastUpdated: parseDateTime(json['lastUpdated'] ?? json['LastUpdated']),
    );
  }
}
class Component {
  String componentId;
  String title;
  ComponentType type;
  Status componentStatus;
  double progress;
  List<String>? discussionQuestions;
  List<SubComponent> questionData;
  final PerformanceTrends performanceTrends;

  Component({
    required this.componentId,
    required this.title,
    required this.type,
    required this.componentStatus,
    this.progress = 0.0,
    this.discussionQuestions,
    required this.questionData,
    required this.performanceTrends,
  });

  factory Component.fromFirestore(Map<String, dynamic> data, String id) {
    return Component(
      componentId: id,
      title: data['Title'] ?? '',
      type: ComponentTypeExtension.fromString(data['Type'] ?? ''),
      componentStatus:
          statusFromFirestore(data['ComponentStatus'] ?? 'inactive'),
      progress: (data['Progress'] is num ? data['Progress'] : 0).toDouble(),
      discussionQuestions: data['DiscussionQuestions'] != null
          ? List<String>.from(data['DiscussionQuestions'])
          : null,
      questionData: data['QuestionData'] != null
          ? (data['QuestionData'] as List)
              .map((q) => SubComponent.fromMap(q as Map<String, dynamic>))
              .toList()
          : [],
      performanceTrends: data['PerformanceTrends'] != null
          ? PerformanceTrends.fromFirestore(data['PerformanceTrends'])
          : PerformanceTrends(
              classAverage: 0,
              participationRate: 0,
              lessonCompletion: 0,
            ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Title': title,
      'Type': type.name,
      'ComponentStatus': statusToFirestore(componentStatus),
      'Progress': progress,
      'PerformanceTrends': performanceTrends.toFirestore(),
      if (discussionQuestions != null)
        'DiscussionQuestions': discussionQuestions,
      'QuestionData': questionData.map((q) => q.toMap()).toList(),
    };
  }
  
  // Additional methods for JSON serialization/deserialization
  Map<String, dynamic> toJson() {
    return {
      'componentId': componentId,
      'title': title,
      'type': type.name,
      'componentStatus': statusToFirestore(componentStatus),
      'progress': progress,
      'discussionQuestions': discussionQuestions,
      'questionData': questionData.map((q) => q.toMap()).toList(),
      'performanceTrends': performanceTrends.toJson(),
    };
  }
  
  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      componentId: json['componentId'] ?? json['id'] ?? '',
      title: json['title'] ?? json['Title'] ?? '',
      type: ComponentTypeExtension.fromString(json['type'] ?? json['Type'] ?? ''),
      componentStatus: statusFromFirestore(json['componentStatus'] ?? json['ComponentStatus'] ?? 'inactive'),
      progress: (json['progress'] is num ? json['progress'] : (json['Progress'] is num ? json['Progress'] : 0)).toDouble(),
      discussionQuestions: json['discussionQuestions'] != null 
          ? List<String>.from(json['discussionQuestions'])
          : (json['DiscussionQuestions'] != null 
              ? List<String>.from(json['DiscussionQuestions']) 
              : null),
      questionData: json['questionData'] != null
          ? (json['questionData'] as List)
              .map((q) => SubComponent.fromMap(q as Map<String, dynamic>))
              .toList()
          : (json['QuestionData'] != null
              ? (json['QuestionData'] as List)
                  .map((q) => SubComponent.fromMap(q as Map<String, dynamic>))
                  .toList()
              : []),
      performanceTrends: json['performanceTrends'] != null
          ? PerformanceTrends.fromJson(json['performanceTrends'])
          : (json['PerformanceTrends'] != null
              ? PerformanceTrends.fromJson(json['PerformanceTrends'])
              : PerformanceTrends(
                  classAverage: 0,
                  participationRate: 0,
                  lessonCompletion: 0,
                )),
    );
  }
}