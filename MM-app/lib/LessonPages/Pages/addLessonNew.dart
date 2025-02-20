import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RefactoredAddLessonTest extends StatefulWidget {
  const RefactoredAddLessonTest({Key? key}) : super(key: key);

  @override
  _RefactoredAddLessonTestState createState() =>
      _RefactoredAddLessonTestState();
}

class _RefactoredAddLessonTestState extends State<RefactoredAddLessonTest> {
  Map<String, dynamic> pageData = {};

  /// -----------------------------
  ///  A. MAIN FUNCTION TO ADD LESSON TO FIRESTORE
  /// -----------------------------
  Future<void> addLessonToFirestore({
    required String levelName,
    required String unitName,
    required int unitNumber,
    required String unitDescription,
    required String lessonName,
    required int lessonNumber,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Create references
      final levelRef = firestore.collection('Levels').doc(levelName);
      final unitsRef = levelRef.collection('Units');
      final unitRef = unitsRef.doc('Unit_$unitNumber');
      final lessonsRef = unitRef.collection('Lessons');
      final lessonRef = lessonsRef.doc('Lesson_$lessonNumber');
      final componentsRef = lessonRef.collection('Components');

      // Set unit data
      await unitRef.set({
        'unitName': unitName,
        'unitNumber': unitNumber,
        'unitDescription': unitDescription,
      });

      // Set lesson data
      await lessonRef.set({
        'lessonName': lessonName,
        'lessonNumber': lessonNumber,
      });

      // Add Concept Component with all pages
      await _addConceptComponent(componentsRef);

      // Add Concept2 Component (duplicate of concept with modifications)
      await _addConcept2Component(componentsRef);

      // Add Story Component
      await _addStoryComponent(componentsRef);

      // Add Scenario Component
      await _addScenarioComponent(componentsRef);

      // Add PeerReflection Component
      await _addPeerReflectionComponent(componentsRef);

      // Add Quiz Component
      await _addQuizComponent(componentsRef);

      print('Lesson structure created successfully');
    } catch (e) {
      print('Error creating lesson structure: $e');
      throw e;
    }
  }

  /// -----------------------------
  ///  B. COMPONENT ADDITION FUNCTIONS
  /// -----------------------------
  Future<void> _addConceptComponent(CollectionReference componentsRef) async {
    final conceptRef = componentsRef.doc('Concept');
    final conceptPages = {
      'conceptPage_1': {
        'title': "Before we dive in, let's see what you think!",
        'question': "When Should Financial Responsibility Begin?",
        'options': [
          "Once I have a full time job",
          "As soon as I start earning money (even if it's part-time or allowance)",
          "After I graduate from college.",
          "Only when I'm ready to plan for retirement.",
        ],
        'correctAnswer':
            "As soon as I start earning money (even if it's part-time or allowance)",
        'correct':
            "That's right! Financial responsibility can start early, from\nyour first paycheck or allowance. Let's explore why.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
      },
      'conceptPage_2': {
        'title': "Definition: Financial Responsibility Over a Lifetime",
        'definitionHeader': "Definition:",
        'definition':
            "Financial responsibility over a lifetime means consistently making informed decisions about earning, saving, spending, and investing, starting from your earliest income and continuing through retirement.",
        'whyItMatters':
            "Why does it matter? Because small habits formed early—like setting aside a little money or comparing prices—can grow into long-term financial stability.",
      },
      'conceptPage_3': {
        "title": "Definition: Financial Responsibility Over a Lifetime",
        "iconLinks": [
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcard.png?alt=media&token=d9ad44a7-c607-4a88-9c8b-64d49e47a245",
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgraduation-cap.png?alt=media&token=53e1203d-816d-4512-b570-db886d53d904",
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fbriefcase-bag.png?alt=media&token=987a2538-9376-46ef-965e-502cf493d798",
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fsunset.png?alt=media&token=2ebd97df-6903-4254-bd15-3a59c404825b",
        ],
        'iconContents': [
          "Even small allowances or part-time earnings can be budgeted. Learning to save a portion of every dollar sets a foundation for bigger goals later.",
          "This might be your first real job or college experience. Start building credit responsibly and budget for regular bills—rent, utilities, groceries.",
          "You might buy a home or consider long-term investments. Having an emergency fund, managing debt wisely, and planning for retirement become crucial.",
          "You live off savings, pensions, or investments made earlier. Continued budgeting helps ensure your money lasts and you maintain your desired lifestyle.",
        ],
        'wrong': "Kindly go in order from Left to Right.",
      },
      'conceptPage_4': {
        'title': 'Meet Jordan: A Life of Financial Decisions',
        'subTitle':
            'Jordan is on a journey from high school to retirement. Let\'s help them make smart financial choices!',
        'options': ["Save 10%", "Spend all of it"],
        'correct': "Great habit! Even \$5 a week adds up over time.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        'containerHeading': "High School",
        'containerSubHeading':
            "Jordan earns \$50/week from chores. Should Jordan save 10% (\$5) or spend it all?",
        'correctAnswer': "Save 10%",
      },
      'conceptPage_5': {
        'title': "Meet Jordan: A Life of Financial Decisions",
        'subTitle':
            "Jordan is on a journey from high school to retirement. Let's help them make smart financial choices!",
        'options': ["Create a monthly budget", "Wing it"],
        'correct':
            "Smart move! This helps Jordan track\nspending and allocate money for bills,\nsavings, and fun.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        'containerHeading': "High School",
        'containerSubHeading':
            "Jordan just started a full-time job. Should he create a monthly budget first or just wing it?",
        'correctAnswer': "Create a monthly budget",
      },
      'conceptPage_6': {
        'title': "Meet Jordan: A Life of Financial Decisions",
        'subTitle':
            "Jordan is on a journey from high school to retirement. Let's help them make smart financial choices!",
        'options': ["High priority", "Not that important"],
        'correct':
            "Yes! Unexpected costs like medical\nbills or childcare can pop up. Having a\ncushion is crucial.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        'containerHeading': "Family Planning",
        'containerSubHeading':
            "Jordan is thinking about starting a family soon. How important is it to have an emergency fund?",
        'correctAnswer': "High priority",
      },
      'conceptPage_7': {
        'title': "Meet Jordan: A Life of Financial Decisions",
        'subTitle':
            "Jordan is on a journey from high school to retirement. Let's help them make smart financial choices!",
        'options': ["Yes", "No"],
        'correct':
            "Yes! Consistent budgeting helps\nensure savings last throughout\nretirement.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        'containerHeading': "Retirement",
        'containerSubHeading':
            "Jordan is now approaching retirement. Should they continue some form of budgeting?",
        'correctAnswer': "Yes",
      },
      'conceptPage_8': {
        "title": "Quick Check: Lifelong Financial Responsibility",
        "button": "Check",
        "options1": [
          "Spending money the moment you get it",
          "Saving and investing a portion of earnings regularly",
          "Waiting to save until you earn a high salary",
        ],
        "options2": [
          "It guarantees you'll never worry about money again",
          "It covers unexpected expenses, reducing stress and debt",
          "It means you can freely spend on luxury items without a budget",
        ],
        "correctAnswer1":
            "Saving and investing a portion of earnings regularly",
        "correctAnswer2":
            "It covers unexpected expenses, reducing stress and debt",
        "2Correct": "Yes, both these answers are correct!",
        "1Correct": "Only one of these answers are\ncorrect!",
        "0Correct": "Recheck your answer please.",
        "question1":
            "Which of the following best describes a strong financial habit at any age?",
        "question2": "Which is a key benefit of having an emergency fund?",
      },
      'conceptPage_9': {
        "title": "Key Takeaways: Lifelong Financial Responsibility",
        "correct":
            "Yes! Consistent budgeting helps\nensure savings last throughout\nretirement.",
        "wrong":
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        "subTitle": "Personal Reflection",
        "hint": "What's one new financial habit you'll adopt this month?",
        'takeaways': [
          "Early habits matter",
          "Starting even with small amounts when young helps build bigger savings over time.",
          "Budgeting at Every Stage",
          "From first job to retirement, a budget reduces overspending and increases savings.",
          "Preparedness for Changes",
          "Plan for life transitions—like family or job changes—by maintaining an emergency fund.",
          "Never Too Late to Improve",
          "Even close to retirement, you can still refine your budget and investment approach for a more secure future."
        ],
        "image":
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Ftakeaway_check.png?alt=media&token=9a389932-5562-4c38-a970-9ecd6bf8adcb",
      },
    };
    await conceptRef.set(conceptPages);
  }

  Future<void> _addConcept2Component(CollectionReference componentsRef) async {
    final concept2Ref = componentsRef.doc('Concept2');
    final concept2Pages = {
      'conceptPage_1': {
        'title': "Before we dive in, let's see what you think!",
        'question': "When Should Financial Responsibility Begin?",
        'options': [
          "Once I have a full time job",
          "As soon as I start earning money (even if it's part-time or allowance)",
          "After I graduate from college.",
          "Only when I'm ready to plan for retirement.",
        ],
        'correctAnswer':
            "As soon as I start earning money (even if it's part-time or allowance)",
        'correct':
            "That's right! Financial responsibility can start early, from\nyour first paycheck or allowance. Let's explore why.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
      },
      'conceptPage_2': {
        'title': "Definition: Financial Responsibility Over a Lifetime",
        'definitionHeader': "Definition:",
        'definition':
            "Financial responsibility over a lifetime means consistently making informed decisions about earning, saving, spending, and investing, starting from your earliest income and continuing through retirement.",
        'whyItMatters':
            "Why does it matter? Because small habits formed early—like setting aside a little money or comparing prices—can grow into long-term financial stability.",
      },
      'conceptPage_3': {
        "title": "Definition: Financial Responsibility Over a Lifetime",
        "iconLinks": [
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcard.png?alt=media&token=d9ad44a7-c607-4a88-9c8b-64d49e47a245",
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgraduation-cap.png?alt=media&token=53e1203d-816d-4512-b570-db886d53d904",
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fbriefcase-bag.png?alt=media&token=987a2538-9376-46ef-965e-502cf493d798",
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fsunset.png?alt=media&token=2ebd97df-6903-4254-bd15-3a59c404825b",
        ],
        'iconContents': [
          "Even small allowances or part-time earnings can be budgeted. Learning to save a portion of every dollar sets a foundation for bigger goals later.",
          "This might be your first real job or college experience. Start building credit responsibly and budget for regular bills—rent, utilities, groceries.",
          "You might buy a home or consider long-term investments. Having an emergency fund, managing debt wisely, and planning for retirement become crucial.",
          "You live off savings, pensions, or investments made earlier. Continued budgeting helps ensure your money lasts and you maintain your desired lifestyle.",
        ],
        'wrong': "Kindly go in order from Left to Right.",
      },
      'conceptPage_4': {
        'title': 'Meet Jordan: A Life of Financial Decisions',
        'subTitle':
            'Jordan is on a journey from high school to retirement. Let\'s help them make smart financial choices!',
        'options': ["Save 10%", "Spend all of it"],
        'correct': "Great habit! Even \$5 a week adds up over time.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        'containerHeading': "High School",
        'containerSubHeading':
            "Jordan earns \$50/week from chores. Should Jordan save 10% (\$5) or spend it all?",
        'correctAnswer': "Save 10%",
      },
      'conceptPage_5': {
        'title': "Meet Jordan: A Life of Financial Decisions",
        'subTitle':
            "Jordan is on a journey from high school to retirement. Let's help them make smart financial choices!",
        'options': ["Create a monthly budget", "Wing it"],
        'correct':
            "Smart move! This helps Jordan track\nspending and allocate money for bills,\nsavings, and fun.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        'containerHeading': "High School",
        'containerSubHeading':
            "Jordan just started a full-time job. Should he create a monthly budget first or just wing it?",
        'correctAnswer': "Create a monthly budget",
      },
      'conceptPage_6': {
        'title': "Meet Jordan: A Life of Financial Decisions",
        'subTitle':
            "Jordan is on a journey from high school to retirement. Let's help them make smart financial choices!",
        'options': ["High priority", "Not that important"],
        'correct':
            "Yes! Unexpected costs like medical\nbills or childcare can pop up. Having a\ncushion is crucial.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        'containerHeading': "Family Planning",
        'containerSubHeading':
            "Jordan is thinking about starting a family soon. How important is it to have an emergency fund?",
        'correctAnswer': "High priority",
      },
      'conceptPage_7': {
        'title': "Meet Jordan: A Life of Financial Decisions",
        'subTitle':
            "Jordan is on a journey from high school to retirement. Let's help them make smart financial choices!",
        'options': ["Yes", "No"],
        'correct':
            "Yes! Consistent budgeting helps\nensure savings last throughout\nretirement.",
        'wrong':
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        'containerHeading': "Retirement",
        'containerSubHeading':
            "Jordan is now approaching retirement. Should they continue some form of budgeting?",
        'correctAnswer': "Yes",
      },
      'conceptPage_8': {
        "title": "Quick Check: Lifelong Financial Responsibility",
        "button": "Check",
        "options1": [
          "Spending money the moment you get it",
          "Saving and investing a portion of earnings regularly",
          "Waiting to save until you earn a high salary",
        ],
        "options2": [
          "It guarantees you'll never worry about money again",
          "It covers unexpected expenses, reducing stress and debt",
          "It means you can freely spend on luxury items without a budget",
        ],
        "correctAnswer1":
            "Saving and investing a portion of earnings regularly",
        "correctAnswer2":
            "It covers unexpected expenses, reducing stress and debt",
        "2Correct": "Yes, both these answers are correct!",
        "1Correct": "Only one of these answers are\ncorrect!",
        "0Correct": "Recheck your answer please.",
        "question1":
            "Which of the following best describes a strong financial habit at any age?",
        "question2": "Which is a key benefit of having an emergency fund?",
      },
      'conceptPage_9': {
        "title": "Key Takeaways: Lifelong Financial Responsibility",
        "correct":
            "Yes! Consistent budgeting helps\nensure savings last throughout\nretirement.",
        "wrong":
            "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
        "subTitle": "Personal Reflection",
        "hint": "What's one new financial habit you'll adopt this month?",
        'takeaways': [
          "Early habits matter",
          "Starting even with small amounts when young helps build bigger savings over time.",
          "Budgeting at Every Stage",
          "From first job to retirement, a budget reduces overspending and increases savings.",
          "Preparedness for Changes",
          "Plan for life transitions—like family or job changes—by maintaining an emergency fund.",
          "Never Too Late to Improve",
          "Even close to retirement, you can still refine your budget and investment approach for a more secure future."
        ],
        "image":
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Ftakeaway_check.png?alt=media&token=9a389932-5562-4c38-a970-9ecd6bf8adcb",
      },
    };
    await concept2Ref.set(concept2Pages);
  }

  Future<void> _addStoryComponent(CollectionReference componentsRef) async {
    final storyRef = componentsRef.doc('Story');
    await storyRef.set({
      'storyPage_1': {
        'title': "Financial Responsibility Story",
        'chatBox': "Meet Minty...",
        'button': "Continue to Peer Stories",
      },
      'storyPage_2': {
        'largeTitle': "Financial Responsibility Story",
        'subtitle': "Taking control of your money to build a secure future",
      },
      'storyPage_3': {
        'largeTitle': "Financial Responsibility Story",
        'subtitle': "Taking control of your money to build a secure future",
        'title':
            "Alex earns \$4,000 monthly but often runs out of money by month-end.",
        'problem': "Problem: No control over spending",
        'instructions': "Click to reveal the problem...",
      },
      'storyPage_4': {
        'largeTitle': "Financial Responsibility Story",
        'subtitle': "Taking control of your money to build a secure future",
        'title': "The Solution?",
        'instructions': [
          "Click to reveal solution 1",
          "Click to reveal solution 2",
          "Click to reveal solution 3",
        ],
        'bigTexts': ["Track Spending", "Plan Ahead", "Save First"],
        'smallTexts': [
          "Record every expense",
          "Set monthly budget",
          "20% of income to savings"
        ],
        'button': "Finish",
      },
      'storyPage_5': {
        'largeTitle': "Financial Responsibility Story",
        'subtitle': "Taking control of your money to build a secure future",
        'title': "The Impact",
        'before': [
          "No savings",
          "Constant stress",
          "Emergency = crisis",
        ],
        'after': ["800 saved month", "Peace of mind", "Ready for emergencies"],
        'instructions': ["Click for the before...", "Click for the after..."],
        'before/after': ["before", "after"],
        'button': "Finish",
      },
    });
  }

  Future<void> _addScenarioComponent(CollectionReference componentsRef) async {
    final scenarioRef = componentsRef.doc('Scenario');
    await scenarioRef.set({
      'scenarioPage_1': {
        'title':
            "Congratulations! You've just started your first part-time job and earned your first paycheck of \$500. You have several things you want to do with the money: buy new sneakers, save for college, and plan for weekend activities.",
        'items': ["Sneakers", "College", "Activities"],
        'instructions': [
          "Click for choice 1...",
          "Click for choice 2...",
          "Click for choice 3..."
        ],
        'button': "Start Managing Your Money",
      },
      'scenarioPage_2': {},
      'scenarioPage_3': {
        'title': "Your Financial Summary",
        'button': "Finish",
        'subTitle': "Financial Responsibility Score:",
      },
      'scenarioPage_4': {},
      'scenarioPage_5': {},
      'controllerData': {
        'questions': [
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
        'correctMessages': [
          "Great choice! Saving a significant portion ensures you're planning for the future.",
          "Great decision! Delaying gratification helps you stay within your budget.",
          "Excellent! Planning for emergencies helps you avoid debt in tough times.",
        ],
      },
    });
  }

  Future<void> _addPeerReflectionComponent(
      CollectionReference componentsRef) async {
    final peerReflectionRef = componentsRef.doc('PeerReflection');
    await peerReflectionRef.set({
      'peerReflectionPage_1': {
        "title": "Taking Responsibility for Personal Financial Decisions",
        "subTitle":
            "Taking responsibility for your finances helps you plan for\nevery stage of life, whether you're managing just for\nyourself or for others who depend on you.",
        "maria": "Maria",
        "maria2": "The Planner",
        "ava": "Ava",
        "ava2": "The Single Saver",
        "jason": "Jason",
        'jason2': "Family Provider",
        'button': "Continue to Peer Stories",
      },
      'peerReflectionPage_2': {
        "title": "Peer Stories",
        "maria": "Maria: The Planner",
        "maria2":
            "Maria started saving as a teen to buy her first car. Now in her 20s,\nshe's saving for grad school while setting aside money for retirement.",
        "ava": "Ava: The Single Saver",
        "ava2":
            "Ava, in her early 30s, focuses on saving for travel and investing in her future.\nWithout dependents, she can prioritize her personal goals.",
        "jason": "Jason: The Family Provider",
        'jason2':
            "Jason is a dad with two kids. He prioritizes housing, groceries, and school expenses\nbut still sets aside money for emergencies and his kids' future education.",
        'button': "Continue to Activity",
      },
      'peerReflectionPage_3': {
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
          "Kids' education savings",
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
          "Kids' education savings",
          'Budgeting for family needs',
        ],
        "correct3": [
          'Planning for grad school',
          'Personal investments',
        ],
      },
      'peerReflectionPage_4': {
        "title": "Reflection",
        "subTitle":
            "Which peer's financial situation do you relate to most? Why?",
        "maria": "Maria, because I'm focused on planning future goals",
        "jason": "Jason, because I have to prioritize needs over wants",
        "ava": "Ava, because I'm working on personal savings and investments",
        'button': "Finish Peer Reflection",
      },
      'peerReflectionPage_5': {},
    });
  }

  Future<void> _addQuizComponent(CollectionReference componentsRef) async {
    final quizRef = componentsRef.doc('Quiz');
    await quizRef.set({
      'quizPage_1': {
        "question": "What is a key reason to start saving early in life?",
        "answer1": "To buy expensive luxury\nitems immediately",
        "answer2": "To build good financial\nhabits over time",
        "answer3": "To avoid making a budget",
        "answer4": "To spend without worrying about\nthe future",
        "correct": '2',
      },
      'quizPage_2': {
        "question": "Why is it important to have an emergency fund?",
        "answer1": "To cover unexpected expenses",
        "answer2": "To buy luxury items",
        "answer3": "To invest in risky stocks",
        "answer4": "To avoid working a job",
        "correct": '1'
      },
      'quizPage_3': {
        "question":
            "Which of the following are good financial\nstrategies? (select all that apply)",
        "answer1": "Set aside money for emergencies",
        "answer2": "Spend all your income\non entertainment",
        "answer3": "Create a budget and stick to it",
        "answer4": "Ignore long-term financial goals",
        "correct1": '1',
        "correct2": '3',
      },
      'quizPage_4': {
        "question":
            "What actions demonstrate financial\nresponsibility? (select all that apply)",
        "answer1": "Planning for future expenses",
        "answer2": "Setting financial goals",
        "answer3": "Spending without tracking\nexpenses",
        "answer4": "Regularly contributing to savings",
        "correct1": '1',
        "correct2": '2',
        "correct3": '4',
      },
      'quizPage_5': {
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
    });
  }

  // Continue with other component addition functions...

  /// -----------------------------
  ///  C. RETRIEVE PAGE INFO
  /// -----------------------------
  Future<Map<String, dynamic>> getPageInfoFromFirestore({
    required String levelName,
    required int unitNumber,
    required int lessonNumber,
    required String componentType,
    required int pageNumber,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final docRef = firestore
          .collection('Levels')
          .doc(levelName)
          .collection('Units')
          .doc('Unit_$unitNumber')
          .collection('Lessons')
          .doc('Lesson_$lessonNumber')
          .collection('Components')
          .doc(componentType);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final pageKey = '${componentType.toLowerCase()}Page_$pageNumber';
        setState(() {
          pageData = data[pageKey] ?? {};
        });
        return data[pageKey] ?? {};
      }
      return {};
    } catch (e) {
      print('Failed to get page info: $e');
      return {};
    }
  }

  /// -----------------------------
  ///  D. BUILD METHOD
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
                await addLessonToFirestore(
                  levelName: "Advanced",
                  unitName: "Budgeting Basics",
                  unitNumber: 1,
                  unitDescription:
                      "Learn how to create a budget and manage expenses.",
                  lessonName: "Understanding Income",
                  lessonNumber: 1,
                );

                await addLessonToFirestore(
                  levelName: "Advanced",
                  unitName: "Investment Basics",
                  unitNumber: 1,
                  unitDescription:
                      "Learn how to create a investment portfolio.",
                  lessonName: "Understanding Income",
                  lessonNumber: 2,
                );

                await addLessonToFirestore(
                  levelName: "Advanced",
                  unitName: "Credit Basics",
                  unitNumber: 1,
                  unitDescription:
                      "Learn how to create a sustainable credit.",
                  lessonName: "Understanding Income",
                  lessonNumber: 3,
                );
                
                // Test fetch
                final fetched = await getPageInfoFromFirestore(
                  levelName: "Advanced",
                  unitNumber: 1,
                  lessonNumber: 1,
                  componentType: 'Concept',
                  pageNumber: 1,
                );
                print("Fetched page: $fetched");
              },
              child: const Text("Add Lesson Data"),
            ),
            const SizedBox(height: 30),
            Text("Fetched Page Data:\n\n$pageData"),
          ],
        ),
      ),
    );
  }
}
