import 'package:money_monkey/Backend/Models/Academic.dart';

class Teacher {
  final String name;
  final String id;
  final List<Classroom>? classRooms;

  Teacher({
    required this.name,
    required this.id,
    this.classRooms,
  });

  factory Teacher.fromFirestore(Map<String, dynamic> data, String id) {
    return Teacher(
      name: data['TeacherName'],
      id: id,
      classRooms: data['classRooms'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'TeacherName': name,
      'id': id,
      'classRooms': classRooms,
    };
  }

  Map<String, String> getClasses() {
    Map<String, String> tempClasses = {};
    tempClasses.addAll(
      Map.fromEntries(
        classRooms?.map(
              (classRoom) => MapEntry(
                classRoom.classId,
                classRoom.name,
              ),
            ) ??
            [],
      ),
    );
    return tempClasses;
  }
}
