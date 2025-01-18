import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLessonTest extends StatefulWidget {
  @override
  _AddLessonTestState createState() => _AddLessonTestState();
}

class _AddLessonTestState extends State<AddLessonTest> {
  Map<String, dynamic> unitData = {};
  Map<String, dynamic> lessonData = {};

  Future<void> addLessonToFirestore(
      {required String levelName,
      required String UnitName,
      required String UnitDescription,
      required int UnitNumber, required int LessonNumber}) async {
    try {
      // Reference to Firestore
      final firestore = FirebaseFirestore.instance;

      DocumentReference levelDoc =
          firestore.collection('Levels').doc(levelName);

      CollectionReference unitDataCollection =
          levelDoc.collection('Unit_$UnitNumber');

      DocumentReference unitDoc = unitDataCollection.doc();
      await unitDoc.set({
        'Unit_Name': UnitName,
        'Unit_Number': UnitNumber,
        'Unit_Description': UnitDescription,
      });

      CollectionReference lessonDoc = unitDoc.collection("Lesson_$LessonNumber");
      DocumentReference lessonDocRef = lessonDoc.doc();

      await lessonDocRef.set({
        'Lesson_Name': 'Lesson 1',
        'Lesson_Description': 'Introduction to budgeting',
        'Lesson_Number': 1,
      });
      

      print('Lesson added successfully!');
      
    } catch (e) {
      print('Failed to add lesson: $e');
    
    }
  }

  Future<Map<String, dynamic>> getUnitInfoFromFirestore({
    required String levelName,
    required int UnitNumber,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      DocumentReference levelDoc =
          firestore.collection('Levels').doc(levelName);
      CollectionReference unitDataCollection =
          levelDoc.collection('Unit_$UnitNumber');
      QuerySnapshot querySnapshot = await unitDataCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot unitDoc = querySnapshot.docs.first;
        setState(() {
          unitData = unitDoc.data() as Map<String, dynamic>;
        });
        return unitData;
      } else {
        print('No unit found.');
        return {};
      }
    } catch (e) {
      print('Failed to get unit info: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getLessonInfoFromFirestore({
    required String levelName,
    required int UnitNumber,
    required int LessonNumber
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      DocumentReference levelDoc =
          firestore.collection('Levels').doc(levelName);
      CollectionReference unitDataCollection =
          levelDoc.collection('Unit_$UnitNumber');
      QuerySnapshot unitQuerySnapshot = await unitDataCollection.get();

      if (unitQuerySnapshot.docs.isNotEmpty) {
        DocumentSnapshot unitDoc = unitQuerySnapshot.docs.first;
        CollectionReference lessonDataCollection =
        unitDoc.reference.collection('Lessons');
        QuerySnapshot lessonQuerySnapshot = await lessonDataCollection.get();
        if (lessonQuerySnapshot.docs.isNotEmpty) {
          DocumentSnapshot lessonDoc = lessonQuerySnapshot.docs.first;
          setState(() {
        lessonData = lessonDoc.data() as Map<String, dynamic>;
          });
          return lessonData;
        } else {
          print('No lesson found.');
          return {};
        }
      } else {
        print('No unit found.');
        return {};
      }

    } catch (e) {
      print('Failed to get unit info: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 100,),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await addLessonToFirestore(
                levelName: "Advanced",
                UnitName: "Budgeting Basics",
                UnitNumber: 1,
                UnitDescription:
                    'Learn how to create a budget and manage expenses.', LessonNumber: 1,
              );
             await  getUnitInfoFromFirestore(levelName: 'Advanced', UnitNumber: 1);
             await getLessonInfoFromFirestore(levelName: "Adcanced", UnitNumber: 1, LessonNumber: 1);
            },
            child: Text("Add data"),
          ),
        ),
        Text(unitData.toString()),
        Text(lessonData.toString())
      ],
    ));
  }
}
