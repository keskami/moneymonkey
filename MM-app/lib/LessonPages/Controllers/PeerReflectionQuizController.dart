import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/Backend/Services/auth_service.dart';
import 'package:money_monkey/Backend/Services/lessonData.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page1.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page2.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page3.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page4.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page5.dart';

class PeerReflectionQuizcontroller extends GetxController {
  RxInt pageIndex = 0.obs;

  var pages = [
    PeerReflectionQuizPage1(),
    PeerReflectionQuizPage2(),
    PeerReflectionQuizPage3(),
    PeerReflectionQuizPage4(),
    PeerReflectionQuizPage5(),
  ];

  var pageData = <int, dynamic>{}.obs;
  final LessonData lessonData = LessonData();

  @override
  void onInit() {
    super.onInit();

    fetchPageData();
  }

  Future<void> fetchPageData() async {
    for (int i = 1; i <= 5; i++) {
      var data = await lessonData.getPageInfoFromFirestore(
        levelName: "Advanced",
        UnitNumber: 1,
        LessonNumber: 1,
        TypeOfLesson: "Toolkit",
        PageNumber: i,
      );

      pageData[i] = data;
    }
  }
}
