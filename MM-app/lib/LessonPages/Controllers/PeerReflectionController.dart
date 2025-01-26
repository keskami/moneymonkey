import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/Backend/Services/lessonData.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page1.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page2.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page3.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page4.dart';


class PeerReflectioncontroller  extends GetxController{

   RxInt pageIndex = 0.obs;

   var pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
    
   ];


   var pageData = <int, dynamic>{}.obs;
  final LessonData lessonData = LessonData();
  RxBool isLoading = true.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchPageData();
  }

Future<void> fetchPageData() async {
    try {
      print("Starting to fetch quiz data");
      for (int i = 1; i <= 5; i++) {
        print("Fetching page $i");
        var data = await lessonData.getPageInfoFromFirestore(
          levelName: "Advanced",
          UnitNumber: 1,
          LessonNumber: 1,
          TypeOfLesson: "Quiz",
          PageNumber: i,
        );
        print("Got data for page $i: $data");
        pageData[i] = data;
      }
      print("All quiz data fetched");
    } catch (e) {
      print("Error fetching page data: $e");
    } finally {
      print("Setting isLoading to false");
      isLoading.value = false;
    }
}



}