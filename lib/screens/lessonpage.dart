import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moneymonkey/widgets/custom_app_bar.dart';
import 'package:moneymonkey/widgets/lesson_card.dart';


import '../controller/controller.dart';

 // Import AppRoutes

class LessonPage extends StatelessWidget {
  final ProgressController progressController = Get.put(ProgressController());

  LessonPage({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        appBar: CustomAppBar(progressController: progressController), // Use the custom app bar
        body: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  child: const LessonCard(), // Use the LessonCard widget
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: Colors.white, // White background to match design
  //     elevation: 0, // No shadow
  //     leading: IconButton(
  //       icon: Icon(Icons.close, color: Colors.black),
  //       onPressed: () {
  //         Get.back(); // Close the screen
  //       },
  //     ),
  //     titleSpacing: 0, // Align progress bar with leading icon
  //     title: Row(
  //       children: [
  //         Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.only(right: 12.0),
  //             child: Obx(() => ClipRRect(
  //               borderRadius: BorderRadius.circular(20), // Rounded progress bar
  //               child: LinearProgressIndicator(
  //                 value: progressController.progress.value, // Use progress value
  //                 backgroundColor: Color(0xFFF0F0F0), // Light gray background
  //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
  //                 minHeight: 20, // Set height of progress bar
  //               ),
  //             )),
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Image.asset(
  //               'assets/images/img_monkeymoney_52.png', // Replace with your banana icon path
  //               height: 35,
  //             ),
  //             SizedBox(width: 6), // Space between icon and text
  //             Text(
  //               '3', // Number of bananas
  //               style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

//   Widget _buildLessonCard(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
//       decoration: BoxDecoration(
//         color: Color(0XFFFFFFFF),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0X3F000000),
//             spreadRadius: 2,
//             blurRadius: 2,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(height: 26),
//           Text(
//             "Join “Minty the Money Monkey” on\na one-time fun-filled journey to\nlearn about the exciting world of \nmoney! Minty will help you uncover\nthe basics of what money is, how\nit’s used, and why it’s such a\nvaluable tool in our everyday lives.",
//             maxLines: 7,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               color: Color(0XFF000000),
//               fontSize: 17,
//               fontFamily: 'Baloo 2',
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 6),
//           _buildMonkeyImageWithButton(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildMonkeyImageWithButton(BuildContext context) {
//     return Container(
//       height: 190,
//       width: double.maxFinite,
//       margin: EdgeInsets.only(left: 38, right: 36),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Image.asset(
//             "assets/images/monkeywithcap.png",
//             height: 190,
//             width: double.maxFinite,
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.maxFinite,
//               height: 36,
//               margin: EdgeInsets.only(bottom: 6),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   backgroundColor: Color(0XFF87CEEB),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   visualDensity: const VisualDensity(
//                     vertical: -4,
//                     horizontal: -4,
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
//                 ),
//                 onPressed: () {
//                   progressController.incrementProgress(); // Increment the progress
//                   Get.toNamed(AppRoutes.bankPageRoute); // Navigate to the next page
//                 },
//                 child: Text(
//                   "Done",
//                   style: TextStyle(
//                     color: Color(0XFFFFFFFF),
//                     fontSize: 19,
//                     fontFamily: 'Baloo 2',
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }