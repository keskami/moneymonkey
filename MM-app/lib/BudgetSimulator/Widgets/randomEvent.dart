import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';

class RandomEventPop extends StatefulWidget {
  final RandomEvent event;
  Function onConfirm;

  RandomEventPop({
    required this.event,
    required this.onConfirm,
  });

  @override
  _RandomEventPopState createState() => _RandomEventPopState();
}

class _RandomEventPopState extends State<RandomEventPop> {
  bool oneSelcted = false;
  bool twoSelected = false;
  bool threeSelected = false;

  String option1Title = '';
  String option1SubTitle = '';
  String Cost11Name = '';
  int cost11Cost = 0;
  String Cost12Name = '';
  int cost12Cost = 0;
  int option1Cost = 0;

  String option2Title = '';
  String option2SubTitle = '';
  String Cost21Name = '';
  int cost21Cost = 0;
  String Cost22Name = '';
  int cost22Cost = 0;
  int option2Cost = 0;

  String option3Title = '';
  String option3SubTitle = '';
  String Cost31Name = '';
  int cost31Cost = 0;
  String Cost32Name = '';
  int cost32Cost = 0;
  int option3Cost = 0;

  String option1Source = '';
  String option2Source = '';
  String option3Source = '';

  String option1LifeStyle = '';
  String option2LifeStyle = '';
  String option3LifeStyle = '';

  bool isGood = false;

  String finalSource = '';
  int finalCost = 0;

  String effect1 = '';
  int effect1Amount = 0;

  String effect2 = '';
  int effect2Amount = 0;
  String lifeStyle = '';

  void getInfo(RandomEvent event) async {
    if(event.name == "Cracked Tooth"){
      setState(() {
        option1Title = 'Premium Dental Work';
        option1SubTitle = 'Visit a highly-rated dentist for immediate treatment';

        Cost11Name = 'Body';
        cost11Cost = 9;

        Cost12Name = 'Mind';
        cost12Cost = 4;

        option1Cost = -800;
        option1Source = "CC";
        option1LifeStyle = "Wellness-Focused";


        option2Title = 'Insurance-Covered Basic Fix';
        option2SubTitle =
            'Use your basic insurance coverage at an in-network provider';

        Cost21Name = 'Body';
        cost21Cost = 6;
        Cost22Name = 'Mind';
        cost22Cost = 2;
        option2Source = "CC";

        option2Cost = -350;
        option2LifeStyle = "Balanced";

        option3Title = 'Temporary Relief Plan';
        option3SubTitle =
            'Get temporary pain relief and postpone major work';

        Cost31Name = 'Body';
        cost31Cost = 3;
        Cost32Name = 'Mind';
        cost32Cost = -4;
        option3Source = "CC";

        option3Cost = -120;
        option3LifeStyle = " Frugal & Savings-Focused";

      });

    }

    if(event.name == "Forgotten Refund"){
      setState(() {
        option1Title = 'Retirement Boost';
        option1SubTitle = 'Add the entire amount to your savings account';

        Cost11Name = 'Mind';
        cost11Cost = 7;

        Cost12Name = 'Credit Score';
        cost12Cost = 2;

        option1Cost = 600;
        option1Source = "Savings";
        option1LifeStyle = "Frugal & Savings-Focused";


        option2Title = 'Debt Reduction';
        option2SubTitle =
            'Pay down your high-interest credit card debt immediately';

        Cost21Name = 'Mind';
        cost21Cost = 5;
        Cost22Name = 'Credit Score';
        cost22Cost = 4;
        option2Source = "CC";

        option2Cost = 600;
        option2LifeStyle = "Balanced";

        option3Title = 'Split Decision';
        option3SubTitle =
            'Use half for a social weekend trip and half for your emergency fund';

        Cost31Name = 'Social';
        cost31Cost = 4;
        Cost32Name = 'Mind';
        cost32Cost = 2;
        option3Source = "Savings";

        option3Cost = 300;
        option3LifeStyle = "Social & Leisure-Focused";

      });

    }


     if(event.name == "Project Excellence"){
      setState(() {
        option1Title = 'Immediate Bonus';
        option1SubTitle = 'Accept a one-time \$400 performance bonus';

        Cost11Name = 'Mind';
        cost11Cost = 4;

        Cost12Name = 'Social';
        cost12Cost = -2;

        option1Cost = 400;
        option1Source = "Savings";
        option1LifeStyle = "Frugal & Savings-Focused";


        option2Title = 'Skills Investment';
        option2SubTitle =
            'Select \$700 in professional certification training';

        Cost21Name = 'Mind';
        cost21Cost = 6;
        Cost22Name = 'Social';
        cost22Cost = -2;
        option2Source = "CC";

        option2Cost = 0;
        option2LifeStyle = "Career-Focused";

        option3Title = 'Team Celebration';
        option3SubTitle =
            'Request a \$500 team lunch and social event to celebrate';

        Cost31Name = 'Social';
        cost31Cost = 8;
        Cost32Name = 'Mind';
        cost32Cost = 2;
        option3Source = "Savings";

        option3Cost = 0;
        option3LifeStyle = "Social & Leisure-Focused";

      });

    }



   
  }

  @override
  void initState() {
    super.initState();
    getInfo(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeightUnit = MediaQuery.of(context).size.height / 1080;
    double screenWidthUnit = MediaQuery.of(context).size.width / 1920;
    return Container(
      height: screenHeightUnit * 1200,
      width: screenWidthUnit * 1100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeightUnit * 45,
          ),
          Image.network(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FUntitled%20design%20-%202025-02-22T131030.056%201.png?alt=media&token=5b1ec022-889e-4fb7-ada6-9fd88ca64519",
              height: screenHeightUnit * 228),
          SizedBox(
            height: screenHeightUnit * 15,
          ),
          Text(
            widget.event.name,
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 50,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: screenHeightUnit * 5,
          ),
          Text(
            widget.event.description,
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 25,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(108, 108, 108, 1),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: screenHeightUnit * 46,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeightUnit * 430,
                width: screenWidthUnit * 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: RandomOption(
                  onTap: () {
                    if (oneSelcted) {
                      setState(() {
                        oneSelcted = false;
                      });
                    } else {
                      setState(() {
                        oneSelcted = true;
                        twoSelected = false;
                        threeSelected = false;
                      });
                    }
                  },
                  screenHeightUnit: screenHeightUnit,
                  screenWidthUnit: screenWidthUnit,
                  title: option1Title,
                  subtitle: option1SubTitle,
                  cost: option1Cost,
                  effect1Name: Cost11Name,
                  effect2Name: Cost12Name,
                  effect1Cost: cost11Cost,
                  effect2Cost: cost12Cost,
                  selected: oneSelcted,
                  Source: option1Source,
                ),
              ),
              SizedBox(
                width: screenWidthUnit * 20,
              ),
              Container(
                height: screenHeightUnit * 430,
                width: screenWidthUnit * 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: RandomOption(
                    onTap: () {
                      if (twoSelected) {
                        setState(() {
                          twoSelected = false;
                        });
                      } else {
                        setState(() {
                          twoSelected = true;
                          oneSelcted = false;
                          threeSelected = false;
                        });
                      }
                    },
                    screenHeightUnit: screenHeightUnit,
                    screenWidthUnit: screenWidthUnit,
                    title: option2Title,
                    subtitle: option2SubTitle,
                    cost: option2Cost,
                    effect1Name: Cost21Name,
                    effect2Name: Cost22Name,
                    effect1Cost: cost21Cost,
                    effect2Cost: cost22Cost,
                    selected: twoSelected,
                    Source: option2Source),
              ),
               SizedBox(
                width: screenWidthUnit * 20,
              ),
              Container(
                height: screenHeightUnit * 430,
                width: screenWidthUnit * 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: RandomOption(
                    onTap: () {
                      if (threeSelected) {
                        setState(() {
                          threeSelected = false;
                        });
                      } else {
                        setState(() {
                          threeSelected = true;
                          oneSelcted = false;
                          twoSelected = false;
                        });
                      }
                    },
                    screenHeightUnit: screenHeightUnit,
                    screenWidthUnit: screenWidthUnit,
                    title: option3Title,
                    subtitle: option3SubTitle,
                    cost: option3Cost,
                    effect1Name: Cost31Name,
                    effect2Name: Cost32Name,
                    effect1Cost: cost31Cost,
                    effect2Cost: cost32Cost,
                    selected: threeSelected,
                    Source: option3Source),
              ),
            ],
          ),
          SizedBox(
            height: screenHeightUnit * 50,
          ),
          GestureDetector(
            onTap: () {
              if (oneSelcted || twoSelected || threeSelected) {
                if (oneSelcted) {
                  finalSource = option1Source;
                  finalCost = option1Cost;
                  effect1 = Cost11Name;
                  effect1Amount = cost11Cost;
                  effect2 = Cost12Name;
                  effect2Amount = cost12Cost;
                  lifeStyle = option1LifeStyle;

                  RandomEventTaken randomEventTaken = RandomEventTaken(
                      name: "Place Holder Name",
                      choiceTaken: "Place Holder Choice",
                      discription: "Place Holder Discription",
                      trigerDay: widget.event.trigerDay,
                      moneyEffect: finalCost,
                      effect1: effect1,
                      effect1Amount: effect1Amount,
                      effect2: effect2,
                      effect2Amount: effect2Amount);
                  widget.onConfirm(randomEventTaken, finalSource, finalCost,
                      effect1, effect1Amount, effect2, effect2Amount, lifeStyle);
                } else if(twoSelected) {
                  finalSource = option2Source;
                  finalCost = option2Cost;
                  effect1 = Cost21Name;
                  effect1Amount = cost21Cost;
                  effect2 = Cost22Name;
                  effect2Amount = cost22Cost;
                    lifeStyle = option2LifeStyle;
                  RandomEventTaken randomEventTaken = RandomEventTaken(
                      name: "Place Holder Name",
                      choiceTaken: "Place Holder Choice",
                      discription: "Place Holder Discription",
                      trigerDay: widget.event.trigerDay,
                      moneyEffect: finalCost,
                      effect1: effect1,
                      effect1Amount: effect1Amount,
                      effect2: effect2,
                      effect2Amount: effect2Amount);
                  widget.onConfirm(randomEventTaken, finalSource, finalCost,
                      effect1, effect1Amount, effect2, effect2Amount, lifeStyle);
                }else{
                  finalSource = option3Source;
                  finalCost = option3Cost;
                  effect1 = Cost31Name;
                  effect1Amount = cost31Cost;
                  effect2 = Cost32Name;
                  effect2Amount = cost32Cost;
                    lifeStyle = option3LifeStyle;
                  RandomEventTaken randomEventTaken = RandomEventTaken(
                      name: "Place Holder Name",
                      choiceTaken: "Place Holder Choice",
                      discription: "Place Holder Discription",
                      trigerDay: widget.event.trigerDay,
                      moneyEffect: finalCost,
                      effect1: effect1,
                      effect1Amount: effect1Amount,
                      effect2: effect2,
                      effect2Amount: effect2Amount);
                  widget.onConfirm(randomEventTaken, finalSource, finalCost,
                      effect1, effect1Amount, effect2, effect2Amount,lifeStyle);

                }
              }
            },
            child: Container(
              height: screenHeightUnit * 73,
              width: screenWidthUnit * 307,
              decoration: BoxDecoration(
                  color: (oneSelcted || twoSelected || threeSelected)
                      ? Color.fromRGBO(0, 127, 255, 1)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(7)),
              child: Center(
                child: Text(
                  "Continue",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 20,
                    fontWeight: FontWeight.w600,
                    color: (oneSelcted || twoSelected|| threeSelected)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RandomOption extends StatefulWidget {
  final Function onTap;
  final double screenHeightUnit;
  final double screenWidthUnit;
  final String title;
  final String subtitle;
  final int cost;
  final String effect1Name;
  final String effect2Name;
  final int effect1Cost;
  final int effect2Cost;
  bool selected;
  String Source;

  RandomOption({
    required this.onTap,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.title,
    required this.subtitle,
    required this.cost,
    required this.effect1Name,
    required this.effect2Name,
    required this.effect1Cost,
    required this.effect2Cost,
    required this.selected,
    required this.Source,
  });

  @override
  _RandomOptionState createState() => _RandomOptionState();
}

class _RandomOptionState extends State<RandomOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
          height: widget.screenHeightUnit * 430,
          width: widget.screenWidthUnit * 300,
          decoration: BoxDecoration(
            color: widget.selected
                ? Color.fromRGBO(0, 127, 255, 1)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.screenWidthUnit * 30,
                top: widget.screenHeightUnit * 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenHeightUnit * 35,
                    fontWeight: FontWeight.w600,
                    color: widget.selected ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: widget.screenHeightUnit * 8,
                ),
                Text(
                  widget.subtitle,
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenHeightUnit * 22,
                    fontWeight: FontWeight.w500,
                    color: widget.selected ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: widget.screenHeightUnit * 20,
                ),
                Text(
                  "\$${widget.cost}",
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenHeightUnit * 42,
                    fontWeight: FontWeight.w500,
                    color: widget.cost > 0
                        ? Color.fromRGBO(0, 199, 129, 1)
                        : widget.cost < 0
                            ? Color.fromRGBO(255, 0, 0, 1)
                            : widget.selected
                                ? Colors.white
                                : Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: widget.screenHeightUnit * 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: widget.screenHeightUnit * 40,
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.effect1Cost > 0
                                ? Color.fromRGBO(242, 255, 245, 1)
                                : Color.fromRGBO(255, 243, 243, 1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: widget.effect1Cost > 0
                                  ?  Color.fromRGBO(0, 199, 129, 1)
                                      : Color.fromRGBO(255, 0, 0, 1),
                              width: 1,

                            )
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: widget.screenWidthUnit * 18),
                              Text(
                                '${widget.effect1Name}: ',
                                style: GoogleFonts.baloo2(
                                  fontSize: widget.screenHeightUnit * 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${widget.effect1Cost}',
                                style: GoogleFonts.baloo2(
                                  fontSize: widget.screenHeightUnit * 22,
                                  fontWeight: FontWeight.w500,
                                  color: widget.effect1Cost > 0
                                      ? Color.fromRGBO(0, 199, 129, 1)
                                      : Color.fromRGBO(255, 0, 0, 1),
                                ),
                              ),
                              SizedBox(width: widget.screenWidthUnit * 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.screenHeightUnit * 15,
                    ),
                    SizedBox(
                      height: widget.screenHeightUnit * 40,
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.effect2Cost > 0
                                ? Color.fromRGBO(242, 255, 245, 1)
                                : Color.fromRGBO(255, 243, 243, 1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: widget.effect2Cost > 0
                                  ? Color.fromRGBO(30, 213, 58, 1)
                                  : Color.fromRGBO(243, 52, 52, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: widget.screenWidthUnit * 18),
                              Text(
                                '${widget.effect2Name}: ',
                                style: GoogleFonts.baloo2(
                                  fontSize: widget.screenHeightUnit * 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${widget.effect2Cost}',
                                style: GoogleFonts.baloo2(
                                  fontSize: widget.screenHeightUnit * 22,
                                  fontWeight: FontWeight.w500,
                                  color: widget.effect2Cost > 0
                                      ? Color.fromRGBO(0, 199, 129, 1)
                                      : Color.fromRGBO(255, 0, 0, 1),
                                ),
                              ),
                              SizedBox(width: widget.screenWidthUnit * 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}












//  if (type == "Car Repair Surprise") {
    //   setState(() {
    //     option1Title = 'Pay for Repairs in Full';
    //     option1SubTitle = 'You cover the entire repair cost using cash.';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = 2;

    //     Cost12Name = 'Physical Health';
    //     cost12Cost = -10;

    //     option1Cost = -250;
    //     option1Source = "CC";

    //     option2Title = 'Take Public Transportation';
    //     option2SubTitle =
    //         'You skip the repair and instead take public transit.';

    //     Cost21Name = 'Credit Score';
    //     cost21Cost = 1;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = 15;
    //     option2Source = "Cash";

    //     option2Cost = 0;
    //   });
    // } else if (type == "Home Appliance Breakdown") {
    //   setState(() {
    //     option1Title = 'Pay in Full Immediately';
    //     option1SubTitle =
    //         'You settle the entire repair cost using available funds.';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = 2;

    //     Cost12Name = 'Emotional Health';
    //     cost12Cost = 15;

    //     option1Cost = -100;
    //     option1Source = "Cash";

    //     option2Title = 'Forgo Repair';
    //     option2SubTitle = 'You decide not to adjust your routine instead.';

    //     Cost21Name = 'Credit Score';
    //     cost21Cost = -4;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = 10;

    //     option2Cost = 0;
    //     option2Source = "Cash";
    //   });
    // } else if (type == "Class Registration or Certification Fee") {
    //   setState(() {
    //     option1Title = 'Enroll Immediately';
    //     option1SubTitle = 'Pay the fee now to secure your spot';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = -2;

    //     Cost12Name = 'Emotional Health';
    //     cost12Cost = 25;

    //     option1Cost = -200;
    //     option1Source = "CC";

    //     option2Title = 'Postpone Enrollment';
    //     option2SubTitle = ' You delay registration to conserve funds for now.';

    //     Cost21Name = 'Credit Score';
    //     cost21Cost = 2;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = -15;

    //     option2Cost = 0;
    //     option2Source = "Cash";
    //   });
    // } else if (type == "Impulse Buy") {
    //   setState(() {
    //     option1Title = 'Purchase Immediately';
    //     option1SubTitle = 'You buy the item right away using your funds.';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = -2;

    //     Cost12Name = 'Emotional Health';
    //     cost12Cost = 25;

    //     option1Cost = -200;
    //     option1Source = "CC";

    //     option2Title = 'Resist the Temptation';
    //     option2SubTitle =
    //         'You decide against the purchase to keep your funds intact.';

    //     Cost21Name = 'Credit Score';
    //     cost21Cost = 3;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = 10;

    //     option2Cost = 0;
    //     option2Source = "Cash";
    //   });
    // } else if (type == "Unexpected Windfall") {
    //   setState(() {
    //     option1Title = 'Apply Entirely to Debt Reduction';
    //     option1SubTitle =
    //         'You use the bonus to reduce your credit card balance immediately.';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = 5;

    //     Cost12Name = 'Emotional Health';
    //     cost12Cost = 5;

    //     option1Cost = 150;
    //     option1Source = "CC";

    //     option2Title = 'Spend on Entertainment';
    //     option2SubTitle =
    //         'You allocate the bonus fully toward leisure and fun activities.';

    //     Cost21Name = 'Credit Score';
    //     cost21Cost = 0;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = 50;

    //     option2Cost = 0;
    //     option2Source = "CC";
    //   });
    // } else if (type == "Wedding Invitation") {
    //   setState(() {
    //     option1Title = 'Attend Fully';
    //     option1SubTitle =
    //         'You commit to covering all associated costs to attend the wedding as planned.';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = -2;

    //     Cost12Name = 'Emotional Health';
    //     cost12Cost = 15;

    //     option1Cost = -150;
    //     option1Source = "CC";

    //     option2Title = 'Decline the Invitation';
    //     option2SubTitle =
    //         'You choose not to attend the wedding, avoiding any related expenses.';

    //     Cost21Name = 'Credit Score';
    //     cost21Cost = 2;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = -15;

    //     option2Cost = 0;
    //     option2Source = "CC";
    //   });
    // } else if (type == "Medical Bill") {
    //   setState(() {
    //     option1Title = 'Pay in Full Immediately';
    //     option1SubTitle =
    //         'You use your available cash to settle the bill right away.';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = 2;

    //     Cost12Name = 'Physical Health';
    //     cost12Cost = 20;

    //     option1Cost = -300;
    //     option1Source = "Cash";

    //     option2Title = 'Charge to Your Credit Card';
    //     option2SubTitle =
    //         'You add the expense to your credit card balance to preserve cash.';

    //     Cost21Name = 'Credit Score';
    //     cost21Cost = -3;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = 10;

    //     option2Cost = -300;
    //     option2Source = "CC";
    //   });
    // } else if (type == "Family Emergency Request") {
    //   setState(() {
    //     option1Title = 'Lend the Full \$200';
    //     option1SubTitle =
    //         'You provide the full amount to support your family member.';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = -2;

    //     Cost12Name = 'Emotional Health';
    //     cost12Cost = 25;

    //     option1Cost = -200;
    //     option1Source = "CC";

    //     option2Title = 'Politely Decline';
    //     option2SubTitle =
    //         'You choose not to lend any money, preserving your current funds.';

    //     Cost21Name = 'Credit Score';
    //     cost21Cost = 2;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = -15;

    //     option2Cost = 0;
    //     option2Source = "CC";
    //   });
    // }
    // //WORKS
    // else if (type == "Small Bonus / Part-Time Gig") {
    //   setState(() {
    //     option1Title = 'Apply Entirely to Debt Reduction';
    //     option1SubTitle =
    //         'You use the bonus to lower your outstanding debt immediately.';

    //     Cost11Name = 'Credit Score';
    //     cost11Cost = 3;

    //     Cost12Name = 'Emotional Health';
    //     cost12Cost = 5;

    //     option1Cost = 100;
    //     option1Source = "CC";

    //     option2Title = 'Spend on Leisure';
    //     option2SubTitle = 'You decide not to adjust your routine instead.';

    //     Cost21Name = 'Physical Health';
    //     cost21Cost = 10;
    //     Cost22Name = 'Emotional Health';
    //     cost22Cost = 10;

    //     option2Cost = 0;
    //     option2Source = "CC";
    //   });
    // }





