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

  String option1Source = '';
  String option2Source = '';

  bool isGood = false;

  String finalSource = '';
  int finalCost = 0;

  String effect1 = '';
  int effect1Amount = 0;

  String effect2 = '';
  int effect2Amount = 0;




  void getInfo(RandomEvent event) async {
    String type = event.name;
    if (type == "Car Repair Surprise") {
      setState(() {
        option1Title = 'Pay for Repairs in Full';
        option1SubTitle = 'You cover the entire repair cost using cash.';

        Cost11Name = 'Credit Score';
        cost11Cost = 2;

        Cost12Name = 'Physical Health';
        cost12Cost = -10;

        option1Cost = -250;
        option1Source = "CC";

        option2Title = 'Take Public Transportation';
        option2SubTitle = 'You skip the repair and instead take public transit.';

        Cost21Name = 'Credit Score';
        cost21Cost = 1;
        Cost22Name = 'Cognitive Health';
        cost22Cost = 15;
        option2Source = "Cash";

        option2Cost = 0;


      });
    } else if (type == "Home Appliance Breakdown") {
      setState(() {
        option1Title = 'Pay in Full Immediately';
        option1SubTitle = 'You settle the entire repair cost using available funds.';

        Cost11Name = 'Credit Score';
        cost11Cost = 2;

        Cost12Name = 'Emotional Health';
        cost12Cost = 15;

        option1Cost = -100;
        option1Source = "Cash";

        option2Title = 'Forgo Repair';
        option2SubTitle = 'You decide not to adjust your routine instead.';

        Cost21Name = 'Credit Score';
        cost21Cost = -4;
        Cost22Name = 'Cognitive Health';
        cost22Cost = 10;
        
        option2Cost = 0;
        option2Source = "Cash";
      });
    } else if (type == "Class Registration or Certification Fee") {
      setState(() {
        option1Title = 'Enroll Immediately';
        option1SubTitle = 'Pay the fee now to secure your spot';

        Cost11Name = 'Credit Score';
        cost11Cost = -2;

        Cost12Name = 'Cogntive Health';
        cost12Cost = 25;

        option1Cost = -200;
        option1Source = "CC";

        option2Title = 'Postpone Enrollment';
        option2SubTitle = ' You delay registration to conserve funds for now.';

        Cost21Name = 'Credit Score';
        cost21Cost = 2;
        Cost22Name = 'Emotional Health';
        cost22Cost = -15;
        
        option2Cost = 0;
        option2Source = "Cash";
      });
    } else if (type == "Impulse Buy") {
      setState(() {
        option1Title = 'Purchase Immediately';
        option1SubTitle = 'You buy the item right away using your funds.';

        Cost11Name = 'Credit Score';
        cost11Cost = -2;

        Cost12Name = 'Emotional Health';
        cost12Cost = 25;

        option1Cost = -200;
        option1Source = "CC";

        option2Title = 'Resist the Temptation';
        option2SubTitle = 'You decide against the purchase to keep your funds intact.';

        Cost21Name = 'Credit Score';
        cost21Cost = 3;
        Cost22Name = 'Cognitive Health';
        cost22Cost = 10;
        
        option2Cost = 0;
        option2Source = "Cash";
      });

    } else if (type == "Unexpected Windfall") {
      setState(() {
        option1Title = 'Apply Entirely to Debt Reduction';
        option1SubTitle = 'You use the bonus to reduce your credit card balance immediately.';

        Cost11Name = 'Credit Score';
        cost11Cost = 5;

        Cost12Name = 'Cognative Health';
        cost12Cost = 5;

        option1Cost = 150;
        option1Source = "CC";

        option2Title = 'Spend on Entertainment';
        option2SubTitle = 'You allocate the bonus fully toward leisure and fun activities.';

        Cost21Name = 'Credit Score';
        cost21Cost = 0;
        Cost22Name = 'Emotional Health';
        cost22Cost = 50;
        
        option2Cost = 0;
        option2Source = "CC";
      });
    } else if (type == "Wedding Invitation") {
      setState(() {
        option1Title = 'Attend Fully';
        option1SubTitle = 'You commit to covering all associated costs to attend the wedding as planned.';

        Cost11Name = 'Credit Score';
        cost11Cost = -2;

        Cost12Name = 'Emotional Health';
        cost12Cost = 15;

        option1Cost = -150;
        option1Source = "CC";

        option2Title = 'Decline the Invitation';
        option2SubTitle = 'You choose not to attend the wedding, avoiding any related expenses.';

        Cost21Name = 'Credit Score';
        cost21Cost = 2;
        Cost22Name = 'Cognitive Health';
        cost22Cost = -15;
        
        option2Cost = 0;
        option2Source = "CC";
      });
    } else if (type == "Medical Bill") {
      setState(() {
        option1Title = 'Pay in Full Immediately';
        option1SubTitle = 'You use your available cash to settle the bill right away.';

        Cost11Name = 'Credit Score';
        cost11Cost = 2;

        Cost12Name = 'Physical Health';
        cost12Cost = 20;

        option1Cost = -300;
        option1Source = "Cash";

        option2Title = 'Charge to Your Credit Card';
        option2SubTitle = 'You add the expense to your credit card balance to preserve cash.';

        Cost21Name = 'Credit Score';
        cost21Cost = -3;
        Cost22Name = 'Emotional Health';
        cost22Cost = 10;
        
        option2Cost = -300;
        option2Source = "CC";
      });
    } else if (type == "Family Emergency Request") {
      setState(() {
        option1Title = 'Lend the Full \$200';
        option1SubTitle = 'You provide the full amount to support your family member.';

        Cost11Name = 'Credit Score';
        cost11Cost = -2;

        Cost12Name = 'Emotional Health';
        cost12Cost = 25;

        option1Cost = -200;
        option1Source = "CC";


        option2Title = 'Politely Decline';
        option2SubTitle = 'You choose not to lend any money, preserving your current funds.';

        Cost21Name = 'Credit Score';
        cost21Cost = 2;
        Cost22Name = 'Emotional Health';
        cost22Cost = -15;
        
        option2Cost = 0;
        option2Source = "CC";
      });
    } 
    //WORKS
    else if (type == "Small Bonus / Part-Time Gig") {
      setState(() {
        option1Title = 'Apply Entirely to Debt Reduction';
        option1SubTitle = 'You use the bonus to lower your outstanding debt immediately.';

        Cost11Name = 'Credit Score';
        cost11Cost = 3;

        Cost12Name = 'Cognitive Health';
        cost12Cost = 5;

        option1Cost = 100;
        option1Source = "CC";

        option2Title = 'Spend on Leisure';
        option2SubTitle = 'You decide not to adjust your routine instead.';

        Cost21Name = 'Physical Health';
        cost21Cost = 10;
        Cost22Name = 'Cognitive Health';
        cost22Cost = 10;
        
        option2Cost = 0;
        option2Source = "CC";
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
      height: screenHeightUnit * 930,
      width: screenWidthUnit * 1065,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeightUnit * 55,
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
              fontSize: screenHeightUnit * 60,
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
              fontSize: screenHeightUnit * 30,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
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
                height: screenHeightUnit * 297,
                width: screenWidthUnit * 471,
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
                    selected: oneSelcted, Source: option1Source,),
              ),
              SizedBox(
                width: screenWidthUnit * 20,
              ),
              Container(
                height: screenHeightUnit * 297,
                width: screenWidthUnit * 471,
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
                    Source: option2Source
                    
                    
                    ),
              )
            ],
          ),
          SizedBox(
            height: screenHeightUnit * 50,
          ),
          GestureDetector(
            onTap: () {
              if (oneSelcted || twoSelected) {
                if (oneSelcted) {
                  
                  finalSource = option1Source;
                  finalCost = option1Cost;
                  effect1 = Cost11Name;
                  effect1Amount = cost11Cost;
                  effect2 = Cost12Name;
                  effect2Amount = cost12Cost;
                } else {
                  finalSource = option2Source;
                  finalCost = option2Cost;
                   effect1 = Cost21Name;
                  effect1Amount = cost21Cost;
                  effect2 = Cost22Name;
                  effect2Amount = cost22Cost;
                }
                widget.onConfirm(finalSource, finalCost, effect1, effect1Amount, effect2, effect2Amount);
              }
            },
            child: Container(
              height: screenHeightUnit * 73,
              width: screenWidthUnit * 307,
              decoration: BoxDecoration(
                  color: (oneSelcted || twoSelected)
                      ? Color.fromRGBO(79, 195, 247, 1)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(7)),
              child: Center(
                child: Text(
                  "Continue",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 20,
                    fontWeight: FontWeight.w600,
                    color: (oneSelcted || twoSelected)
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
          height: widget.screenHeightUnit * 297,
          width: widget.screenWidthUnit * 471,
          decoration: BoxDecoration(
            color: widget.selected
                ? Color.fromRGBO(79, 195, 247, 1)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.screenWidthUnit * 38,
                top: widget.screenHeightUnit * 21),
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
                        ? Color.fromRGBO(30, 213, 58, 1)
                        : widget.cost < 0
                            ? Color.fromRGBO(243, 52, 52, 1)
                            : widget.selected
                                ? Colors.white
                                : Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: widget.screenHeightUnit * 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: widget.screenHeightUnit * 40,
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.effect1Cost > 0
                                ? Color.fromRGBO(199, 244, 191, 1)
                                : Color.fromRGBO(255, 213, 213, 1),
                            borderRadius: BorderRadius.circular(10),
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
                                      ? Color.fromRGBO(30, 213, 58, 1)
                                      : Color.fromRGBO(243, 52, 52, 1),
                                ),
                              ),
                              SizedBox(width: widget.screenWidthUnit * 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widget.screenWidthUnit * 11,
                    ),
                    SizedBox(
                      height: widget.screenHeightUnit * 40,
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.effect2Cost > 0
                                ? Color.fromRGBO(199, 244, 191, 1)
                                : Color.fromRGBO(255, 213, 213, 1),
                            borderRadius: BorderRadius.circular(10),
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
                                      ? Color.fromRGBO(30, 213, 58, 1)
                                      : Color.fromRGBO(243, 52, 52, 1),
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
