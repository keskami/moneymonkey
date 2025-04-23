// custom_polygon_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Widgets/LessonHome/treasure_widget.dart';
import 'package:money_monkey/LessonPages/Widgets/PolygonAvatar.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomPolygonRow extends StatelessWidget {
  const CustomPolygonRow({
    super.key,
    required this.index,
    required this.isActivated,
    required this.width,
    required this.imageLinks,
    required this.pagesLink,
  });

  final double width;
  final int index;
  final bool isActivated;
  final List<String> imageLinks;
  final List<Widget> pagesLink;

  @override
  Widget build(BuildContext context) {
    if (index == 1 || index == 2 || index == 5 || index == 6) {}
    Widget lessonPolygonStack = Stack();
    switch (index) {
      case 0:
        lessonPolygonStack = middleRow(context);
        break;
      case 1:
        lessonPolygonStack = leftRow(context);
        break;
      case 2:
        lessonPolygonStack = middleRow(context);
        break;
      case 3:
        lessonPolygonStack = rightRow(context);
        break;
      case 4:
        lessonPolygonStack = middleRow(context);
        break;
      case 5:
        lessonPolygonStack = leftRow(context);
        break;
      case 6:
        lessonPolygonStack = middleRow(context, isTreasure: true);
        break;
      default:
        lessonPolygonStack = middleRow(context);
    }

    return Stack(
      children: [
        lessonPolygonStack.marginSymmetric(
          horizontal: width * 0.5,
        ),
      ],
    );
  }

  Widget leftRow(BuildContext context) {
    return Row(
      children: [
        CustomPopup(
          content: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
              vertical: width * 0.05,
            ),
            width: width * 4,
            height: width * 2,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Financial Responsibility",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lesson ${index + 1} of 7",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (index < pagesLink.length) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pagesLink[index],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("This lesson content is not available")),
                        );
                      }
                    },
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      backgroundColor: LightTheme().primaryBlue,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rewards:",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    //Monkey Question Mark
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.25,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                      ),
                    ),
                    const Spacer(),
                    //LessonBananaWorth Image
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.3,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                      ),
                      child: Text(
                        "10",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
          child: LessonPolygon(
            backgroundColor: Colors.grey.shade400,
            icon: Icon(
              Icons.lock,
            ),
            isActivated: isActivated,
            width: width,
            index: index,
            imageLinks: imageLinks,
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     showAlignedDialog(
        //       context: context,
        //       builder: (context) => CustomPopup(
        //         content: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: List.generate(5, (index) => Text('menu$index')),
        //         ),
        //         child: const Icon(Icons.add_circle_outline),
        //       ),
        //     ); // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(
        //     //     builder: (context) {
        //     //       return pagesLink[index];
        //     //     },
        //     //   ),
        //     // );
        //   },
        // ),
        const Spacer(),
      ],
    );
  }

  Widget rightRow(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        CustomPopup(
          content: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
              vertical: width * 0.05,
            ),
            width: width * 4,
            height: width * 2,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Financial Responsibility",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lesson ${index + 1} of 7",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (index < pagesLink.length) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pagesLink[index],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("This lesson content is not available")),
                        );
                      }
                    },
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      backgroundColor: LightTheme().primaryBlue,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rewards:",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    //Monkey Question Mark
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.25,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                      ),
                    ),
                    const Spacer(),
                    //LessonBananaWorth Image
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.3,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                      ),
                      child: Text(
                        "10",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
          child: LessonPolygon(
            backgroundColor: Colors.grey.shade400,
            icon: Icon(
              Icons.lock,
            ),
            isActivated: isActivated,
            width: width,
            index: index,
            imageLinks: imageLinks,
          ),
        ),
      ],
    );
  }

  Widget middleRow(BuildContext context, {bool isTreasure = false}) {
    return Row(
      children: [
        const Spacer(),
        // If this is the treasure index (index 6), use TreasureWidget instead of the normal LessonPolygon
        if (isTreasure)
          CustomPopup(
            content: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: width * 0.05,
              ),
              width: width * 4,
              height: width * 2,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Congratulations!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Lesson Complete",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Claim treasure action
                      },
                      child: Text(
                        "Claim Reward",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        backgroundColor: Colors.amber.shade700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Special Reward:",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: width * 0.3,
                        backgroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                        ),
                        child: Text(
                          "50",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ),
            child: TreasureWidget(width: width, isActivated: isActivated),
          )
        else
          CustomPopup(
            content: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: width * 0.05,
              ),
              width: width * 4,
              height: width * 2,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Financial Responsibility",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Lesson ${index + 1} of 7",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (index < pagesLink.length) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => pagesLink[index],
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("This lesson content is not available")),
                          );
                        }
                      },
                      child: Text(
                        "Start",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        backgroundColor: LightTheme().primaryBlue,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rewards:",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      //Monkey Question Mark
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: width * 0.25,
                        backgroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                        ),
                      ),
                      const Spacer(),
                      //LessonBananaWorth Image
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: width * 0.3,
                        backgroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                        ),
                        child: Text(
                          "10",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ),
            child: LessonPolygon(
              backgroundColor: Colors.grey.shade400,
              icon: Icon(
                Icons.lock,
              ),
              isActivated: isActivated,
              width: width,
              index: index,
              imageLinks: imageLinks,
            ),
          ),
        const Spacer(),
      ],
    );
  }
}