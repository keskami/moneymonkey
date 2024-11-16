import 'package:flutter/material.dart';

class TransfersScreen extends StatefulWidget {
  @override
  State<TransfersScreen> createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen> {

  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Baloo 2',
            ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),

              // Month Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'November, 2024',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Baloo 2',
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.chevron_left),
                        SizedBox(width: 16),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ],
                ),
              ),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    _buildFilterChip('All', false),
                    SizedBox(width: 8),
                    _buildFilterChip('Expenses', false),
                    SizedBox(width: 8),
                    _buildFilterChip('Income', false),
                    SizedBox(width: 8),
                    _buildFilterChip('Transfers', true),
                  ],
                ),
              ),

              // Amount Display
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      '7,464',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Baloo 2',
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '🍌',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),

              // Chart Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildBarChart(),
              ),

              // History Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Baloo 2',
                  ),
                ),
              ),

              // Transactions List
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final dates = [
                      'Today, Nov 16',
                      'Yesterday, Nov 15',
                      'Nov 14',
                      'Nov 13'
                    ];
                    return _buildTransactionItem(dates[index]);
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFFFEB3B) : Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Baloo 2',
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [0.3, 0.6, 0.4, 0.5, 0.2, 0.3, 0.8].map((height) {
              return Container(
                width: 30,
                height: 160 * height,
                decoration: BoxDecoration(
                  color: height == 0.8 ? Color(0xFF90CAF9) : Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDayLabel('Sun\n10'),
            _buildDayLabel('Mon\n11'),
            _buildDayLabel('Tue\n12'),
            _buildDayLabel('Wed\n13'),
            _buildDayLabel('Thu\n14'),
            _buildDayLabel('Fri\n15'),
            _buildDayLabel('Sat\n16', isSelected: true),
          ],
        ),
      ],
    );
  }

  Widget _buildDayLabel(String text, {bool isSelected = false}) {
    return SizedBox(
      width: 40,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Baloo 2',
          color: isSelected ? Color(0xFF90CAF9) : Colors.black,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String date) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.trending_up),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Investment Account',
                  style: TextStyle(
                      fontFamily: 'Baloo 2',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Text(
                  'Transfer - Savings',
                  style: TextStyle(
                    fontFamily: 'Baloo 2',
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    '-500',
                    style: TextStyle(
                        fontFamily: 'Baloo 2',
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(' 🍌'),
                ],
              ),
              Text(
                date,
                style: TextStyle(
                  fontFamily: 'Baloo 2',
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _buildNavItem('assets/images/globemonkey.png', 0),
        _buildNavItem('assets/images/treasure.png', 1),
        _buildNavItem('assets/images/bottommonkey.png', 2),
        _buildNavItem('assets/images/bluemonkey.png', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, int index) {
    final screenSize = MediaQuery.of(context).size;
    double iconSize = screenSize.width * 0.13;

    return BottomNavigationBarItem(
      icon: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          border: _currentIndex == index
              ? Border.all(color: Colors.blue, width: 3)
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
        ),
      ),
      label: '',
    );
  }
}
