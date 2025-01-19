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




  
///HERE TO ADD Lesson
  Future<void> addLessonToFirestore(
      {required String levelName,
      required String UnitName,
      required String UnitDescription,
      required String LessonName,
      required String TypeOfLesson,
      //required String LessonDiscption,
      required int UnitNumber,
      required int LessonNumber,
      required Map<String, dynamic> Page1Data,
      required Map<String, dynamic> Page2Data,
      required Map<String, dynamic> Page3Data,
      required Map<String, dynamic> Page4Data,
       required Map<String, dynamic> Page5Data}) async {
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
          "Page2": Page2Data,
          "Page3": Page3Data,
          "Page4": Page4Data,
          "Page5": Page5Data,
        });
      }

      print('Lesson added successfully!');
    } catch (e) {
      print('Failed to add lesson: $e');
    }
  }

  



  Future<Map<String, dynamic>> getPageInfoFromFirestore(
      {required String levelName,
      required int UnitNumber,
      required int LessonNumber,
      required String TypeOfLesson,
      required int PageNumber}) async {
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

          QuerySnapshot lessonTypeQuerySnapshot =
              await lessonTypeDataCollection.get();

          if (lessonTypeQuerySnapshot.docs.isNotEmpty) {
            DocumentSnapshot lessonTypeDoc = lessonTypeQuerySnapshot.docs.first;

            if (lessonTypeDoc.exists) {
              Map<String, dynamic> lessonTypeData =
                  lessonTypeDoc.data() as Map<String, dynamic>;
              if (lessonTypeData.containsKey("Page$PageNumber")) {
                setState(() {
                  pageData =
                      lessonTypeData["Page$PageNumber"] as Map<String, dynamic>;
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


              addLessonToFirestore(
                  levelName: "Advanced",
                  UnitName: "Budgeting Basics",
                  UnitNumber: 1,
                  UnitDescription:
                      'Learn how to create a budget and manage expenses.',
                  LessonNumber: 1,
                  LessonName: "Understanding Income",
                  TypeOfLesson: "Toolkit",
                  Page1Data: {
                    "title":
                        "Welcome to your Toolkit for Lifelong\nFinancial Wellbeing!",
                    "subTitle":
                        "Get ready to plan ahead, save smart, and take responsibility for your finances.",
                  },
                  Page2Data: {
                    "title": "Lifelong Financial Well-Being!",
                    //"subTitle":"Get ready to plan ahead, save smart, and take responsibility for your finances.",
                  },
                  Page3Data: {
                    "title": "Plan Your Financial Future!",
                    "subTitle":
                        "This planner helps you set short- and long-term financial goals. Download it\nand fill it out to start your journey toward financial success.",
                  },
                  Page4Data: {
                    "title": "Your Challenge: Plan and Save!",
                    "point1": "Step 1: Identify one short-term financial goal",
                    "point2": "Step 2: Break it down into smaller steps using the planner",
                    "point3": "Step 3: Get parent approval",
                    "point4": "Earn 50 coins and the 'Goal Setter' badge!"
                  },
                  Page5Data: {});


              //HERE TO ADD QUIZ
              // await addLessonToFirestore(
              //     levelName: "Advanced",
              //     UnitName: "Budgeting Basics",
              //     UnitNumber: 1,
              //     UnitDescription:
              //         'Learn how to create a budget and manage expenses.',
              //     LessonNumber: 1,
              //     LessonName: "Understanding Income",
              //     TypeOfLesson: "Quiz",
              //     Page1Data: {
              //       "question":
              //           "What is a key reason to start saving early in life?",
              //       "answer1": "To buy expensive luxury\nitems immediately",
              //       "answer2": "To build good financial\nhabits over time",
              //       "answer3": "To avoid making a budget",
              //       "answer4": "To spend without worrying about\nthe future",
              //       "correct": '2',
              //     },
              //     Page2Data: {
              //       "question":
              //           "Why is it important to have an emergency fund?",
              //       "answer1": "To cover unexpected expenses",
              //       "answer2": "To buy luxury items",
              //       "answer3": "To invest in risky stocks",
              //       "answer4": "To avoid working a job",
              //       "correct": '1'
              //     },
              //     Page3Data: {
              //       "question":
              //           "Which of the following are good financial\nstrategies? (select all that apply)",
              //       "answer1": "Set aside money for emergencies",
              //       "answer2": "Spend all your income\non entertainment",
              //       "answer3": "Create a budget and stick to it",
              //       "answer4": "Ignore long-term financial goals",
              //       "correct1": '1',
              //       "correct2": '3',
              //     },
              //     Page4Data: {
              //       "question":
              //           "What actions demonstrate financial\nresponsibility? (select all that apply)",
              //       "answer1": "Planning for future expenses",
              //       "answer2": "Setting financial goals",
              //       "answer3": "Spending without tracking\nexpenses",
              //       "answer4": "Regularly contributing to savings",
              //       "correct1": '1',
              //       "correct2": '2',
              //       "correct3": '4',
              //     },
              //      Page5Data: {
              //       "question":
              //           "Match Actions to Catagories",
              //       "subTitle" : "Actions to Categorize:",
              //       "box1": "Short-Term Goals",
              //       "box2": "Medium-Term Goals",
              //       "box3": "Long-Term Goals",
              //       "options":["Saving for Retierment", "Planning for college tutition", "Saving for a concert ticket"],
              //       "correct1": ["Saving for a concert ticket"],
              //       "correct2":  [ "Planning for college tutition",],
              //       "correct3":  ["Saving for Retierment"],
              //     }
                  
                  
              //     );

                  
              //await getUnitInfoFromFirestore(levelName: 'Advanced', UnitNumber: 1);
              //await getLessonInfoFromFirestore(
              //levelName: "Advanced", UnitNumber: 1, LessonNumber: 2);

              await getPageInfoFromFirestore(
                  levelName: "Advanced",
                  UnitNumber: 1,
                  LessonNumber: 1,
                  TypeOfLesson: "Quiz",
                  PageNumber: 1);
            },
            child: Text("Add data"),
          ),
        ),
        //Text(unitData.toString()),
        //Text(lessonData.toString()),
        Text(pageData.toString())
      ],
    ));
  }
}



//Future<Map<String, dynamic>> getLessonInfoFromFirestore(
  //     {required String levelName,
  //     required int UnitNumber,
  //     required int LessonNumber}) async {
  //   try {
  //     final firestore = FirebaseFirestore.instance;
  //     DocumentReference levelDoc =
  //         firestore.collection('Levels').doc(levelName);

  //     CollectionReference unitDataCollection =
  //         levelDoc.collection('Unit_$UnitNumber');

  //     QuerySnapshot unitQuerySnapshot = await unitDataCollection.get();

  //     if (unitQuerySnapshot.docs.isNotEmpty) {
  //       DocumentSnapshot unitDoc = unitQuerySnapshot.docs.first;

  //       CollectionReference lessonDataCollection =
  //           unitDoc.reference.collection('Lesson_$LessonNumber');

  //       QuerySnapshot lessonQuerySnapshot = await lessonDataCollection.get();

  //       if (lessonQuerySnapshot.docs.isNotEmpty) {
  //         DocumentSnapshot lessonDoc = lessonQuerySnapshot.docs.first;
  //         setState(() {
  //           lessonData = lessonDoc.data() as Map<String, dynamic>;
  //         });
  //         return lessonData;
  //       } else {
  //         print('No lesson found.');
  //         return {};
  //       }
  //     } else {
  //       print('No unit found.');
  //       return {};
  //     }
  //   } catch (e) {
  //     print('Failed to get unit info: $e');
  //     return {};
  //   }
  // }

//Future<Map<String, dynamic>> getUnitInfoFromFirestore({
  //   required String levelName,
  //   required int UnitNumber,
  // }) async {
  //   try {
  //     final firestore = FirebaseFirestore.instance;
  //     DocumentReference levelDoc =
  //         firestore.collection('Levels').doc(levelName);
  //     CollectionReference unitDataCollection =
  //         levelDoc.collection('Unit_$UnitNumber');
  //     QuerySnapshot querySnapshot = await unitDataCollection.get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       DocumentSnapshot unitDoc = querySnapshot.docs.first;
  //       setState(() {
  //         unitData = unitDoc.data() as Map<String, dynamic>;
  //       });
  //       return unitData;
  //     } else {
  //       print('No unit found.');
  //       return {};
  //     }
  //   } catch (e) {
  //     print('Failed to get unit info: $e');
  //     return {};
  //   }
  // }