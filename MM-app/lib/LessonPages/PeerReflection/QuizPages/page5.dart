import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionQuizController.dart';
import 'package:money_monkey/home.dart';

class PeerReflectionQuizPage5 extends StatefulWidget {
  @override
  _PeerReflectionQuizPage5State createState() =>
      _PeerReflectionQuizPage5State();
}

class _PeerReflectionQuizPage5State extends State<PeerReflectionQuizPage5> {
  PeerReflectionQuizcontroller peerReflectionQuizcontroller = Get.find();
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  bool firstTime = true;
  bool correct = false;
  List<String> availableItems = [
    'Saving for retirement',
    'Planning for college tuition',
    'Saving for a concert ticket'
  ];
  List<String> droppedItems1 = [];
  List<String> droppedItems2 = [];
  List<String> droppedItems3 = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double WebscreenWidthUnit = screenWidth / 1920;
    double WebscreenHeightUnit = screenHeight / 980;

    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    return Column(
      children: [
        SizedBox(height: screenHeight * .05),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 475, 0, 0, 0),
              child: Text(
                'Match Actions to Categories',
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 6.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              )),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  WebscreenWidthUnit * 475, WebscreenHeightUnit * 26, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildDropZone(
                      droppedItems1,
                      'Short-Term Goal:',
                      WebscreenWidthUnit,
                      WebscreenHeightUnit,
                      (item) => droppedItems2.remove(item),
                      (item) => droppedItems3.remove(item)),
                  SizedBox(width: WebscreenWidthUnit * 16),
                  _buildDropZone(
                      droppedItems2,
                      'Medium-Term Goal:',
                      WebscreenWidthUnit,
                      WebscreenHeightUnit,
                      (item) => droppedItems1.remove(item),
                      (item) => droppedItems3.remove(item)),
                  SizedBox(width: WebscreenWidthUnit * 16),
                  _buildDropZone(
                      droppedItems3,
                      'Long-Term Goal:',
                      WebscreenWidthUnit,
                      WebscreenHeightUnit,
                      (item) => droppedItems1.remove(item),
                      (item) => droppedItems2.remove(item)),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                WebscreenWidthUnit * 475, WebscreenHeightUnit * 25, 0, 0),
            child: Text(
              'Actions to Categorize:',
              style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 5,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          height: screenHeightUnit * 112,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                WebscreenWidthUnit * 475,
                0,
                0,
                0,
              ),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate((availableItems.length / 4).ceil(),
                      (index) {
                    int start = index * 4;
                    int end = (index * 4 + 4) > availableItems.length
                        ? availableItems.length
                        : (index * 4 + 4);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: availableItems.sublist(start, end).map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: _buildDraggableItem(item),
                        );
                      }).toList(),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: WebscreenHeightUnit * 0),
          child: GestureDetector(
              onTap: () {
                if (droppedItems1.contains("Saving for a concert ticket") &&
                    droppedItems2.contains("Planning for college tuition") &&
                    droppedItems3.contains("Saving for retirement")) {
                  peerReflectionQuizcontroller.pageIndex += 1;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Please categorize all the items correctly to continue'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              child: Container(
                height: screenHeightUnit * 58,
                width: screenWidthUnit * 61,
                decoration: BoxDecoration(
                  color:
                      (droppedItems1.contains("Saving for a concert ticket") &&
                              droppedItems2
                                  .contains("Planning for college tuition") &&
                              droppedItems3.contains("Saving for retirement"))
                          ? Color.fromRGBO(137, 220, 142, 1)
                          : Color.fromRGBO(224, 227, 231, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Continue",
                    style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 4.2,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )),
        )
      ],
    );
  }

  Widget _buildDropZone(
      List<String> droppedItems,
      String label,
      double WebscreenWidthUnit,
      double WebscreenHeightUnit,
      Function(String) onItemDropped,
      Function(String) onItemDropped2) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          droppedItems.add(data);
          onItemDropped(data);
          onItemDropped2(data);
          availableItems.remove(data);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: WebscreenWidthUnit * 315,
          height: WebscreenHeightUnit * 428,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.baloo2(
                  fontSize: WebscreenWidthUnit * 25.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              ...droppedItems.map(
                (item) => _buildDraggableDroppedItem(
                  item,
                  droppedItems,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildDraggableDroppedItem(String label, List<String> sourceList) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        color: Colors.transparent,
        child: _buildDroppedItem(label),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildDroppedItem(label),
      ),
      onDragCompleted: () {
        setState(() {
          sourceList.remove(label);
        });
      },
      child: _buildDroppedItem(label),
    );
  }

  Widget _buildDraggableItem(String label) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        color: Colors.transparent,
        child: _buildDroppedItem(label),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildDroppedItem(label),
      ),
      child: _buildDroppedItem(label),
    );
  }

  Widget _buildDroppedItem(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(label, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}

Widget topOfLesson({
  required double screenWidthUnit,
  required double screenHeightUnit,
  required double pageNumber,
  required double totalPages,
  required BuildContext context,
  required int bananas,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.close, color: Colors.black)),
      TweenAnimationBuilder<double>(
        tween: Tween<double>(
            begin: (pageNumber - 1) / totalPages, end: pageNumber / totalPages),
        duration: Duration(seconds: 2),
        builder: (context, value, child) {
          return Container(
            height: screenHeightUnit * 25,
            width: screenWidthUnit * 202,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(135, 206, 235, 1),
                  Color.fromRGBO(213, 213, 213, 1),
                ],
                stops: [value, value],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          );
        },
      ),
      SizedBox(
        width: screenWidthUnit * 4,
      ),
      Image.asset("assets/images/img_monkeymoney_52.png",
          height: screenHeightUnit * 36),
      SizedBox(
        width: screenWidthUnit * 1,
      ),
      Text("$bananas",
          style: GoogleFonts.roboto(
              fontSize: screenWidthUnit * 5.5, color: Colors.black)),
    ],
  );
}
