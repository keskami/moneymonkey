import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/resultsScreenSnapshotWidget.dart';

// Models
class BudgetCategory {
  final String id;
  final String category;
  final String label;
  final int score;
  final String status;
  final Color statusColor;
  final IconData icon;
  final String tooltip;

  const BudgetCategory({
    required this.id,
    required this.category,
    required this.label,
    required this.score,
    required this.status,
    required this.statusColor,
    required this.icon,
    required this.tooltip,
  });
}

class BudgetingStyle {
  final String id;
  final String title;
  final IconData icon;
  final String description;

  const BudgetingStyle({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
  });
}

class BudgetingReport extends StatefulWidget {
  final List<String> scoreCategories;
  final dynamic widget;

  const BudgetingReport({super.key, required this.scoreCategories, required this.widget});

  @override
  _BudgetingReportState createState() => _BudgetingReportState();
}

class _BudgetingReportState extends State<BudgetingReport> with SingleTickerProviderStateMixin {
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
  late List<BudgetCategory> budgetCategories;
  late List<BudgetingStyle> budgetingStyles;
  late BudgetingStyle userStyle;
  late List<String> strengths;
  late List<String> weaknesses;

  @override
  void initState() {
    super.initState();
    _initData();
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
    // Initialize budget categories
    budgetCategories = [
      BudgetCategory(
        id: "goal-progress",
        category: "Goal Progress",
        label: "Retirement Ready",
        score: 90,
        status: "Strong",
        statusColor: Colors.green,
        icon: Icons.track_changes,
        tooltip: "You saved steadily toward your main financial goal."
      ),
      BudgetCategory(
        id: "spending-awareness",
        category: "Spending Awareness",
        label: "Smart Spender",
        score: 70,
        status: "Growing",
        statusColor: Colors.amber,
        icon: Icons.attach_money,
        tooltip: "You tracked spending and adjusted sometimes."
      ),
      BudgetCategory(
        id: "debt-management",
        category: "Debt Management",
        label: "Credit Control",
        score: 40,
        status: "Needs Work",
        statusColor: Colors.red,
        icon: Icons.credit_card,
        tooltip: "You took on some debt or missed chances to reduce it."
      ),
      BudgetCategory(
        id: "emergency-preparedness",
        category: "Emergency Preparedness",
        label: "Rainy Day Ready",
        score: 65,
        status: "Growing",
        statusColor: Colors.amber,
        icon: Icons.warning,
        tooltip: "You built some emergency savings, but there's room to improve."
      ),
      BudgetCategory(
        id: "wellness-balance",
        category: "Wellness Balance",
        label: "Balanced Budgeter",
        score: 85,
        status: "Strong",
        statusColor: Colors.green,
        icon: Icons.favorite,
        tooltip: "You prioritized your well-being while managing your finances."
      ),
      BudgetCategory(
        id: "budget-adaptability",
        category: "Budget Adaptability",
        label: "Flexible Thinker",
        score: 60,
        status: "Growing",
        statusColor: Colors.amber,
        icon: Icons.refresh,
        tooltip: "You made a few smart adjustments—but could be more proactive."
      ),
    ];

    // Initialize budgeting styles
    budgetingStyles = [
      BudgetingStyle(
        id: "balanced-budgeter",
        title: "The Balanced Budgeter",
        icon: Icons.favorite,
        description: "You made thoughtful, intentional choices. You didn't sacrifice your well-being, and you worked steadily toward your goals. Keep refining your flexibility and continue to build that rainy day fund."
      ),
      BudgetingStyle(
        id: "risk-taker",
        title: "The Risk-Taker",
        icon: Icons.warning,
        description: "You're not afraid to take financial risks, which can lead to big rewards but also potential setbacks. Consider balancing risk with more stable financial strategies."
      ),
      BudgetingStyle(
        id: "spender-under-pressure",
        title: "The Spender Under Pressure",
        icon: Icons.attach_money,
        description: "When stress hits, your spending tends to increase. Finding alternative stress relief methods could help you maintain your budget during challenging times."
      ),
      BudgetingStyle(
        id: "budget-adjuster",
        title: "The Budget Adjuster",
        icon: Icons.refresh,
        description: "You're flexible with your finances and quick to adapt to changing circumstances. Keep refining your long-term planning to complement your responsive approach."
      ),
      BudgetingStyle(
        id: "minimalist-saver",
        title: "The Minimalist Saver",
        icon: Icons.psychology,
        description: "You prioritize saving and avoid unnecessary spending. Consider finding balance between saving for tomorrow and enjoying life today."
      ),
    ];

    // Set current user's style
    userStyle = budgetingStyles[0];

    // Initialize strengths and weaknesses
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
  }

  // Get section name based on tab index
  String _getSectionName(int index) {
    switch (index) {
      case 0: return 'snapshot';
      case 1: return 'style';
      case 2: return 'strengths';
      case 3: return 'improvements';
      case 4: return 'reflection';
      default: return 'snapshot';
    }
  }

  

  // Handler for reflection text input
  void _handleReflectionChange(String value) {
    if (value.length <= 200) {
      setState(() {
        reflectionText = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart, size: 28),
                  SizedBox(width: 8),
                  Text('Your Budgeting Performance Report'),
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
           ResultsScreenSnapShot( widget: widget.widget, scoreCategories: widget.scoreCategories,),
            _buildStyleSection(),
            _buildStrengthsSection(),
            _buildImprovementsSection(),
            _buildReflectionSection(),
          ],

          ),
          
        ),
      ),
      //bottomNavigationBar: _buildFooter(),
    );
  }

  
  Widget _buildStyleSection() {
    return SingleChildScrollView(
      key: styleKey,
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.psychology, size: 24, color: Colors.grey[800]),
                  SizedBox(width: 8),
                  Text(
                    'Your Budgeting Style',
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]
                    ),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 2,
                color: Colors.blue,
                margin: EdgeInsets.symmetric(vertical: 12),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[100]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(userStyle.icon, size: 24, color: Colors.grey[700]),
                        SizedBox(width: 8),
                        Text(
                          'You are... ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userStyle.title,
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700]
                          ),
                        ),
                        Text(' 🎉', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      userStyle.description,
                      style: TextStyle(
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Alternate types include:',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemCount: budgetingStyles.length - 1,
                itemBuilder: (context, index) {
                  // Skip the first style (user's style)
                  final style = budgetingStyles[index + 1];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(style.icon, size: 20, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            style.title,
                            style: TextStyle(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStrengthsSection() {
    return SingleChildScrollView(
      key: strengthsKey,
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, size: 24, color: Colors.grey[800]),
                  SizedBox(width: 8),
                  Text(
                    'What You Did Well',
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]
                    ),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 2,
                color: Colors.green,
                margin: EdgeInsets.symmetric(vertical: 12),
              ),
              Text(
                'Personalized bullet points summarizing strong habits:',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: strengths.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            strengths[index],
                            style: TextStyle(
                              color: Colors.grey[800],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImprovementsSection() {
    return SingleChildScrollView(
      key: improvementsKey,
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning, size: 24, color: Colors.grey[800]),
                  SizedBox(width: 8),
                  Text(
                    'What You Can Work On',
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]
                    ),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 2,
                color: Colors.amber,
                margin: EdgeInsets.symmetric(vertical: 12),
              ),
              Text(
                'Gentle, constructive suggestions for next time:',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: weaknesses.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning, color: Colors.amber, size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            weaknesses[index],
                            style: TextStyle(
                              color: Colors.grey[800],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReflectionSection() {
    return SingleChildScrollView(
      key: reflectionKey,
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.edit, size: 24, color: Colors.grey[800]),
                  SizedBox(width: 8),
                  Text(
                    'Your Reflection',
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]
                    ),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 2,
                color: Colors.purple,
                margin: EdgeInsets.symmetric(vertical: 12),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '"Now that you\'ve seen your results, take a moment to reflect. What did you learn about your money habits? What would you do differently next time?"',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),
              Stack(
                children: [
                  TextField(
                    maxLength: 200,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write your reflection here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      contentPadding: EdgeInsets.all(16),
                      counterText: '',
                    ),
                    onChanged: _handleReflectionChange,
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Text(
                        '${reflectionText.length}/200',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit),
                label: Text('Save Reflection'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.grey[800],
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          '© 2025 Budgeting Performance Tool',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}