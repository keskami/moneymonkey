import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/resultsImprovement.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/resultsReflection.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/resultsScreenSnapshotWidget.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/resultsStrengthScreen.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/resultsStyle.dart';

class BudgetingStyle {
  final String title;
  final IconData icon;
  final String description;
  const BudgetingStyle({
    required this.title,
    required this.icon,
    required this.description,
  });
}

class BudgetingReport extends StatefulWidget {
  final List<String> scoreCategories;
  final dynamic widget;

  const BudgetingReport(
      {super.key, required this.scoreCategories, required this.widget});

  @override
  _BudgetingReportState createState() => _BudgetingReportState();
}

class _BudgetingReportState extends State<BudgetingReport>
    with SingleTickerProviderStateMixin {
  String reflectionText = '';
  bool showRadarChart = true;
  String activeSection = 'snapshot';
  Map<String, bool> completedSections = {
    'snapshot': false,
    'style': false,
    'strengths': false,
    'improvements': false,
    'reflection': false
  };

  // Scroll controller for main scrolling
  late ScrollController _scrollController;

  // Keys for sections
  final snapshotKey = GlobalKey();
  final styleKey = GlobalKey();
  final strengthsKey = GlobalKey();
  final improvementsKey = GlobalKey();
  final reflectionKey = GlobalKey();

  // Tab controller for navigation
  late TabController _tabController;

  // Data
  late List<BudgetingStyle> budgetingStyles;
  late BudgetingStyle userStyle;
  late List<String> strengths;
  late List<String> weaknesses;
  late int budgetingIndex = 0;

  @override
  void initState() {
    super.initState();
    _initData();
          int budgetingIndex = 0;

    _scrollController = ScrollController();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        activeSection = _getSectionName(_tabController.index);
        completedSections[activeSection] = true;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Initialize all data
  void _initData() {
    setState(() {

      budgetingStyles = [
        BudgetingStyle(
            title: "The Balanced Budgeter",
            icon: Icons.monitor_heart_rounded,
            description:
                "You made thoughtful, intentional choices. You didn't sacrifice your well-being, and you worked steadily toward your\ngoals. Keep refining your flexibility and continue to build that rainy day fund."),
        BudgetingStyle(
            title: "The Risk-Taker",
            icon: Icons.warning,
            description:
                "You're not afraid to take financial risks, which can lead to big rewards but also potential setbacks. Consider balancing risk with more stable financial strategies."),
        BudgetingStyle(
            title: "The Spender Under Pressure",
            icon: Icons.attach_money,
            description:
                "When stress hits, your spending tends to increase. Finding alternative stress relief methods could help you maintain your budget during challenging times."),
        BudgetingStyle(
            title: "The Budget Adjuster",
            icon: Icons.refresh,
            description:
                "You're flexible with your finances and quick to adapt to changing circumstances. Keep refining your long-term planning to complement your responsive approach."),
        BudgetingStyle(
            title: "The Minimalist Saver",
            icon: Icons.psychology,
            description:
                "You prioritize saving and avoid unnecessary spending. Consider finding balance between saving for tomorrow and enjoying life today."),
      ];

      userStyle = budgetingStyles[budgetingIndex];

      strengths = [
        "You made at least one meaningful budget adjustment.",
        "You paid all your bills on time.",
        "You balanced savings and spending across multiple months."
      ];

      weaknesses = [
        "You didn't consistently contribute to your emergency fund.",
        "You took on extra debt without a clear repayment strategy.",
        "You missed opportunities to adjust after unexpected expenses."
      ];
    });
  }

  // Get section name based on tab index
  String _getSectionName(int index) {
    switch (index) {
      case 0:
        return 'snapshot';
      case 1:
        return 'style';
      case 2:
        return 'strengths';
      case 3:
        return 'improvements';
      case 4:
        return 'reflection';
      default:
        return 'snapshot';
    }
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenWidthUnit = screenWidth / 1920;
    final screenHeightUnit = screenHeight / 1080;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 36 * screenHeightUnit,
                    color: Colors.black,
                  ),
                  SizedBox(width: 12 * screenWidthUnit),
                  Text(
                    'Your Budgeting Performance Report',
                    style: GoogleFonts.baloo2(
                      fontSize: 36 * screenHeightUnit,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              floating: true,
              pinned: true,
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(icon: Icon(Icons.bar_chart), text: 'Snapshot'),
                  Tab(icon: Icon(Icons.psychology), text: 'Style'),
                  Tab(icon: Icon(Icons.check), text: 'Strengths'),
                  Tab(icon: Icon(Icons.warning), text: 'Improvements'),
                  Tab(icon: Icon(Icons.edit), text: 'Reflection'),
                ],
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              MouseRegion(
              onEnter: (_) {
                setState(() {
                _tabController.index = 0;
                });
              },
              child: ResultsScreenSnapShot(
                widget: widget.widget,
                scoreCategories: widget.scoreCategories,
              ),
              ),
              MouseRegion(
              onEnter: (_) {
                setState(() {
                _tabController.index = 1;
                });
              },
              child: ResultsStyle(
                screenWidthUnit: screenWidthUnit,
                screenHeightUnit: screenHeightUnit,
                budgetingStyles: budgetingStyles,
              ),
              ),
              MouseRegion(
              onEnter: (_) {
                setState(() {
                _tabController.index = 2;
                });
              },
              child: ResultsStrengthScreen(
                screenWidthUnit: screenWidthUnit,
                screenHeightUnit: screenHeightUnit,
                strengths: strengths,
              ),
              ),
              MouseRegion(
              onEnter: (_) {
                setState(() {
                _tabController.index = 3;
                });
              },
              child: ResultsImprovement(
                screenWidthUnit: screenWidthUnit,
                screenHeightUnit: screenHeightUnit,
                improvements: weaknesses,
              ),
              ),
              MouseRegion(
              onEnter: (_) {
                setState(() {
                _tabController.index = 4;
                });
              },
              child: ResultsReflection(
                screenHeightUnit: screenHeightUnit,
                screenWidthUnit: screenWidthUnit,
                reflectionText: reflectionText,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 


  
}
