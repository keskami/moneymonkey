class Classroom {
  final String classId;
  final String teacherId;
  final List<String> studentIds;
  final String lessonId;
  final String upcomingLessonId;

  Classroom({
    required this.classId,
    required this.teacherId,
    required this.studentIds,
    required this.lessonId,
    required this.upcomingLessonId,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      classId: json['classId'],
      teacherId: json['teacherId'],
      studentIds: List<String>.from(json['studentIds']),
      lessonId: json['lessonId'],
      upcomingLessonId: json['upcomingLessonId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classId': classId,
      'teacherId': teacherId,
      'studentIds': studentIds,
      'lessonId': lessonId,
      'upcomingLessonId': upcomingLessonId,
    };
  }
}

class Unit {
  final String unitId;
  final String title;
  final String description;
  final List<String> lessonIds;

  Unit({
    required this.unitId,
    required this.title,
    required this.description,
    required this.lessonIds,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      unitId: json['unitId'],
      title: json['title'],
      description: json['description'],
      lessonIds: List<String>.from(json['lessonIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'title': title,
      'description': description,
      'lessonIds': lessonIds,
    };
  }
}

class Lesson {
  final String lessonId;
  final String unitId;
  final String title;
  final String description;
  final Map<String, Component> components;
  final double progress;

  Lesson({
    required this.lessonId,
    required this.unitId,
    required this.title,
    required this.description,
    required this.components,
    required this.progress,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lessonId'],
      unitId: json['unitId'],
      title: json['title'],
      description: json['description'],
      components: (json['components'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, Component.fromJson(value))),
      progress: json['progress'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'unitId': unitId,
      'title': title,
      'description': description,
      'components':
          components.map((key, value) => MapEntry(key, value.toJson())),
      'progress': progress,
    };
  }
}

class Component {
  final String componentId;
  final String lessonId;
  final String title;
  final String type;
  final String status;

  Component({
    required this.componentId,
    required this.lessonId,
    required this.title,
    required this.type,
    required this.status,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      componentId: json['componentId'],
      lessonId: json['lessonId'],
      title: json['title'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
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
  final String resourceId;
  final String lessonId;
  final String title;
  final String type;
  final String url;

  LessonResource({
    required this.resourceId,
    required this.lessonId,
    required this.title,
    required this.type,
    required this.url,
  });

  factory LessonResource.fromJson(Map<String, dynamic> json) {
    return LessonResource(
      resourceId: json['resourceId'],
      lessonId: json['lessonId'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resourceId': resourceId,
      'lessonId': lessonId,
      'title': title,
      'type': type,
      'url': url,
    };
  }
}

class User {
  final String userId;
  final String name;
  final String email;
  final String role;
  final List<String> classIds;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.classIds,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      classIds: List<String>.from(json['classIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'classIds': classIds,
    };
  }
}
