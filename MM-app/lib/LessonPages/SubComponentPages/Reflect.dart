import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Widgets/LessonPages/ReflectionPrompts.dart';

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
        children: [
          // Sidebar
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(radius: 24, backgroundColor: const Color(0xFF007FFF), child: const Text('🐵', style: TextStyle(fontSize: 24))),
                      const SizedBox(height: 8),
                      Text('Money Monkey', style: GoogleFonts.baloo2(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Reflect & Journal', style: GoogleFonts.baloo2(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reflection Prompts', style: GoogleFonts.baloo2(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 8),
                      for (var i = 0; i < reflectionPrompts.length; i++)
                        ReflectionPrompts(
                          height: widget.heightUnit,
                          width: widget.widthUnit,
                          prompt: reflectionPrompts[i],
                          index: i,
                          selectedIndex: clickedIndex,
                          onTap: (idx) => setState(() => clickedIndex = idx),
                        ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reflect on your $reflectionName', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Take a moment to journal about what you\'ve learned about your $reflectionName from the activity.', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 768),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                        ),
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