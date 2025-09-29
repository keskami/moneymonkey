import 'dart:convert';
import 'package:flutter/material.dart';

// Event type enum
enum EventType {
  assignment,
  activity,
  deadline,
  meeting,
  reminder
}

// Extension for EventType to handle string conversion and display values
extension EventTypeExtension on EventType {
  String get value {
    switch (this) {
      case EventType.assignment:
        return 'assignment';
      case EventType.activity:
        return 'activity';
      case EventType.deadline:
        return 'deadline';
      case EventType.meeting:
        return 'meeting';
      case EventType.reminder:
        return 'reminder';
      default:
        return 'assignment';
    }
  }
  
  String get displayName {
    switch (this) {
      case EventType.assignment:
        return 'Assignment';
      case EventType.activity:
        return 'Activity';
      case EventType.deadline:
        return 'Deadline';
      case EventType.meeting:
        return 'Meeting';
      case EventType.reminder:
        return 'Reminder';
      default:
        return 'Assignment';
    }
  }
  
  // Convert string to EventType
  static EventType fromString(String typeString) {
    switch (typeString.toLowerCase()) {
      case 'assignment':
        return EventType.assignment;
      case 'activity':
        return EventType.activity;
      case 'deadline':
        return EventType.deadline;
      case 'meeting':
        return EventType.meeting;
      case 'reminder':
        return EventType.reminder;
      default:
        return EventType.assignment;
    }
  }
}

// Event status enum
enum EventStatus {
  draft,
  visible,
  archived
}

// Extension for EventStatus to handle string conversion and display values
extension EventStatusExtension on EventStatus {
  String get value {
    switch (this) {
      case EventStatus.draft:
        return 'draft';
      case EventStatus.visible:
        return 'visible';
      case EventStatus.archived:
        return 'archived';
      default:
        return 'draft';
    }
  }
  
  String get displayName {
    switch (this) {
      case EventStatus.draft:
        return 'Draft';
      case EventStatus.visible:
        return 'Visible to Students';
      case EventStatus.archived:
        return 'Archived';
      default:
        return 'Draft';
    }
  }
  
  // Convert string to EventStatus
  static EventStatus fromString(String statusString) {
    switch (statusString.toLowerCase()) {
      case 'draft':
        return EventStatus.draft;
      case 'visible':
        return EventStatus.visible;
      case 'archived':
        return EventStatus.archived;
      default:
        return EventStatus.draft;
    }
  }
}

// CalendarEvent class with enum types and simplified attachments
class CalendarEvent {
  final String id;
  final String title;
  final DateTime date;
  final DateTime dueDate;
  final String classId;
  final String className;
  final String description;
  final List<String> attachments; // List of URLs to PDFs, documents, etc.
  final EventStatus status;
  final EventType type;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.dueDate,
    required this.classId,
    required this.className,
    required this.description,
    List<String>? attachments,
    required this.status,
    required this.type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : 
    this.attachments = attachments ?? [],
    this.createdAt = createdAt ?? DateTime.now(),
    this.updatedAt = updatedAt ?? DateTime.now();

  // Factory constructor from Firebase document
  factory CalendarEvent.fromFirestore(Map<String, dynamic> data, String documentId) {
    // Convert attachments from Firebase
    List<String> attachmentsList = [];
    if (data['attachments'] != null) {
      attachmentsList = List<String>.from(data['attachments']);
    }
    
    return CalendarEvent(
      id: documentId,
      title: data['title'] ?? '',
      date: data['date'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(data['date']) 
          : DateTime.now(),
      dueDate: data['dueDate'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(data['dueDate']) 
          : DateTime.now(),
      classId: data['classId'] ?? '',
      className: data['className'] ?? '',
      description: data['description'] ?? '',
      attachments: attachmentsList,
      status: EventStatusExtension.fromString(data['status'] ?? 'draft'),
      type: EventTypeExtension.fromString(data['type'] ?? 'assignment'),
      createdAt: data['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(data['createdAt']) 
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(data['updatedAt']) 
          : DateTime.now(),
    );
  }
  
  // Convert to Map for Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'classId': classId,
      'className': className,
      'description': description,
      'attachments': attachments,
      'status': status.value,
      'type': type.value,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': DateTime.now().millisecondsSinceEpoch, // Always update when saving
    };
  }
  
  // Factory constructor from JSON
  factory CalendarEvent.fromJson(String source) {
    Map<String, dynamic> map = json.decode(source);
    
    List<String> attachmentsList = [];
    if (map['attachments'] != null) {
      attachmentsList = List<String>.from(map['attachments']);
    }
    
    return CalendarEvent(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['date']) 
          : DateTime.now(),
      dueDate: map['dueDate'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate']) 
          : DateTime.now(),
      classId: map['classId'] ?? '',
      className: map['className'] ?? '',
      description: map['description'] ?? '',
      attachments: attachmentsList,
      status: EventStatusExtension.fromString(map['status'] ?? 'draft'),
      type: EventTypeExtension.fromString(map['type'] ?? 'assignment'),
      createdAt: map['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) 
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']) 
          : DateTime.now(),
    );
  }
  
  // Convert to JSON
  String toJson() => json.encode({
    'id': id,
    'title': title,
    'date': date.millisecondsSinceEpoch,
    'dueDate': dueDate.millisecondsSinceEpoch,
    'classId': classId,
    'className': className,
    'description': description,
    'attachments': attachments,
    'status': status.value,
    'type': type.value,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'updatedAt': updatedAt.millisecondsSinceEpoch,
  });

  // Copy constructor for making modifications
  CalendarEvent copy() {
    return CalendarEvent(
      id: id,
      title: title,
      date: date,
      dueDate: dueDate,
      classId: classId,
      className: className,
      description: description,
      attachments: List<String>.from(attachments),
      status: status,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Named constructor with named parameters
  CalendarEvent copyWith({
    String? title,
    DateTime? date,
    DateTime? dueDate,
    String? classId,
    String? className,
    String? description,
    List<String>? attachments,
    EventStatus? status,
    EventType? type,
  }) {
    return CalendarEvent(
      id: id,
      title: title ?? this.title,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      description: description ?? this.description,
      attachments: attachments ?? List<String>.from(this.attachments),
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt,
      updatedAt: DateTime.now(), // Always update when copying
    );
  }
  
  // Helper method to add an attachment
  CalendarEvent addAttachment(String url) {
    List<String> newAttachments = List<String>.from(attachments);
    newAttachments.add(url);
    return copyWith(attachments: newAttachments);
  }
  
  // Helper method to remove an attachment
  CalendarEvent removeAttachment(String url) {
    List<String> newAttachments = List<String>.from(attachments);
    newAttachments.remove(url);
    return copyWith(attachments: newAttachments);
  }
  
  // Helper method to get file extension from URL
  String getFileExtension(String url) {
    try {
      return url.split('.').last.toLowerCase();
    } catch (e) {
      return '';
    }
  }
  
  // Helper method to get file name from URL
  String getFileName(String url) {
    try {
      String fileName = url.split('/').last;
      // Remove any query parameters
      if (fileName.contains('?')) {
        fileName = fileName.split('?').first;
      }
      return fileName;
    } catch (e) {
      return 'file';
    }
  }
  
  // Helper to get icon based on file extension
  IconData getFileIcon(String url) {
    String extension = getFileExtension(url);
    
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image;
      case 'zip':
      case 'rar':
        return Icons.folder_zip;
      default:
        return Icons.insert_drive_file;
    }
  }
}