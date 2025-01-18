
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLessonTest extends StatefulWidget {
  @override
  _AddLessonTestState createState() => _AddLessonTestState();
}

class _AddLessonTestState extends State<AddLessonTest> {
  Map<String, dynamic> unitData = {};
  Map<String, dynamic> lessonData = {};
  Map<String, dynamic> pageData = {};

  Future<void> addLessonToFirestore(
      {required String levelName,
      required String UnitName,
      required String UnitDescription,
      required String LessonName,
      required String TypeOfLesson,
      //required String LessonDiscption,
      required int UnitNumber,
      required int LessonNumber,
      required Map<String, dynamic> Page1Data}) async {
    try {
      // Reference to Firestore
      final firestore = FirebaseFirestore.instance;

      DocumentReference levelDoc =
          firestore.collection('Levels').doc(levelName);

      CollectionReference unitDataCollection =
          levelDoc.collection('Unit_$UnitNumber');

      QuerySnapshot unitQuerySnapshot = await unitDataCollection.get();

      DocumentReference unitDoc;
      if (unitQuerySnapshot.docs.isNotEmpty) {
        unitDoc = unitQuerySnapshot.docs.first.reference;
      } else {
        unitDoc = unitDataCollection.doc();
        await unitDoc.set({
          'Unit_Name': UnitName,
          'Unit_Number': UnitNumber,
          'Unit_Description': UnitDescription,
        });
      }

      CollectionReference lessonDoc =
          unitDoc.collection("Lesson_$LessonNumber");
      QuerySnapshot lessonQuerySnapshot = await lessonDoc.get();

      DocumentReference lessonDocRef;

      if (lessonQuerySnapshot.docs.isNotEmpty) {
        lessonDocRef = lessonQuerySnapshot.docs.first.reference;
      } else {
        lessonDocRef = lessonDoc.doc();
        await lessonDocRef.set({
          'Lesson_Name': LessonName,
          'Lesson_Description': '',
          'Lesson_Number': LessonNumber,
        });
      }

      CollectionReference LessonTypeDoc = lessonDocRef.collection(TypeOfLesson);
      QuerySnapshot LessonTypeSnap = await LessonTypeDoc.get();
      DocumentReference LessonTypeRef;

      if (LessonTypeSnap.docs.isNotEmpty) {
        LessonTypeRef = LessonTypeSnap.docs.first.reference;
      } else {
        LessonTypeRef = LessonTypeDoc.doc();
        await LessonTypeRef.set({
          "Page1": Page1Data,
        });
      }

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

  Future<Map<String, dynamic>> getLessonInfoFromFirestore(
      {required String levelName,
      required int UnitNumber,
      required int LessonNumber}) async {
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
            unitDoc.reference.collection('Lesson_$LessonNumber');

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

  Future<Map<String, dynamic>> getPageInfoFromFirestore(
      {required String levelName,
      required int UnitNumber,
      required int LessonNumber,
      required String TypeOfLesson, required int PageNumber}) async {
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
            unitDoc.reference.collection('Lesson_$LessonNumber');

        QuerySnapshot lessonQuerySnapshot = await lessonDataCollection.get();

        if (lessonQuerySnapshot.docs.isNotEmpty) {
          DocumentSnapshot lessonDoc = lessonQuerySnapshot.docs.first;

          CollectionReference lessonTypeDataCollection =
              lessonDoc.reference.collection(TypeOfLesson);

          QuerySnapshot lessonTypeQuerySnapshot = await lessonTypeDataCollection.get();

            if (lessonTypeQuerySnapshot.docs.isNotEmpty) {
            DocumentSnapshot lessonTypeDoc = lessonTypeQuerySnapshot.docs.first;

           
            if (lessonTypeDoc.exists) {
              Map<String, dynamic> lessonTypeData = lessonTypeDoc.data() as Map<String, dynamic>;
              if (lessonTypeData.containsKey("Page$PageNumber")) {
              setState(() {
                pageData = lessonTypeData["Page$PageNumber"] as Map<String, dynamic>;
              });
              print(pageData);
              } else {
              print('No page found.');
              }
            } else {
              print('No lesson type document found.');
            }
            } else {
            print('No lesson type found.');
            }


            
            return pageData;
          } else {
            print('No page found.');
            return {};
          }
        } else {
          print('No lesson found.');
          return {};
        }
     
    } catch (e) {
      print('Failed to get page info: $e');
      return {};
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await addLessonToFirestore(
                  levelName: "Advanced",
                  UnitName: "Budgeting Basics",
                  UnitNumber: 1,
                  UnitDescription:
                      'Learn how to create a budget and manage expenses.',
                  LessonNumber: 1,
                  LessonName: "Understanding Income",
                  TypeOfLesson: "Quiz",
                  Page1Data: {
                    "title": "Understanding Income",
                    "subtitle":
                        "Learn the basics of income sources and management"
                  });
              //await getUnitInfoFromFirestore(levelName: 'Advanced', UnitNumber: 1);
              await getLessonInfoFromFirestore(
                  levelName: "Advanced", UnitNumber: 1, LessonNumber: 2);
              await getPageInfoFromFirestore(levelName: "Advanced", UnitNumber: 1, LessonNumber: 1, TypeOfLesson: "Toolkit", PageNumber: 1);
            },
            child: Text("Add data"),
          ),
        ),
        //Text(unitData.toString()),
        Text(lessonData.toString()),
        Text(pageData.toString())
      ],
    ));
  }
}
