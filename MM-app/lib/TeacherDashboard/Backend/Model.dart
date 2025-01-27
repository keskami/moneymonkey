// firebase_performance_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class PerformanceData {
  final String label;
  final double classAverage;
  final double participationRate;
  final double lessonCompletion;

  PerformanceData({
    required this.label,
    required this.classAverage,
    required this.participationRate,
    required this.lessonCompletion,
  });

  factory PerformanceData.fromMap(Map<String, dynamic> map) {
    return PerformanceData(
      label: map['title'] ?? '',
      classAverage: map['classAverage']?.toDouble() ?? 0.0,
      participationRate: map['participationRate']?.toDouble() ?? 0.0,
      lessonCompletion: map['completionRate']?.toDouble() ?? 0.0,
    );
  }
}

class FirebasePerformanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PerformanceData>> getLessonPerformanceData(
      String classId, String lessonId) async {
    try {
      // Get the lesson details
      final lessonDoc =
          await _firestore.collection('lessons').doc(lessonId).get();
      final components =
          lessonDoc.data()?['components'] as Map<String, dynamic>? ?? {};

      List<PerformanceData> performanceDataList = [];

      // For each component, calculate the performance metrics
      for (var componentEntry in components.entries) {
        final componentId = componentEntry.key;
        final component = componentEntry.value as Map<String, dynamic>;

        // Get all student progress for this component
        final studentsSnapshot = await _firestore
            .collection('classes')
            .doc(classId)
            .collection('studentProgress')
            .where('componentId', isEqualTo: componentId)
            .get();

        // Calculate metrics
        double totalScore = 0;
        double participatingStudents = 0;
        double completedStudents = 0;
        int totalStudents = studentsSnapshot.docs.length;

        for (var doc in studentsSnapshot.docs) {
          var data = doc.data();
          if (data['score'] != null) {
            totalScore += data['score'];
            participatingStudents++;
          }
          if (data['status'] == 'completed') {
            completedStudents++;
          }
        }

        // Create performance data for this component
        performanceDataList.add(PerformanceData(
          label: component['title'] ?? '',
          classAverage: totalStudents > 0 ? (totalScore / totalStudents) : 0,
          participationRate: totalStudents > 0
              ? (participatingStudents / totalStudents) * 100
              : 0,
          lessonCompletion:
              totalStudents > 0 ? (completedStudents / totalStudents) * 100 : 0,
        ));
      }

      return performanceDataList;
    } catch (e) {
      print('Error getting performance data: $e');
      return [];
    }
  }

  Stream<List<PerformanceData>> streamLessonPerformance(
      String classId, String lessonId) {
    // Create a stream that combines multiple component updates
    return _firestore
        .collection('classes')
        .doc(classId)
        .collection('studentProgress')
        .snapshots()
        .asyncMap((_) => getLessonPerformanceData(classId, lessonId));
  }

  Future<void> updateComponentProgress(
    String classId,
    String lessonId,
    String componentId,
    String studentId,
    double score,
    String status,
  ) async {
    try {
      await _firestore
          .collection('classes')
          .doc(classId)
          .collection('studentProgress')
          .doc('${studentId}_${componentId}')
          .set({
        'componentId': componentId,
        'lessonId': lessonId,
        'studentId': studentId,
        'score': score,
        'status': status,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating component progress: $e');
      rethrow;
    }
  }
}

// Example usage in a widget:

// class PerformanceWidget extends StatelessWidget {
//   final String classId;
//   final String lessonId;
//   final FirebasePerformanceService _performanceService =
//       FirebasePerformanceService();

//   PerformanceWidget({
//     Key? key,
//     required this.classId,
//     required this.lessonId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<PerformanceData>>(
//       stream: _performanceService.streamLessonPerformance(classId, lessonId),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }

//         final performanceData = snapshot.data ?? [];

//         return PerformanceTrendsChart(data: performanceData);
//       },
//     );
//   }
// }
