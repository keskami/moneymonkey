import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/Backend/Services/lessonData.dart';
import 'package:money_monkey/LessonPages/Toolkit/page5.dart';
import 'package:money_monkey/LessonPages/Toolkit/page6.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ResourcesDownloaderPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ChallengePage.dart';

class Toolkitcontroller extends GetxController {
  RxInt pageIndex = 0.obs;

  var pages = [
    Page5(),
    Page6(),
    ResourcesDownloaderPage(),
    ChallengePage(),
  ];

  var pageData = <int, dynamic>{}.obs;
  final LessonData lessonData = LessonData();

  @override
  void onInit() {
    super.onInit();
    fetchPageData();
  }
  RxBool isLoading = true.obs;

  Future<void> fetchPageData() async {
    try {
      for (int i = 1; i <= 4; i++) {
        var data = await lessonData.getPageInfoFromFirestore(
          levelName: "Advanced",
          UnitNumber: 1,
          LessonNumber: 1,
          TypeOfLesson: "Toolkit",
          PageNumber: i,
        );

        pageData[i] = data;
      }
    } catch (e) {
      print("Error fetching page data: $e");
    } finally {
      isLoading.value = false;
      
    }
  }
}
