// File structure for the Firebase model classes and service functions

// Model classes
class Class {
  String classId;
  String teacherId;
  List<String> studentIds;
  String lessonId;
  String upcomingLessonId;

  Class({
    required this.classId,
    required this.teacherId,
    required this.studentIds,
    required this.lessonId,
    required this.upcomingLessonId,
  });

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      classId: map['classId'],
      teacherId: map['teacherId'],
      studentIds: List<String>.from(map['studentIds']),
      lessonId: map['lessonID'],
      upcomingLessonId: map['upcomingLessonId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'teacherId': teacherId,
      'studentIds': studentIds,
      'lessonID': lessonId,
      'upcomingLessonId': upcomingLessonId,
    };
  }
}

class Unit {
  String unitId;
  String title;
  String description;
  List<String> lessonIds;

  Unit({
    required this.unitId,
    required this.title,
    required this.description,
    required this.lessonIds,
  });

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      unitId: map['unitId'],
      title: map['title'],
      description: map['description'],
      lessonIds: List<String>.from(map['lessonIds']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'unitId': unitId,
      'title': title,
      'description': description,
      'lessonIds': lessonIds,
    };
  }
}

class Lesson {
  String lessonId;
  String unitId;
  String title;
  String description;
  Map<String, dynamic> components;
  double progress;

  Lesson({
    required this.lessonId,
    required this.unitId,
    required this.title,
    required this.description,
    required this.components,
    required this.progress,
  });

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      lessonId: map['lessonId'],
      unitId: map['unitId'],
      title: map['title'],
      description: map['description'],
      components: Map<String, dynamic>.from(map['components']),
      progress: map['progress'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'unitId': unitId,
      'title': title,
      'description': description,
      'components': components,
      'progress': progress,
    };
  }
}

class Component {
  String componentId;
  String lessonId;
  String title;
  String type;
  String status;

  Component({
    required this.componentId,
    required this.lessonId,
    required this.title,
    required this.type,
    required this.status,
  });

  factory Component.fromMap(Map<String, dynamic> map) {
    return Component(
      componentId: map['componentId'],
      lessonId: map['lessonId'],
      title: map['title'],
      type: map['type'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'componentId': componentId,
      'lessonId': lessonId,
      'title': title,
      'type': type,
      'status': status,
    };
  }
}

class LessonResource {
  String resourceId;
  String lessonId;
  String title;
  String type;
  String url;

  LessonResource({
    required this.resourceId,
    required this.lessonId,
    required this.title,
    required this.type,
    required this.url,
  });

  factory LessonResource.fromMap(Map<String, dynamic> map) {
    return LessonResource(
      resourceId: map['resourceId'],
      lessonId: map['lessonId'],
      title: map['title'],
      type: map['type'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'resourceId': resourceId,
      'lessonId': lessonId,
      'title': title,
      'type': type,
      'url': url,
    };
  }
}

class Student {
  String studentId;
  String name;
  String email;
  String role;
  List<String> classIds;

  Student({
    required this.studentId,
    required this.name,
    required this.email,
    required this.role,
    required this.classIds,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      studentId: map['userId'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
      classIds: List<String>.from(map['classIds']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': studentId,
      'name': name,
      'email': email,
      'role': role,
      'classIds': classIds,
    };
  }
}

// Firebase Service (For all CRUD operations, refer to previously defined functions)
