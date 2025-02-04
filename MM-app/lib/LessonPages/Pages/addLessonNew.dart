import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RefactoredAddLessonTest extends StatefulWidget {
  const RefactoredAddLessonTest({Key? key}) : super(key: key);

  @override
  _RefactoredAddLessonTestState createState() => _RefactoredAddLessonTestState();
}

class _RefactoredAddLessonTestState extends State<RefactoredAddLessonTest> {
  Map<String, dynamic> pageData = {};

  /// -----------------------------
  ///  A. MAIN FUNCTION TO ADD LESSON + STEPS
  /// -----------------------------
  Future<void> addRefactoredLessonToFirestore({
    required String levelName,
    required String unitName,
    required int unitNumber,
    required String unitDescription,
    required String lessonName,
    required int lessonNumber,
    required List<Map<String, dynamic>> stepsData,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // 1. Reference to the 'Levels' collection
      DocumentReference levelDoc = firestore.collection('Levels').doc(levelName);

      // 2. Create or fetch the specific Unit doc inside collection("Units")
      CollectionReference unitsCollection = levelDoc.collection('Units');
      DocumentReference unitDoc = unitsCollection.doc(unitNumber.toString());

      // Ensure the Unit doc exists (set if not present)
      await unitDoc.set({
        'UnitName': unitName,
        'UnitNumber': unitNumber,
        'UnitDescription': unitDescription,
      }, SetOptions(merge: true));

      // 3. Create or fetch the Lesson doc inside collection("Lessons")
      CollectionReference lessonsCollection = unitDoc.collection('Lessons');
      DocumentReference lessonDoc = lessonsCollection.doc(lessonNumber.toString());

      await lessonDoc.set({
        'lessonName': lessonName,
        'lessonNumber': lessonNumber,
        'lessonDescription': '', // optionally fill this in
      }, SetOptions(merge: true));

      // 4. Now add each step/page to a "Steps" subcollection
      final stepsCollection = lessonDoc.collection('Steps');

      for (Map<String, dynamic> step in stepsData) {
        int stepIndex = step['stepIndex'];
        await stepsCollection.doc(stepIndex.toString()).set({
          'stepIndex': stepIndex,
          'stepType': step['stepType'], // 'concept', 'scenario', 'story', etc.
          'data': step['data'],        // the actual page data
        });
      }

      print('ALL lesson steps added successfully!');
    } catch (e) {
      print('Failed to add lesson steps: $e');
    }
  }

  /// -----------------------------
  ///  B. RETRIEVE PAGE INFO EXAMPLE
  /// -----------------------------
  Future<Map<String, dynamic>> getRefactoredPageInfoFromFirestore({
    required String levelName,
    required int unitNumber,
    required int lessonNumber,
    required int stepIndex,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      DocumentReference stepDoc = firestore
          .collection('Levels')
          .doc(levelName)
          .collection('Units')
          .doc(unitNumber.toString())
          .collection('Lessons')
          .doc(lessonNumber.toString())
          .collection('Steps')
          .doc(stepIndex.toString());

      DocumentSnapshot snapshot = await stepDoc.get();

      if (snapshot.exists) {
        Map<String, dynamic> stepData = snapshot.data() as Map<String, dynamic>;
        setState(() {
          pageData = stepData;
        });
        return stepData;
      } else {
        print('No step found for index = $stepIndex');
        return {};
      }
    } catch (e) {
      print('Failed to get page info: $e');
      return {};
    }
  }

  /// -----------------------------
  ///  C. BUILD METHOD
  /// -----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Refactored Add Lesson Test")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                /// -------------------------------------------------
                /// 1. WE BUILD OUR STEPS IN THE CORRECT ORDER:
                ///    Concept1 -> Concept2 -> Story -> Scenario
                ///    -> PeerReflection -> Quiz
                /// -------------------------------------------------

                final stepsData = <Map<String, dynamic>>[
                  // -------------------
                  // CONCEPT STEPS
                  // -------------------
                  {
                    'stepIndex': 0,
                    'stepType': 'concept',
                    'data': {
                      "correct": "That's right! Financial responsibility can start early...",
                      "wrong": "Coins have been used since around 600 B.C....",
                      "question": "When Should Financial Responsibility Begin?",
                      "title": "Before we dive in, let’s see what you think!",
                      "options": [
                        "Once I have a full time job",
                        "As soon as I start earning money (even if it’s part-time or allowance)",
                        "After I graduate from college.",
                        "Only when I’m ready to plan for retirement.",
                      ],
                      "correctAnswer":
                          "As soon as I start earning money (even if it’s part-time or allowance)",
                    }
                  },
                  {
                    'stepIndex': 1,
                    'stepType': 'concept',
                    'data': {
                      "introPrompt": "Click for what it really means...", // renamed from "before"
                      "definitionHeader": "Definition:",                  // renamed from "bigTop"
                      "definition": "Financial responsibility over a lifetime means consistently...", // from "bigBottom"
                      "title": "Definition: Financial Responsibility Over a Lifetime",
                      "whyItMatters": "Why does it matter? Because small habits formed early...", // from "little"
                    }
                  },

                  // -------------------
                  // STORY STEPS
                  // (14 -> 2, 16 -> 3, 17 -> 4, 18 -> 5)
                  // -------------------
                  {
                    'stepIndex': 2,
                    'stepType': 'story',
                    'data': {
                      "title": "Financial Responsibility Story",
                      "chatBox": "Meet Minty...",
                      "button": "Continue",
                    }
                  },
                  {
                    'stepIndex': 3,
                    'stepType': 'story',
                    'data': {
                      "largeTitle": "Financial Responsibility Story",
                      "subtitle": "Taking control of your money to build a secure future",
                      "title":
                          "Alex earns \$4,000 monthly but often runs out of money by month-end.",
                      "problem": "Problem: No control over spending",
                      "instructions": "Click to reveal the problem...",
                    }
                  },
                  {
                    'stepIndex': 4,
                    'stepType': 'story',
                    'data': {
                      "largeTitle": "Financial Responsibility Story",
                      "subtitle": "Taking control of your money to build a secure future",
                      "title": "The Solution?",
                      "instructions": [
                        "Click to reveal solution 1",
                        "Click to reveal solution 2",
                        "Click to reveal solution 3",
                      ],
                      "bigTexts": ["Track Spending", "Plan Ahead", "Save First"],
                      "smallTexts": [
                        "Record every expense",
                        "Set monthly budget",
                        "20% of income to savings"
                      ],
                      'button': "Finish",
                    }
                  },
                  {
                    'stepIndex': 5,
                    'stepType': 'story',
                    'data': {
                      "largeTitle": "Financial Responsibility Story",
                      "subtitle": "Taking control of your money to build a secure future",
                      "title": "The Impact", // renamed from the old "title"
                      "before": [
                        "No savings",
                        "Constant stress",
                        "Emergency = crisis",
                      ],
                      "after": [
                        "800 saved month",
                        "Peace of mind",
                        "Ready for emergencies"
                      ],
                      "instructions": [
                        "Click for the before...",
                        "Click for the after..."
                      ],
                      "before/after": ["before", "after"],
                      'button': "Finish",
                    }
                  },

                  // -------------------
                  // SCENARIO STEPS
                  // 9 <-> 10 swapped, remove 11,13
                  // So we keep old 10 => new 6, old 9 => new 7, old 12 => new 8
                  // -------------------
                  // old step10 => new 6
                  {
                    'stepIndex': 6,
                    'stepType': 'scenario',
                    'data': {
                      'title':
                          "Congratulations! You've just started your first part-time job...",
                      "items": ["Sneakers", "College", "Activities"],
                      "instructions": [
                        "Click for choice 1...",
                        "Click for choice 2...",
                        "Click for choice 3..."
                      ],
                      "button": "Start Managing Your Money",
                    }
                  },
                  // old step9 => new 7
                  {
                    'stepIndex': 7,
                    'stepType': 'scenario',
                    'data': {
                      "questions": [
                        "How much will you save?",
                        "What about those \$150 sneakers?",
                        "Planning for Emergencies",
                      ],
                      'options2': [
                        "Buy Now (\$150)",
                        "Get them immediately",
                        "Wait for Next Paycheck",
                        "Practice patience",
                        "Buy Cheaper Option (\$75)",
                        "Find a balance",
                      ],
                      'options3': [
                        "Set aside \$150",
                        "Strong emergency fund",
                        "Set aside \$50",
                        "Small emergency fund",
                        "Keep Nothing for Emergencies",
                        "Spend it all",
                      ],
                      'options1': [
                        "Save \$250 (50%)",
                        "Maximum savings for future goals",
                        "Save \$100 (20%)",
                        "Moderate savings approach",
                        "Save \$0 (0%)",
                        "No savings",
                      ],
                      'correctAnswers': [
                        "Save \$250 (50%)",
                        "Wait for Next Paycheck",
                        "Set aside \$150"
                      ],
                      "correctMessages": [
                        "Great choice! Saving a significant portion ensures you're planning...",
                        "Great decision! Delaying gratification helps you stay within...",
                        "Excellent! Planning for emergencies helps you avoid debt..."
                      ],
                    }
                  },
                  // old step12 => new 8
                  {
                    'stepIndex': 8,
                    'stepType': 'scenario',
                    'data': {
                      "title": "Your Financial Summary",
                      "button": "Finish",
                      "subTitle": "Financial Responsibility Score:",
                    }
                  },

                  // -------------------
                  // PEER REFLECTION (keep 19..22, remove 23)
                  // Renumber to 9..12
                  // -------------------
                  // old step19 => new 9
                  {
                    'stepIndex': 9,
                    'stepType': 'peerReflection',
                    'data': {
                      "title": "Taking Responsibility for Personal Financial Decisions",
                      "subTitle":
                          "Taking responsibility for your finances helps you plan for every stage...",
                      "maria": "Maria",
                      "maria2": "The Planner",
                      "ava": "Ava",
                      "ava2": "The Single Saver",
                      "jason": "Jason",
                      'jason2': "Family Provider",
                      'button': "Continue to Peer Stories",
                    }
                  },
                  // old step20 => new 10
                  {
                    'stepIndex': 10,
                    'stepType': 'peerReflection',
                    'data': {
                      "title": "Peer Stories",
                      "maria": "Maria: The Planner",
                      "maria2":
                          "Maria started saving as a teen to buy her first car...",
                      "ava": "Ava: The Single Saver",
                      "ava2":
                          "Ava, in her early 30s, focuses on saving for travel...",
                      "jason": "Jason: The Family Provider",
                      'jason2':
                          "Jason is a dad with two kids. He prioritizes housing...",
                      'button': "Continue to Activity",
                    }
                  },
                  // old step21 => new 11
                  {
                    'stepIndex': 11,
                    'stepType': 'peerReflection',
                    'data': {
                      "question": "Match Actions to Categories",
                      "subTitle": "Actions to Categorize:",
                      "box1": "Lifelong Financial\nWell-Being",
                      "box2": "Responsibility with\nDependents",
                      "box3": "Responsibility\nwithout Dependents",
                      "options": [
                        'Planning for grad school',
                        'Starting retirement fund',
                        'Budgeting for family needs',
                        'Emergency fund',
                        'Kids’ education savings',
                        'Personal investments',
                        'Travel savings',
                        'Flexible budgeting'
                      ],
                      "correct1": [
                        'Flexible budgeting',
                        'Travel savings',
                        'Emergency fund',
                        'Starting retirement fund',
                      ],
                      "correct2": [
                        'Kids’ education savings',
                        'Budgeting for family needs',
                      ],
                      "correct3": [
                        'Planning for grad school',
                        'Personal investments',
                      ],
                    }
                  },
                  // old step22 => new 12
                  {
                    'stepIndex': 12,
                    'stepType': 'peerReflection',
                    'data': {
                      "title": "Reflection",
                      "subTitle":
                          "Which peer's financial situation do you relate to most?",
                      "maria": "Maria, because I’m focused on planning future goals",
                      "jason":
                          "Jason, because I have to prioritize needs over wants",
                      "ava":
                          "Ava, because I’m working on personal savings & investments",
                      'button': "Finish Peer Reflection",
                    }
                  },

                  // -------------------
                  // QUIZ (keep old 29..33 => new 13..17)
                  // -------------------
                  // old step29 => new 13
                  {
                    'stepIndex': 13,
                    'stepType': 'quiz',
                    'data': {
                      "question":
                          "What is a key reason to start saving early in life?",
                      "answer1": "To buy expensive luxury items immediately",
                      "answer2": "To build good financial habits over time",
                      "answer3": "To avoid making a budget",
                      "answer4": "To spend without worrying about the future",
                      "correct": '2',
                    }
                  },
                  // old step30 => new 14
                  {
                    'stepIndex': 14,
                    'stepType': 'quiz',
                    'data': {
                      "question":
                          "Why is it important to have an emergency fund?",
                      "answer1": "To cover unexpected expenses",
                      "answer2": "To buy luxury items",
                      "answer3": "To invest in risky stocks",
                      "answer4": "To avoid working a job",
                      "correct": '1'
                    }
                  },
                  // old step31 => new 15
                  {
                    'stepIndex': 15,
                    'stepType': 'quiz',
                    'data': {
                      "question":
                          "Which of the following are good financial strategies? (select all)",
                      "answer1": "Set aside money for emergencies",
                      "answer2": "Spend all your income on entertainment",
                      "answer3": "Create a budget and stick to it",
                      "answer4": "Ignore long-term financial goals",
                      "correct1": '1',
                      "correct2": '3',
                    }
                  },
                  // old step32 => new 16
                  {
                    'stepIndex': 16,
                    'stepType': 'quiz',
                    'data': {
                      "question":
                          "What actions demonstrate financial responsibility? (select all)",
                      "answer1": "Planning for future expenses",
                      "answer2": "Setting financial goals",
                      "answer3": "Spending without tracking expenses",
                      "answer4": "Regularly contributing to savings",
                      "correct1": '1',
                      "correct2": '2',
                      "correct3": '4',
                    }
                  },
                  // old step33 => new 17
                  {
                    'stepIndex': 17,
                    'stepType': 'quiz',
                    'data': {
                      "question": "Match Actions to Categories",
                      "subTitle": "Actions to Categorize:",
                      "box1": "Short-Term Goals",
                      "box2": "Medium-Term Goals",
                      "box3": "Long-Term Goals",
                      "options": [
                        "Saving for Retirement",
                        "Planning for college tuition",
                        "Saving for a concert ticket"
                      ],
                      "correct1": ["Saving for a concert ticket"],
                      "correct2": ["Planning for college tuition"],
                      "correct3": ["Saving for Retirement"],
                    }
                  },
                ];

                /// -------------------------------------------------
                /// 2. CALL OUR NEW HELPER FUNCTION
                /// -------------------------------------------------
                await addRefactoredLessonToFirestore(
                  levelName: "Advanced",
                  unitName: "Budgeting Basics",
                  unitNumber: 1,
                  unitDescription:
                      "Learn how to create a budget and manage expenses.",
                  lessonName: "Understanding Income",
                  lessonNumber: 1,
                  stepsData: stepsData,
                );

                print("All data added in new structure!");

                /// 3. Optionally, retrieve a test page to see if it worked:
                final fetched = await getRefactoredPageInfoFromFirestore(
                  levelName: "Advanced",
                  unitNumber: 1,
                  lessonNumber: 1,
                  stepIndex: 0, // test fetch step0 (concept1)
                );
                print("Fetched step0: $fetched");
              },
              child: const Text("Add/Refactor Lesson Data"),
            ),
            const SizedBox(height: 30),
            Text("Fetched Page Data:\n\n$pageData"),
          ],
        ),
      ),
    );
  }
}
