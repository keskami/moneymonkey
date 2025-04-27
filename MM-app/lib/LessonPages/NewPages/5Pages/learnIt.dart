import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnIt extends StatefulWidget {
  final double height;
  final double width;

  const LearnIt({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  _LearnItState createState() => _LearnItState();
}

class _LearnItState extends State<LearnIt> {
  //Kestan to fill below

  final List<String> titles = [
    "Understanding Value-Based Decisions",
    "Understanding Value-Based Decisions",
    "Understanding Value-Based Decisions",
    "Understanding Value-Based Decisions",
  ];
  final List<String> discriptions = [
    "Value-based financial decisions align your spending with what matters most to you. When your money choices reflect your personal values, you're more likely to feel satisfied with them. This approach isn't about figuring out the 'right' way to spend, but rather the way that brings you the most fulfillment.",
    "Value-based financial decisions align your spending with what matters most to you. When your money choices reflect your personal values, you're more likely to feel satisfied with them. This approach isn't about figuring out the 'right' way to spend, but rather the way that brings you the most fulfillment.",
    "Value-based financial decisions align your spending with what matters most to you. When your money choices reflect your personal values, you're more likely to feel satisfied with them. This approach isn't about figuring out the 'right' way to spend, but rather the way that brings you the most fulfillment.",
    "Value-based financial decisions align your spending with what matters most to you. When your money choices reflect your personal values, you're more likely to feel satisfied with them. This approach isn't about figuring out the 'right' way to spend, but rather the way that brings you the most fulfillment.",
  ];
  final List<String> tips = [
    "Value-based decisions aren't about right or wrong choices, but\nabout what fits YOU best. For example, someone who values adventure might spend on travel, while someone who values security might prioritize saving for emergencies. Think about your recent purchases - which ones left you feeling good afterward? Those likely align with your core values.",
    "Value-based decisions aren't about right or wrong choices, but about what fits YOU best. For example, someone who values adventure might spend on travel, while someone who values security might prioritize saving for emergencies. Think about your recent purchases - which ones left you feeling good afterward? Those likely align with your core values.",
    "Value-based decisions aren't about right or wrong choices, but about what fits YOU best. For example, someone who values adventure might spend on travel, while someone who values security might prioritize saving for emergencies. Think about your recent purchases - which ones left you feeling good afterward? Those likely align with your core values.",
    "Value-based decisions aren't about right or wrong choices, but about what fits YOU best. For example, someone who values adventure might spend on travel, while someone who values security might prioritize saving for emergencies. Think about your recent purchases - which ones left you feeling good afterward? Those likely align with your core values.",
  ];
  final List<String> images = [
    'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793',
    'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793',
    'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793',
    'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793',
  ];

  final String lessonTitle = "Value-Based Financial Decision Making";

  int currentTipIndex = 0;
  
  final ScrollController _scrollController = ScrollController();

  List<bool> visibleTips = [];
  
  List<bool> clicked = [];

  @override
  void initState() {
    super.initState();
    visibleTips = List.generate(tips.length, (index) => index == 0);
    clicked = List.generate(tips.length, (index) => false);
  }

  void showNextTip() {
    setState(() {
      if (currentTipIndex < tips.length - 1) {
        currentTipIndex++;
        visibleTips[currentTipIndex] = true;
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            currentTipIndex * (widget.height * 400), 
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Add Extended Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showNextTip,
        backgroundColor: Colors.white,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              currentTipIndex < tips.length - 1 ? 'Next Tip' : 'Finish',
              style: GoogleFonts.baloo2(
                fontSize: widget.height * 30,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(width: widget.width * 5),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: widget.height * 30,
            ),
          ],
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight,
            width: screenWidth * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey, width: .6),
                bottom: BorderSide(color: Colors.grey, width: .6),
                right: BorderSide(color: Colors.grey, width: .6),
              ),
            ),
          ),
          Container(
            height: screenHeight,
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.grey, width: .6),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: .6),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.width * 20,
                        vertical: widget.height * 30),
                    child: Text(
                      'Money Monkey Learning',
                      style: GoogleFonts.baloo2(
                        fontSize: widget.height * 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.9,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(248, 248, 248, 1),
                    border: Border(
                      right: BorderSide(color: Colors.grey, width: .6),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: widget.width * 200,
                      right: widget.width * 200,
                      top: widget.height * 50,
                    ),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lessonTitle,
                            style: GoogleFonts.baloo2(
                              fontSize: widget.height * 55,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: widget.height * 50),
                          for (int i = 0; i < tips.length; i++)
                            if (visibleTips[i])
                              TipCard(
                                image: images[i],
                                title: titles[i],
                                text: discriptions[i],
                                tip: tips[i],
                                height: widget.height,
                                width: widget.width,
                                index: i,
                                clicked: clicked[i],
                                onClick: () {
                                  setState(() {
                                    clicked[i] = !clicked[i];
                                  });
                                },
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TipCard extends StatefulWidget {
  final String image;
  final String title;
  final String text;
  final String tip;
  final double height;
  final double width;
  final int index;
  final bool clicked;
  final Function() onClick;

  const TipCard({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
    required this.tip,
    required this.height,
    required this.width,
    required this.index,
    required this.clicked,
    required this.onClick,
  }) : super(key: key);

  @override
  _TipCardState createState() => _TipCardState();
}

class _TipCardState extends State<TipCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: widget.height * 50),
        child: Container(
          width: widget.width * 1000,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.width * 50,
                right: widget.width * 50,
                top: widget.height * 30,
                bottom: widget.height * 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: widget.height * 65,
                      width: widget.width * 65,
                      child: Image.network(
                        widget.image,
                        height: widget.height * 65,
                      ),
                    ),
                    SizedBox(width: widget.width * 30),
                    Text(
                      widget.title,
                      style: GoogleFonts.baloo2(
                        fontSize: widget.height * 45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.height * 30),
                Text(
                  widget.text,
                  style: GoogleFonts.baloo2(
                      fontSize: widget.height * 30,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(112, 112, 112, 1)),
                ),
                SizedBox(height: widget.height * 30),
                GestureDetector(
                    onTap: widget.onClick,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.clicked ? 'Hide AI tip' : 'Show AI tip',
                          style: GoogleFonts.baloo2(
                              fontSize: widget.height * 27,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(112, 112, 112, 1)),
                        ),
                        SizedBox(
                            height: widget.clicked ? widget.height * 10 : 0),
                        widget.clicked
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(231, 243, 255, 1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromRGBO(0, 127, 255, 1),
                                    width: .6,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.width * 30,
                                      right: widget.width * 30,
                                      top: widget.height * 30,
                                      bottom: widget.height * 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: widget.width * 65,
                                        height: widget.height * 65,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    0, 127, 255, 1),
                                                width: 2)),
                                        child: Center(
                                          child: Image.network(
                                            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                                            height: widget.height * 50,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: widget.width * 15),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Money Monkey\'s Tips',
                                              style: GoogleFonts.baloo2(
                                                fontSize: widget.height * 35,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                                height: widget.height * 10),
                                            Text(
                                              widget.tip,
                                              style: GoogleFonts.baloo2(
                                                fontSize: widget.height * 28,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
                                              ),
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}