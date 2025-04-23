import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/NewPages/newPageWidgets/reflectionpPrompts.dart';

class Reflection extends StatefulWidget {
  final double heightUnit;
  final double widthUnit;

  const Reflection({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
  }) : super(key: key);

  @override
  _ReflectionState createState() => _ReflectionState();
}

class _ReflectionState extends State<Reflection> {
  //Kestan to fill below

  String startingHint = "Reflect on your Financial Values";
  String reflectionName = "Financial Values";
  List<String> reflectionPrompts = [
    "How did I feel today? How did I feel today?",
    "What did I learn today? How did I feel today?",
    "What challenges did I face? What did I learn today?",
    "What am I grateful for? How did I feel today?",
    "What are my goals for tomorrow? How did I feel today?",
  ];
  //Kestan to fill above

  int clickedIndex = -1;
  final TextEditingController textController = TextEditingController();
  int characterCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight,
            width: screenWidth * .25,
            decoration: BoxDecoration(
                color: Colors.white,
                border: BorderDirectional(
                    end: BorderSide(width: .6, color: Colors.grey))),
            child: Padding(
              padding: EdgeInsets.all(widget.heightUnit * 55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.widthUnit * 90,
                    height: widget.heightUnit * 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromRGBO(0, 127, 255, 1), width: 2)),
                    child: Center(
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                        height: widget.heightUnit * 70,
                      ),
                    ),
                  ),
                  SizedBox(height: widget.heightUnit * 20),
                  Text(
                    "Money Monkey",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.heightUnit * 40,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: widget.heightUnit * 5),
                  Text(
                    "Reflect and Journal",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.heightUnit * 24,
                        color: Color.fromRGBO(112, 118, 124, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: widget.heightUnit * 50),
                  Text(
                    "Reflection Prompts",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.heightUnit * 24,
                        color: Color.fromRGBO(112, 118, 124, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: widget.heightUnit * 30),
                  ...reflectionPrompts.asMap().entries.map((entry) {
                    int index = entry.key;
                    String prompt = entry.value;
                    return ReflectionPrompts(
                      height: widget.heightUnit,
                      width: widget.widthUnit,
                      prompt: prompt,
                      index: index,
                      selectedIndex: clickedIndex,
                      onTap: (index) {
                        setState(() {
                          clickedIndex = index;
                          TextEditingController().text = prompt;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Container(
            width: screenWidth * .75,
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: screenWidth * .75,
                    height: screenHeight * .1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey, width: .6))),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: widget.heightUnit * 5,
                            left: widget.widthUnit * 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: widget.heightUnit * 5,
                                      top: widget.heightUnit * 10,
                                      left: widget.widthUnit * 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Reflect on your $reflectionName",
                                        style: GoogleFonts.baloo2(
                                            fontSize: widget.heightUnit * 40,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Take a moment to journal about what you've learned about your $reflectionName from the activity.",
                                        style: GoogleFonts.baloo2(
                                            fontSize: widget.heightUnit * 28,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                            ]))),
                Container(
                  width: screenWidth * .75,
                  height: screenHeight * .9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: widget.heightUnit * 80,
                      ),
                      Container(
                        height: screenHeight * .55,
                        width: screenWidth * .5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.grey, width: .6),
                        ),
                        child: TextField(
                          controller: textController,
                          maxLines: null,
                          expands: true,
                          cursorWidth: 1,
                          cursorColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              characterCount = textController.text.length;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.all(widget.widthUnit * 20),
                            border: InputBorder.none,
                            hintText: "Type your reflection here...",
                            hintStyle: GoogleFonts.baloo2(
                              fontSize: widget.heightUnit * 26,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: screenWidth * .5,
                          height: screenHeight * .1,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            border: Border(
                              left: BorderSide(color: Colors.grey, width: .6),
                              right: BorderSide(color: Colors.grey, width: .6),
                              bottom: BorderSide(color: Colors.grey, width: .6),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: widget.widthUnit * 20,
                              ),
                              Container(
                                width: widget.widthUnit * 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        textController.text.isEmpty
                                            ? "0"
                                            : "${characterCount}",
                                        style: GoogleFonts.baloo2(
                                          fontSize: widget.heightUnit * 30,
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1),
                                          fontWeight: FontWeight.w500,
                                        )),
                                    SizedBox(
                                      width: widget.widthUnit * 5,
                                    ),
                                    Text("characters",
                                        style: GoogleFonts.baloo2(
                                          fontSize: widget.heightUnit * 30,
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1),
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  //Store reflection
                                },
                                child: Container(
                                  width: widget.widthUnit * 200,
                                  height: widget.heightUnit * 70,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 127, 255, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Save Reflection',
                                      style: GoogleFonts.baloo2(
                                        fontSize: widget.heightUnit * 26,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widget.widthUnit * 20,
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
