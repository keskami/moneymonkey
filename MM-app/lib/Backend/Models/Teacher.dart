class Teacher {
  final String name;
  final String id;
  final List<String> classRooms;
  final String profilePictureLink;

  Teacher({
    required this.name,
    required this.id,
    required this.classRooms,
    required this.profilePictureLink,
  });

  factory Teacher.fromFirestore(Map<String, dynamic> data, String id) {
    return Teacher(
      name: data['TeacherName'] ?? '',
      id: id,
      classRooms: List<String>.from(data['classRooms'] ?? []),
      profilePictureLink: data['profilePictureLink'] ?? '',
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      'TeacherName': name,
      'classRooms': classRooms,
      'profilePictureLink': profilePictureLink,
    };
  }
  
  // Helper to convert to JSON for caching
  Map<String, dynamic> toJson() {
    return {
      'TeacherName': name,
      'id': id,
      'classRooms': classRooms,
      'profilePictureLink': profilePictureLink,
    };
  }
  
  // Helper to create from JSON for caching
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      name: json['TeacherName'] ?? '',
      id: json['id'] ?? '',
      classRooms: List<String>.from(json['classRooms'] ?? []),
      profilePictureLink: json['profilePictureLink'] ?? '',
    );
  }
}