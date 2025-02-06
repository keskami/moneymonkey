class Teacher {
  final String name;
  final String id;
  final List<String> classRooms;

  Teacher({
    required this.name,
    required this.id,
    required this.classRooms,
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
}
