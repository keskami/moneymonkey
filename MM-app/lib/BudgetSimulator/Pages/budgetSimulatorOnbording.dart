import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';

class BudgetSimulatorOnboarding extends StatefulWidget {
  @override
  _BudgetSimulatorOnboardingState createState() =>
      _BudgetSimulatorOnboardingState();
}

class _BudgetSimulatorOnboardingState extends State<BudgetSimulatorOnboarding> {
  final List<TyperAnimatedText> animatedTexts = [
    TyperAnimatedText(
      'Great choice! In ‘Crush the Credit Card\nDebt, you’ll work on paying down a\n\$3,000 credit card balance at a 20%\ninterest rate.',
      speed: Duration(
          milliseconds: 5000 ~/
              'Great choice! In ‘Crush the Credit Card Debt,’ you’ll work on paying down a \$3,000 credit card balance at a 20% interest rate.'
                  .length),
    ),
    TyperAnimatedText(
      'Your goal is to reduce at least 50% of that\ndebt within three months while juggling\nrent, groceries, and other living expenses.\nLet’s show you around!',
      speed: Duration(
          milliseconds: 5000 ~/
              'Your goal is to reduce at least 50% of that debt within three months while juggling rent, groceries, and other living expenses. Let’s show you around!'
                  .length),
    ),
    TyperAnimatedText(
      'Each circle marks a special target\n—like paying \$300 above the\nminimum or staying under\n\$50/week for entertainment.',
      speed: Duration(
          milliseconds: 5000 ~/
              'Each circle marks a special target—like paying \$300 above the minimum or staying under \$50/week for entertainment.'
                  .length),
    ),
  ];

  bool isLoading = false;
  int? balance;
  int totalBanans = 0;
  bool firstTime = false;
  bool beginner = false;
  bool intermediate = false;
  bool advanced = false;
  bool eventFinished = false;
  bool showSecondText = false;
  int animatedTextIndex = 0;

  String? selectedScenario = '';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double webScreenWidthUnit = screenWidth / 1717;
    double webScreenHeightUnit = screenHeight / 2078;
    return firstTime
        ? Scaffold(
            body: Stack(
              children: [
                Container(
                  child: BudgetSimulator(
                    wellnessScore: 300,
                    name: 'Crush the Credit Card Debt',
                    checkingAccountBalance: 300,
                    savingsAccountBalance: 300,
                    creditCardDebt: 3000,
                    startingBalance: 600,
                    creditScore: 243,
                    APY: 3,
                    milestones: [
                      Milestone(
                          name: 'Debt Avalanche Start',
                          description:
                              'Pay \$300 above the minimum (\$200)\nduring Month 1, for a total of at least\n\$500 paid toward the card.',
                          goalAmount: 500,
                          goalType: 'Debt Reduction',
                          startDay: DateTime.now().day,
                          endDay: DateTime(DateTime.now().year,
                                  DateTime.now().month + 1, 1)
                              .day,
                          currentAmount: 100),
                      Milestone(
                          name: 'Build an Emergency Cushion',
                          description:
                              'By the end of Month 2, accumulate at\nleast 10% of your monthly income\n(\$250) in your savings account.',
                          goalAmount: 25,
                          goalType: 'Savings',
                          startDay: DateTime.now().day,
                          endDay: DateTime(DateTime.now().year,
                                  DateTime.now().month + 1, 1)
                              .day,
                          currentAmount: 17),
                      Milestone(
                          name: 'Two Weeks Under Budget',
                          description:
                              'Stay under \$50/week for entertainment\nand dining out for two weeks straight.',
                          goalAmount: 3,
                          goalType: 'Savings',
                          startDay: DateTime.now().day,
                          endDay: DateTime.now().add(Duration(days: 14)).day,
                          currentAmount: 14)
                    ],
                    expenses: [
                      Expense(
                          name: "Pay Day",
                          amount: -2000,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2025, 5, 1),
                          amountPaid: 0,
                          penalty: 0),
                      Expense(
                          name: "Pay Day",
                          amount: -2000,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2025, 5, 15),
                          amountPaid: 0,
                          penalty: 0),
                      Expense(
                          name: "Rent",
                          amount: 500,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2025, 5, 5),
                          amountPaid: 20,
                          penalty: 25),
                      Expense(
                          name: "Utilities",
                          amount: 200,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2025, 5, 10),
                          amountPaid: 0,
                          penalty: 25),
                      Expense(
                          name: "Transportation",
                          amount: 100,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2025, 5, 28),
                          amountPaid: 10,
                          penalty: 0),
                      Expense(
                          name: "CC Debt",
                          amount: 1000,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2025, 5, 25),
                          amountPaid: 0,
                          penalty: 0),
                      Expense(
                          name: "Groceries",
                          amount: 250,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2028, 5, 25),
                          amountPaid: 0,
                          penalty: 0),
                      Expense(
                          name: "Fitness",
                          amount: 0,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2028, 5, 25),
                          amountPaid: 0,
                          penalty: 0),
                      Expense(
                          name: "Entertainment",
                          amount: 0,
                          dueDateType: "Fixed",
                          dueDay: DateTime(2028, 5, 25),
                          amountPaid: 0,
                          penalty: 0),
                    ],
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height:
                            (animatedTextIndex >= 5 && animatedTextIndex != 12)
                                ? 0
                                : webScreenWidthUnit * 450,
                        width:
                            (animatedTextIndex >= 5 && animatedTextIndex != 12)
                                ? 0
                                : webScreenWidthUnit * 550,
                        child:
                            (animatedTextIndex >= 2 && animatedTextIndex != 12)
                                ? Container()
                                : Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                      ),
                      animatedTextIndex < 2
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: webScreenWidthUnit * 160,
                                    height: webScreenHeightUnit * 100,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Color.fromRGBO(79, 195, 247, 1),
                                    ),
                                    child: Center(
                                      child: Text("Minty",
                                          style: GoogleFonts.baloo2(
                                            fontSize: webScreenWidthUnit * 22,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          )),
                                    )),
                                SizedBox(
                                  height: webScreenHeightUnit * 20,
                                ),
                                Container(
                                    width: webScreenWidthUnit * 856,
                                    padding: EdgeInsets.fromLTRB(
                                        webScreenWidthUnit * 67,
                                        webScreenHeightUnit * 50,
                                        0,
                                        webScreenWidthUnit * 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: DefaultTextStyle(
                                            style: GoogleFonts.baloo2(
                                              fontSize: webScreenWidthUnit * 36,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AnimatedTextKit(
                                                  key: ValueKey<int>(
                                                      animatedTextIndex), // Ensures the widget rebuilds
                                                  animatedTexts: [
                                                    animatedTexts[
                                                        animatedTextIndex]
                                                  ],
                                                  isRepeatingAnimation: false,
                                                  onFinished: () {
                                                    setState(() {
                                                      eventFinished = true;
                                                    });
                                                    print("Animation Finished");
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (eventFinished) {
                                                animatedTextIndex++;
                                                eventFinished = false;
                                                if (animatedTextIndex >=
                                                    animatedTexts.length) {
                                                  firstTime = false;
                                                }
                                              }
                                            });
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0,
                                                  webScreenWidthUnit * 38, 0),
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                size: webScreenWidthUnit * 57,
                                                color: Color.fromRGBO(
                                                    79, 197, 247, 1),
                                              )),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  height: webScreenHeightUnit * 77,
                                ),
                              ],
                            )
                          : animatedTextIndex == 3
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            webScreenWidthUnit * 40,
                                            webScreenHeightUnit * 259,
                                            0,
                                            0),
                                        child: speechBubbleArrowRight(
                                          text:
                                              "Each circle marks a special target\n—like paying \$300 above the\nminimum or staying under \$50/\nweek for entertainment.",
                                          webScreenWidthUnit:
                                              webScreenWidthUnit,
                                          webScreenHeightUnit:
                                              webScreenHeightUnit,
                                          header: "Milestone Circles",
                                          height: 673,
                                          width: 462,
                                          onTap: () {
                                            setState(() {
                                              animatedTextIndex++;
                                            });
                                          },
                                          animatedTextIndex: animatedTextIndex,
                                        )),
                                  ],
                                )
                              : animatedTextIndex == 2
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                webScreenWidthUnit * 40,
                                                webScreenHeightUnit * 109,
                                                0,
                                                0),
                                            child: speechBubbleArrowRight(
                                              text:
                                                  "Tracks how close you are to that\n50% debt payoff. The bar fills as\nyou make extra payments on your\ncredit card.",
                                              webScreenWidthUnit:
                                                  webScreenWidthUnit,
                                              webScreenHeightUnit:
                                                  webScreenHeightUnit,
                                              header: "Goal Progress Bar",
                                              height: 673,
                                              width: 462,
                                              onTap: () {
                                                setState(() {
                                                  animatedTextIndex++;
                                                });
                                              },
                                              animatedTextIndex:
                                                  animatedTextIndex,
                                            )),
                                      ],
                                    )
                                  : animatedTextIndex == 4
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    webScreenWidthUnit * 40,
                                                    webScreenHeightUnit * 666,
                                                    0,
                                                    0),
                                                child: speechBubbleArrowRight(
                                                  text:
                                                      "These charts show how your\nmoney flows daily and breaks\ndown expenses by category. Keep\ntrack of both!",
                                                  webScreenWidthUnit:
                                                      webScreenWidthUnit,
                                                  webScreenHeightUnit:
                                                      webScreenHeightUnit,
                                                  header:
                                                      "Cash Flow and Spendings",
                                                  height: 673,
                                                  width: 462,
                                                  onTap: () {
                                                    setState(() {
                                                      animatedTextIndex++;
                                                    });
                                                  },
                                                  animatedTextIndex:
                                                      animatedTextIndex,
                                                )),
                                          ],
                                        )
                                      : animatedTextIndex == 5
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.fromLTRB(
                                                        webScreenWidthUnit *
                                                            216,
                                                        webScreenHeightUnit *
                                                            266,
                                                        webScreenWidthUnit * 0,
                                                        0),
                                                    child:
                                                        speechBubbleArrowRight(
                                                      text:
                                                          "Each day lets you budget for bills\nand random events. Rent is due by\nDay 5, utilities by Day 10, credit\ncard by Day 25.",
                                                      webScreenWidthUnit:
                                                          webScreenWidthUnit,
                                                      webScreenHeightUnit:
                                                          webScreenHeightUnit,
                                                      header:
                                                          "Cash Flow and Spendings",
                                                      height: 673,
                                                      width: 462,
                                                      onTap: () {
                                                        setState(() {
                                                          animatedTextIndex++;
                                                        });
                                                      },
                                                      animatedTextIndex:
                                                          animatedTextIndex,
                                                    )),
                                              ],
                                            )
                                          : animatedTextIndex == 6
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.fromLTRB(
                                                            webScreenWidthUnit *
                                                                369,
                                                            webScreenHeightUnit *
                                                                62,
                                                            webScreenWidthUnit *
                                                                0,
                                                            0),
                                                        child:
                                                            speechBubbleArrowRight(
                                                          text:
                                                              "Hit ‘Allocate Funds’ or ‘Next Day’ to\nmove forward. Double-check your\nallocations first—no going back!",
                                                          webScreenWidthUnit:
                                                              webScreenWidthUnit,
                                                          webScreenHeightUnit:
                                                              webScreenHeightUnit,
                                                          header:
                                                              "Allocate Funds Button",
                                                          height: 673,
                                                          width: 462,
                                                          onTap: () {
                                                            setState(() {
                                                              animatedTextIndex++;
                                                            });
                                                          },
                                                          animatedTextIndex:
                                                              animatedTextIndex,
                                                        )),
                                                  ],
                                                )
                                              : animatedTextIndex == 7
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding: EdgeInsets.fromLTRB(
                                                                webScreenWidthUnit *
                                                                    112,
                                                                webScreenHeightUnit *
                                                                    200,
                                                                webScreenWidthUnit *
                                                                    0,
                                                                0),
                                                            child:
                                                                speechBubbleArrowRight(
                                                              text:
                                                                  "Click a day, then use plus/minus to\nadd money to categories or\npay extra on your credit card.",
                                                              webScreenWidthUnit:
                                                                  webScreenWidthUnit,
                                                              webScreenHeightUnit:
                                                                  webScreenHeightUnit,
                                                              header:
                                                                  "Daily Fund Allocation",
                                                              height: 673,
                                                              width: 462,
                                                              onTap: () {
                                                                setState(() {
                                                                  animatedTextIndex++;
                                                                });
                                                              },
                                                              animatedTextIndex:
                                                                  animatedTextIndex,
                                                            )),
                                                      ],
                                                    )
                                                  : animatedTextIndex == 8
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                                padding: EdgeInsets.fromLTRB(
                                                                    webScreenWidthUnit *
                                                                        153,
                                                                    webScreenHeightUnit *
                                                                        707,
                                                                    webScreenWidthUnit *
                                                                        0,
                                                                    0),
                                                                child:
                                                                    speechBubbleArrowDown(
                                                                  text:
                                                                      "I’ll alert you if you’re missing a bill\nor overspending. Keep an eye out\nfor helpful reminders.",
                                                                  webScreenWidthUnit:
                                                                      webScreenWidthUnit,
                                                                  webScreenHeightUnit:
                                                                      webScreenHeightUnit,
                                                                  header:
                                                                      "Random Events",
                                                                  height: 673,
                                                                  width: 462,
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      animatedTextIndex++;
                                                                    });
                                                                  },
                                                                  animatedTextIndex:
                                                                      animatedTextIndex,
                                                                )),
                                                          ],
                                                        )
                                                      : animatedTextIndex == 9
                                                          ? Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                    padding: EdgeInsets.fromLTRB(
                                                                        webScreenWidthUnit *
                                                                            290,
                                                                        webScreenHeightUnit *
                                                                            313,
                                                                        webScreenWidthUnit *
                                                                            0,
                                                                        0),
                                                                    child:
                                                                        speechBubbleArrowLeft(
                                                                      text:
                                                                          "You get \$1,250 on Day 1 and Day 15\neach month. Make sure you cover\nall fixed bills before fun stuff.",
                                                                      webScreenWidthUnit:
                                                                          webScreenWidthUnit,
                                                                      webScreenHeightUnit:
                                                                          webScreenHeightUnit,
                                                                      header:
                                                                          "Income & Expense",
                                                                      height:
                                                                          673,
                                                                      width:
                                                                          462,
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          animatedTextIndex++;
                                                                        });
                                                                      },
                                                                      animatedTextIndex:
                                                                          animatedTextIndex,
                                                                    )),
                                                              ],
                                                            )
                                                          : animatedTextIndex ==
                                                                  10
                                                              ? Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            webScreenWidthUnit *
                                                                                1099,
                                                                            webScreenHeightUnit *
                                                                                103,
                                                                            webScreenWidthUnit *
                                                                                0,
                                                                            0),
                                                                        child:
                                                                            speechBubbleArrowRight(
                                                                          text:
                                                                              "Your card’s 20% APR adds up\nmonthly. Paying debt early lowers\nthe balance—and reduces interest.",
                                                                          webScreenWidthUnit:
                                                                              webScreenWidthUnit,
                                                                          webScreenHeightUnit:
                                                                              webScreenHeightUnit,
                                                                          header:
                                                                              "Interest Calculation",
                                                                          height:
                                                                              673,
                                                                          width:
                                                                              462,
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              animatedTextIndex++;
                                                                            });
                                                                          },
                                                                          animatedTextIndex:
                                                                              animatedTextIndex,
                                                                        )),
                                                                  ],
                                                                )
                                                              : animatedTextIndex ==
                                                                      11
                                                                  ? Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                webScreenWidthUnit * 122,
                                                                                webScreenHeightUnit * 96,
                                                                                webScreenWidthUnit * 0,
                                                                                0),
                                                                            child: speechBubbleArrowRight(
                                                                              text: "Miss a due date? \$25 late fee. Need\nextra cash? High-interest in-game\nloan. Pay early? Get a small\ninterest discount!",
                                                                              webScreenWidthUnit: webScreenWidthUnit,
                                                                              webScreenHeightUnit: webScreenHeightUnit,
                                                                              header: "Penalties & Rewards",
                                                                              height: 673,
                                                                              width: 462,
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  animatedTextIndex++;
                                                                                });
                                                                              },
                                                                              animatedTextIndex: animatedTextIndex,
                                                                            )),
                                                                      ],
                                                                    )
                                                                  : animatedTextIndex ==
                                                                          12
                                                                      ? Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                                width: webScreenWidthUnit * 160,
                                                                                height: webScreenHeightUnit * 100,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                                  color: Color.fromRGBO(79, 195, 247, 1),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text("Minty",
                                                                                      style: GoogleFonts.baloo2(
                                                                                        fontSize: webScreenWidthUnit * 22,
                                                                                        fontWeight: FontWeight.w700,
                                                                                        color: Colors.white,
                                                                                      )),
                                                                                )),
                                                                            SizedBox(
                                                                              height: webScreenHeightUnit * 20,
                                                                            ),
                                                                            Container(
                                                                                width: webScreenWidthUnit * 856,
                                                                                padding: EdgeInsets.fromLTRB(webScreenWidthUnit * 67, webScreenHeightUnit * 50, 0, webScreenWidthUnit * 0),
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: DefaultTextStyle(
                                                                                        style: GoogleFonts.baloo2(
                                                                                          fontSize: webScreenWidthUnit * 36,
                                                                                          color: Colors.black,
                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            AnimatedTextKit(
                                                                                              key: ValueKey<int>(animatedTextIndex), // Ensures the widget rebuilds
                                                                                              animatedTexts: [
                                                                                                TyperAnimatedText(
                                                                                                  'That’s it! Manage your bill, handle\nsurprises, and chip away at that debt.\nGood luck!',
                                                                                                  speed: Duration(milliseconds: 5000 ~/ 'That’s it! Manage your bills, handle\nsurprises, and chip away at that debt.\nGood luck!'.length),
                                                                                                )
                                                                                              ],
                                                                                              isRepeatingAnimation: false,
                                                                                              onFinished: () {
                                                                                                setState(() {
                                                                                                  eventFinished = true;
                                                                                                });
                                                                                                print("Animation Finished");
                                                                                              },
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          if (eventFinished) {
                                                                                            animatedTextIndex++;
                                                                                            eventFinished = false;
                                                                                            if (animatedTextIndex >= animatedTexts.length) {
                                                                                              firstTime = false;
                                                                                              animatedTextIndex++;
                                                                                            }
                                                                                          }
                                                                                        });
                                                                                      },
                                                                                      child: Padding(
                                                                                          padding: EdgeInsets.fromLTRB(0, 0, webScreenWidthUnit * 38, 0),
                                                                                          child: Icon(
                                                                                            Icons.arrow_drop_down,
                                                                                            size: webScreenWidthUnit * 57,
                                                                                            color: Color.fromRGBO(79, 197, 247, 1),
                                                                                          )),
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                            SizedBox(
                                                                              height: webScreenHeightUnit * 77,
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : animatedTextIndex ==
                                                                              3
                                                                          ? Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                    padding: EdgeInsets.fromLTRB(webScreenWidthUnit * 40, webScreenHeightUnit * 259, 0, 0),
                                                                                    child: speechBubbleArrowRight(
                                                                                      text: "Each circle marks a special target\n—like paying \$300 above the\nminimum or staying under \$50/\nweek for entertainment",
                                                                                      webScreenWidthUnit: webScreenWidthUnit,
                                                                                      webScreenHeightUnit: webScreenHeightUnit,
                                                                                      header: "Milestone Circles",
                                                                                      height: 673,
                                                                                      width: 462,
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          animatedTextIndex++;
                                                                                        });
                                                                                      },
                                                                                      animatedTextIndex: animatedTextIndex,
                                                                                    )),
                                                                              ],
                                                                            )
                                                                          : BudgetSimulatorOnboarding()
                    ],
                  ),
                ),
              ],
            ),
          )
        : BudgetSimulator(
            wellnessScore: 300,
            name: 'Crush the Credit Card Debt',
            checkingAccountBalance: 300,
            savingsAccountBalance: 0,
            creditCardDebt: 3000,
            startingBalance: 600,
            creditScore: 243,
            APY: 3,
            milestones: [
              Milestone(
                  name: 'Debt Avalanche Start',
                  description:
                      'Pay \$300 above the minimum (\$200)\nduring Month 1, for a total of at least\n\$500 paid toward the card.',
                  goalAmount: 500,
                  goalType: 'Debt Reduction',
                  startDay: DateTime.now().day,
                  endDay:
                      DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
                          .day,
                  currentAmount: 0),
              Milestone(
                  name: 'Build an Emergency Cushion',
                  description:
                      'By the end of Month 2, accumulate at\nleast 10% of your monthly income\n(\$250) in your savings account.',
                  goalAmount: 250,
                  goalType: 'Savings',
                  startDay: DateTime.now().day,
                  endDay:
                      DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
                          .day,
                  currentAmount: 0),
              Milestone(
                  name: 'Two Weeks Under Budget',
                  description:
                      'Stay under \$50/week for entertainment\nand dining out for two weeks straight.',
                  goalAmount: 14,
                  goalType: 'Savings',
                  startDay: DateTime.now().day,
                  endDay: DateTime.now().add(Duration(days: 14)).day,
                  currentAmount: 0)
            ],
            expenses: [
              Expense(
                  name: "Pay Day",
                  amount: -2000,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2025, 5, 1),
                  amountPaid: 0,
                  penalty: 0),
              Expense(
                  name: "Pay Day",
                  amount: -2000,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2025, 5, 15),
                  amountPaid: 0,
                  penalty: 0),
              Expense(
                  name: "Rent",
                  amount: 500,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2025, 5, 5),
                  amountPaid: 20,
                  penalty: 25),
              Expense(
                  name: "Utilities",
                  amount: 200,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2025, 10, 10),
                  amountPaid: 0,
                  penalty: 25),
              Expense(
                  name: "Transportation",
                  amount: 100,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2026, 5, 28),
                  amountPaid: 10,
                  penalty: 0),
              Expense(
                  name: "CC Debt",
                  amount: 200,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2025, 5, 25),
                  amountPaid: 0,
                  penalty: 100),
              Expense(
                  name: "Groceries",
                  amount: 250,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2028, 5, 25),
                  amountPaid: 0,
                  penalty: 0),
              Expense(
                  name: "Fitness",
                  amount: 0,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2028, 5, 25),
                  amountPaid: 0,
                  penalty: 0),
              Expense(
                  name: "Entertainment",
                  amount: 0,
                  dueDateType: "Fixed",
                  dueDay: DateTime(2028, 5, 25),
                  amountPaid: 0,
                  penalty: 0),
            ],
          );
  }
}

Widget speechBubbleArrowLeft({
  required String text,
  required double webScreenHeightUnit,
  required double webScreenWidthUnit,
  required String header,
  required Function() onTap,
  required int animatedTextIndex,
  bool eventFinished = false,
  required double height,
  required double width,
}) {
  return Center(
    child: CustomPaint(
      painter: _SpeechBubblePainterLeft(),
      child: SizedBox(
        width: width * webScreenWidthUnit, // Set the bubble width
        height: height * webScreenHeightUnit, // Set the bubble height
        child: Padding(
            padding: EdgeInsets.fromLTRB(webScreenWidthUnit * 29,
                webScreenHeightUnit * 40, 0, webScreenWidthUnit * 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: GoogleFonts.baloo2(
                    fontSize: webScreenWidthUnit * 23,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(79, 195, 247, 1),
                  ),
                ),
                SizedBox(
                  height: webScreenHeightUnit * 15,
                ),
                AnimatedTextKit(
                  key: ValueKey<int>(animatedTextIndex),
                  animatedTexts: [
                    TyperAnimatedText(
                      text,
                      textStyle: GoogleFonts.baloo2(
                        fontSize: webScreenWidthUnit * 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      speed: Duration(milliseconds: 5000 ~/ text.length),
                    )
                  ],
                  isRepeatingAnimation: false,
                  onFinished: () {
                    eventFinished = true;
                  },
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, webScreenWidthUnit * 40,
                        webScreenHeightUnit * 35),
                    child: GestureDetector(
                        onTap: () {
                          if (eventFinished) {
                            onTap();
                          }
                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                height: webScreenHeightUnit * 85,
                                width: webScreenWidthUnit * 137,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(79, 195, 247, 1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: GoogleFonts.baloo2(
                                      fontSize: webScreenWidthUnit * 23,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                )))))
              ],
            )),
      ),
    ),
  );
}

class _SpeechBubblePainterLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(20, 0) // Top-left corner
      ..lineTo(size.width - 10, 0) // Top-right corner
      ..quadraticBezierTo(size.width, 0, size.width, 10) // Top-right curve
      ..lineTo(size.width, size.height - 10) // Right side
      ..quadraticBezierTo(size.width, size.height, size.width - 10,
          size.height) // Bottom-right curve
      ..lineTo(20, size.height) // Bottom-left corner
      ..quadraticBezierTo(
          10, size.height, 10, size.height - 10) // Bottom-left curve
      ..lineTo(10, size.height / 2 + 15) // Left side, after triangle
      ..lineTo(-5, size.height / 2) // Triangle tip
      ..lineTo(10, size.height / 2 - 15) // Left side, before triangle
      ..lineTo(10, 10) // Continue top-left
      ..quadraticBezierTo(10, 0, 20, 0); // Top-left curve

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget speechBubbleArrowRight({
  required String text,
  required double webScreenHeightUnit,
  required double webScreenWidthUnit,
  required String header,
  required Function() onTap,
  required int animatedTextIndex,
  bool eventFinished = false,
  required double height,
  required double width,
}) {
  return Center(
    child: CustomPaint(
      painter: _SpeechBubblePainter(),
      child: SizedBox(
        width: width * webScreenWidthUnit, // Set the bubble width
        height: height * webScreenHeightUnit, // Set the bubble height
        child: Padding(
            padding: EdgeInsets.fromLTRB(webScreenWidthUnit * 49,
                webScreenHeightUnit * 40, 0, webScreenWidthUnit * 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: GoogleFonts.baloo2(
                    fontSize: webScreenWidthUnit * 23,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(79, 195, 247, 1),
                  ),
                ),
                SizedBox(
                  height: webScreenHeightUnit * 15,
                ),
                AnimatedTextKit(
                  key: ValueKey<int>(animatedTextIndex),
                  animatedTexts: [
                    TyperAnimatedText(
                      text,
                      textStyle: GoogleFonts.baloo2(
                        fontSize: webScreenWidthUnit * 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      speed: Duration(milliseconds: 5000 ~/ text.length),
                    )
                  ],
                  isRepeatingAnimation: false,
                  onFinished: () {
                    eventFinished = true;
                  },
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, webScreenWidthUnit * 40,
                        webScreenHeightUnit * 35),
                    child: GestureDetector(
                        onTap: () {
                          if (eventFinished) {
                            onTap();
                          }
                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                height: webScreenHeightUnit * 85,
                                width: webScreenWidthUnit * 137,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(79, 195, 247, 1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: GoogleFonts.baloo2(
                                      fontSize: webScreenWidthUnit * 23,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                )))))
              ],
            )),
      ),
    ),
  );
}

class _SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(10, 0) // Top-left corner
      ..lineTo(size.width - 20, 0) // Top-right corner
      ..quadraticBezierTo(
          size.width - 10, 0, size.width - 10, 10) // Top-right curve
      ..lineTo(
          size.width - 10, size.height / 2 - 15) // Right side, before triangle
      ..lineTo(size.width + 15, size.height / 2) // Triangle tip
      ..lineTo(
          size.width - 10, size.height / 2 + 15) // Right side, after triangle
      ..lineTo(size.width - 10, size.height - 10) // Continue bottom-right
      ..quadraticBezierTo(size.width - 10, size.height, size.width - 20,
          size.height) // Bottom-right curve
      ..lineTo(10, size.height) // Bottom-left corner
      ..quadraticBezierTo(
          0, size.height, 0, size.height - 10) // Bottom-left curve
      ..lineTo(0, 10) // Left side
      ..quadraticBezierTo(0, 0, 10, 0); // Top-left curve

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget speechBubbleArrowDown({
  required String text,
  required double webScreenHeightUnit,
  required double webScreenWidthUnit,
  required String header,
  required Function() onTap,
  required int animatedTextIndex,
  bool eventFinished = false,
  required double height,
  required double width,
}) {
  return Center(
    child: CustomPaint(
      painter: SpeechBubblePainterDown(),
      child: SizedBox(
        width: width * webScreenWidthUnit, // Set the bubble width
        height: height * webScreenHeightUnit, // Set the bubble height
        child: Padding(
            padding: EdgeInsets.fromLTRB(webScreenWidthUnit * 49,
                webScreenHeightUnit * 40, 0, webScreenWidthUnit * 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: GoogleFonts.baloo2(
                    fontSize: webScreenWidthUnit * 23,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(79, 195, 247, 1),
                  ),
                ),
                SizedBox(
                  height: webScreenHeightUnit * 15,
                ),
                AnimatedTextKit(
                  key: ValueKey<int>(animatedTextIndex),
                  animatedTexts: [
                    TyperAnimatedText(
                      text,
                      textStyle: GoogleFonts.baloo2(
                        fontSize: webScreenWidthUnit * 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      speed: Duration(milliseconds: 5000 ~/ text.length),
                    )
                  ],
                  isRepeatingAnimation: false,
                  onFinished: () {
                    eventFinished = true;
                  },
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, webScreenWidthUnit * 40,
                        webScreenHeightUnit * 35),
                    child: GestureDetector(
                        onTap: () {
                          if (eventFinished) {
                            onTap();
                          }
                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                height: webScreenHeightUnit * 85,
                                width: webScreenWidthUnit * 137,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(79, 195, 247, 1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: GoogleFonts.baloo2(
                                      fontSize: webScreenWidthUnit * 23,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                )))))
              ],
            )),
      ),
    ),
  );
}

class SpeechBubblePainterDown extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(10, 0) // Top-left corner
      ..lineTo(size.width - 10, 0) // Top-right corner
      ..quadraticBezierTo(size.width, 0, size.width, 10) // Top-right curve
      ..lineTo(size.width, size.height - 20) // Right side
      ..quadraticBezierTo(size.width, size.height - 10, size.width - 10,
          size.height - 10) // Bottom-right curve
      ..lineTo(size.width / 2 + 15, size.height - 10)
      ..lineTo(size.width / 2, size.height + 15) // Triangle tip
      ..lineTo(size.width / 2 - 15, size.height - 10)
      ..lineTo(10, size.height - 10) // Bottom-left corner
      ..quadraticBezierTo(
          0, size.height - 10, 0, size.height - 20) // Bottom-left curve
      ..lineTo(0, 10) // Left side
      ..quadraticBezierTo(0, 0, 10, 0); // Top-left curve

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
