import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/home.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  PeerReflectioncontroller peerReflectionController = Get.find();

  List<String> availableItems = [];

  List<String> correct1 = [];
  List<String> correct2 = [];
  List<String> correct3 = [];
  List<String> droppedItems1 = [];
  List<String> droppedItems2 = [];
  List<String> droppedItems3 = [];
  bool loading = false;
  String question = '';
  String box1 = '';
  String box2 = '';
  String box3 = '';
  String subTitle = '';

  Future<void> setData(data) async {
    setState(() {
      question = data["question"];
      box1 = data["box1"];
      box2 = data["box2"];
      box3 = data["box3"];
      availableItems =
          List<String>.from(data["options"].map((item) => item.toString()));
      correct1 =
          List<String>.from(data["correct1"].map((item) => item.toString()));
      correct2 =
          List<String>.from(data["correct2"].map((item) => item.toString()));
      correct3 =
          List<String>.from(data["correct3"].map((item) => item.toString()));
      subTitle = data["subTitle"];

      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    setData(peerReflectionController.pageData[3]);
  }

  Future<void> noLeak(data) async {
    if (!availableItems.contains(data) &&
        !droppedItems1.contains(data) &&
        !droppedItems2.contains(data) &&
        !droppedItems3.contains(data)) {
      setState(() {
        availableItems.add(data);
      });
    }
  }

  Future<void> _checkCompletion() async {
    if (droppedItems1.length == correct1.length &&
        droppedItems1.every((element) => correct1.contains(element)) &&
        droppedItems2.length == correct2.length &&
        droppedItems2.every((element) => correct2.contains(element)) &&
        droppedItems3.length == correct3.length &&
        droppedItems3.every((element) => correct3.contains(element))) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(CorrectAnswerSnackBar(message: ""));
      await Future.delayed(Duration(seconds: 2));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      peerReflectionController.pageIndex.value += 1;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(WrongAnswerSnackBar(message: ""));
    }
  }

  Future<void> _fetchUserProfile() async {
    if (userID != null) {
      try {
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userID)
            .get();

        if (profileSnapshot.exists) {
          setState(() {
            final data = profileSnapshot.data() as Map<String, dynamic>?;

            var portfolioData = data?['Portfolio'] as Map<String, dynamic>?;

            if (portfolioData != null) {
              balance = portfolioData['Balance'] ?? 0;
              totalBanans = portfolioData['Total Bananas'] ?? 0;
            }

            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;
    double WebscreenWidthUnit = screenWidth / 1920;
    double WebscreenHeightUnit = screenHeight / 1080;

    return loading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              SizedBox(height: screenHeight * .05),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(WebscreenWidthUnit * 475, 0, 0, 0),
                    child: Text(
                      question,
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
                    padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 475,
                        WebscreenHeightUnit * 26, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildDropZone(
                            droppedItems1,
                            box1,
                            WebscreenWidthUnit,
                            WebscreenHeightUnit,
                            (item) => droppedItems2.remove(item),
                            (item) => droppedItems3.remove(item),
                            droppedItems1,
                            droppedItems2,
                            droppedItems3,
                            correct1),
                        SizedBox(width: WebscreenWidthUnit * 16),
                        _buildDropZone(
                            droppedItems2,
                            box2,
                            WebscreenWidthUnit,
                            WebscreenHeightUnit,
                            (item) => droppedItems1.remove(item),
                            (item) => droppedItems3.remove(item),
                            droppedItems1,
                            droppedItems2,
                            droppedItems3,
                            correct2),
                        SizedBox(width: WebscreenWidthUnit * 16),
                        _buildDropZone(
                            droppedItems3,
                            box3,
                            WebscreenWidthUnit,
                            WebscreenHeightUnit,
                            (item) => droppedItems1.remove(item),
                            (item) => droppedItems2.remove(item),
                            droppedItems1,
                            droppedItems2,
                            droppedItems3,
                            correct3),
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
                    subTitle,
                    style: GoogleFonts.baloo2(
                      fontSize: screenWidthUnit * 5,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeightUnit * 152,
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
                        children: List.generate(
                            (availableItems.length / 4).ceil(), (index) {
                          int start = index * 4;
                          int end = (index * 4 + 4) > availableItems.length
                              ? availableItems.length
                              : (index * 4 + 4);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                                availableItems.sublist(start, end).map((item) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
              /*
        Padding(
          padding: EdgeInsets.only(top: WebscreenHeightUnit * 0),
          child: GestureDetector(
              onTap: () {
          if (droppedItems1.contains("Flexible budgeting") &&
              droppedItems1.contains("Travel savings") &&
              droppedItems1.contains("Emergency fund") &&
              droppedItems1.contains("Starting retirement fund") &&
              droppedItems2.contains("Budgeting for family needs") &&
              droppedItems2.contains("Kids’ education savings") &&
              droppedItems3.contains("Personal investments") &&
              droppedItems3.contains("Planning for grad school")) {
            print(peerReflectionController.pageIndex.value);
            peerReflectionController.pageIndex.value += 1;
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
            color: (droppedItems1.contains("Flexible budgeting") &&
              droppedItems1.contains("Travel savings") &&
              droppedItems1.contains("Emergency fund") &&
              droppedItems1.contains("Starting retirement fund") &&
              droppedItems2
                  .contains("Budgeting for family needs") &&
              droppedItems2.contains("Kids’ education savings") &&
              droppedItems3.contains("Personal investments") &&
              droppedItems3.contains("Planning for grad school"))
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
              "Continue to Activity",
              style: GoogleFonts.baloo2(
            fontSize: screenWidthUnit * 4.2,
            color: Colors.white,
            fontWeight: FontWeight.w700),
            ),
          ),
              )),
        )
        */
            ],
          );
  }

  Widget _buildDropZone(
    List<String> droppedItems,
    String label,
    double WebscreenWidthUnit,
    double WebscreenHeightUnit,
    Function(String) onItemDropped,
    Function(String) onItemDropped2,
    List<String> droppedItems1,
    List<String> droppedItems2,
    List<String> droppedItems3,
    List<String> correctItems,
  ) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          droppedItems.add(data);
          onItemDropped(data);
          onItemDropped2(data);
          availableItems.remove(data);
          noLeak(data);
        });

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (availableItems.isEmpty) {
          //ScaffoldMessenger.of(context)
          //.showSnackBar(CorrectAnswerSnackBar(message: ""));
          _checkCompletion();
        } else {
          //ScaffoldMessenger.of(context)
          //.showSnackBar(WrongAnswerSnackBar(message: ''));
        }
      },
      onWillAccept: (data) => true,
      onLeave: (data) {
        setState(() {
          if (data != null && droppedItems.contains(data)) {
            droppedItems.remove(data);

            // Add back to available items
          }
          if (droppedItems1.contains(data) ||
              droppedItems2.contains(data) ||
              droppedItems3.contains(data)) {
            if (availableItems.contains(data)) {
              setState(() {
                availableItems.remove(data);
                noLeak(data);
              });
            } else {
              setState(() {});
            }
          } else {
            setState(() {
              if (!availableItems.contains(data)) {
                availableItems.add(data!);
                noLeak(data);
              }
            });
          }
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
              Padding(
                padding: EdgeInsets.only(left: WebscreenWidthUnit * 10),
                child: Text(
                  label,
                  style: GoogleFonts.baloo2(
                    fontSize: WebscreenWidthUnit * 25.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: droppedItems
                        .map(
                          (item) => _buildDraggableDroppedItem(
                            item,
                            droppedItems,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
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
          noLeak(label);
        });

        if (droppedItems1.contains(label) ||
            droppedItems2.contains(label) ||
            droppedItems3.contains(label)) {
          if (availableItems.contains(label)) {
            setState(() {
              availableItems.remove(label);
              noLeak(label);
            });
          }
        } else {
          setState(() {
            //availableItems.add(label);
          });
        }
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
