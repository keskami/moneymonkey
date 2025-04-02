import 'package:cloud_firestore/cloud_firestore.dart';

class LessonData {
  Map<String, dynamic> pageData = {};

  //Added her for now

  Future<Map<String, dynamic>> getPageInfoFromFirestore(
      {required String levelName,
      required int UnitNumber,
      required int LessonNumber,
      required String TypeOfLesson,
      required int PageNumber}) async {
    print("FETCH: Starting with parameters:");
    print("FETCH: Level: $levelName");
    print("FETCH: Unit: $UnitNumber");
    print("FETCH: Lesson: $LessonNumber");
    print("FETCH: Type: $TypeOfLesson");
    print("FETCH: Page: $PageNumber");
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
                pageData =
                    lessonTypeData["Page$PageNumber"] as Map<String, dynamic>;
                return pageData;
              } else {
                print('No page found.');
                return pageData;
              }
            } else {
              print('No lesson type document found.');
              return pageData;
            }
          } else {
            print('No lesson type found.');
            return pageData;
          }
        } else {
          print('No page found.');
          return pageData;
        }
      } else {
        print('No lesson found.');
        return pageData;
      }
    } catch (e) {
      print('Failed to get page info: $e');
      return pageData;
    }
  }

  // Future<void> _fetchUserProfile() async {
  //   if (userID != null) {
  //     try {
  //       DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
  //           .collection('Users')
  //           .doc(userID)
  //           .get();

  //       if (profileSnapshot.exists) {
  //         setState(() {
  //           final data = profileSnapshot.data() as Map<String, dynamic>?;

  //           var portfolioData = data?['Portfolio'] as Map<String, dynamic>?;

  //           if (portfolioData != null) {
  //             balance = portfolioData['Balance'] ?? 0;
  //             totalBanans = portfolioData['Total Bananas'] ?? 0;
  //           }

  //           isLoading = false;
  //         });
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     } catch (e) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
  // }
}
