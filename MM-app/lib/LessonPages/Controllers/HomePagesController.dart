import 'package:get/get.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';
import 'package:money_monkey/Friends/comingSoonPage.dart';
import 'package:money_monkey/LessonPages/Pages/LessonsHome.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';

class HomePagesController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    LessonsHome(),
    PortfolioScreen(),
    ComingSoonPage(),
    BudgetSimulator(
      creditLimit: 5000,
      level: "Intermediate",
      bodyScore: 30,
      socialScore: 30,
      mindScore: 30,
      wellnessScore: 300,
      name: 'Crush the Credit Card Debt',
      checkingAccountBalance: 300,
      savingsAccountBalance: 0,
      creditCardDebt: 3000,
      startingBalance: 600,
      creditScore: 600,
      randomEvents: [
        RandomEvent(
            name: "Home Appliance Breakdown",
            description:
                "Your microwave or washing machine fails; you need \$100 to fix or replace it.",
            options: [
              'Pay in Full Immediately',
              'Delay / Partial Payment',
              'Forgo Repair'
            ],
            trigerDay: DateTime(0, 0, 0),
            cost: 100),
        RandomEvent(
            name: "Medical Bill",
            description:
                "A short hospital visit or specialist consult results in a \$300 bill.",
            options: [
              'Pay in Full Immediately',
              'Put on Credit Card',
              'Negotiate Payment Plan'
            ],
            trigerDay: DateTime(0, 0, 0),
            cost: 300),
        RandomEvent(
            name: "Impulse Buy",
            description:
                "A brand-new gadget or a must-attend event invite tempts you.",
            options: [
              'Pay Now',
              'Resist the Urge',
              'Seek a Discount / Alternative'
            ],
            trigerDay: DateTime(0, 0, 0),
            cost: 200),
        RandomEvent(
            name: "Unexpected Windfall",
            description:
                "A small work bonus, tax adjustment, or gift gives you an extra \$150.",
            options: [
              'Put Entirely Toward Credit Card',
              'Split: Half Debt, Half Fun',
              'Spend All on Entertainment'
            ],
            trigerDay: DateTime(0, 0, 0),
            cost: 150),
        RandomEvent(
            name: "Car Repair Surprise",
            description:
                "Brake pads or tires need urgent replacement, costing \$250.",
            options: ['Pay In Full', 'Put On Card', 'Delay / Partial'],
            trigerDay: DateTime(0, 0, 0),
            cost: 250),
        RandomEvent(
            name: "Wedding Invitation",
            description:
                "A close friend or family wedding out of town costs \$150 for travel, gift, and attire.",
            options: ['Attend Fully', 'Go on a Budget', 'Send Regrets'],
            trigerDay: DateTime(0, 0, 0),
            cost: 150),
        RandomEvent(
            name: "Class Registration or Certification Fee",
            description:
                "A chance to enroll in a course/certification that could help future income or wellness.",
            options: [
              'Pay Now',
              'Postpone to Next Semester',
              'Seek Scholarship / Payment Plan'
            ],
            trigerDay: DateTime(0, 0, 0),
            cost: 200),
        RandomEvent(
            name: "Small Bonus / Part-Time Gig",
            description:
                "You get paid for a freelance job or side hustle, earning \$100.",
            options: [
              'Put Entirely Toward Debt',
              'Use Half for Groceries/Entertainment',
              'Spend Entirely on Fun'
            ],
            trigerDay: DateTime(0, 0, 0),
            cost: 100),
        RandomEvent(
            name: "Family Emergency Request",
            description: "A family member urgently needs to borrow \$200.",
            options: [
              'Lend the Full \$200',
              'Offer Partial Help (\$100)',
              'Politely Decline'
            ],
            cost: 200,
            trigerDay: DateTime(0, 0, 0))
      ],
      savingsAPY: 3,
      ccAPY: 19.99,
      hints: [
        Hint(
            text:
                "Welcome! You start with a \$3,000 balance at 19.99% APR, two biweekly paychecks,\nand fixed bills. Use these hints from the bottom panel to help manage your cash flow\nand meet your milestones",
            good: true)
      ],
      milestones: [
        Milestone(
            name: 'Debt Avalanche Start',
            description:
                'Pay \$300 above the minimum (\$200)\nduring Month 1, for a total of at least\n\$500 paid toward the card.',
            goalAmount: 500,
            goalType: 'Debt Reduction',
            startDay: DateTime.now().day,
            endDay:
                DateTime(DateTime.now().year, DateTime.now().month + 1, 1).day,
            currentAmount: 0),
        Milestone(
            name: 'Build an Emergency Cushion',
            description:
                'By the end of Month 2, accumulate at\nleast 10% of your monthly income\n(\$250) in your savings account.',
            goalAmount: 250,
            goalType: 'Savings',
            startDay: DateTime.now().day,
            endDay:
                DateTime(DateTime.now().year, DateTime.now().month + 1, 1).day,
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
            name: "Rent",
            amount: 500,
            dueDateType: "Fixed",
            dueDay: DateTime(2025, 5, 5),
            amountPaid: 20,
            penalty: 30),
        Expense(
            name: "Pay Day",
            amount: -1250,
            dueDateType: "Fixed",
            dueDay: DateTime(2025, 5, 1),
            amountPaid: 0,
            penalty: 0),
        Expense(
            name: "Pay Day",
            amount: -1250,
            dueDateType: "Fixed",
            dueDay: DateTime(2025, 5, 15),
            amountPaid: 0,
            penalty: 0),
        Expense(
            name: "Utilities",
            amount: 150,
            dueDateType: "Fixed",
            dueDay: DateTime(2025, 5, 10),
            amountPaid: 0,
            penalty: 30),
        Expense(
            name: "Transportation",
            amount: 100,
            dueDateType: "Fixed",
            dueDay: DateTime(2025, 5, 18),
            amountPaid: 10,
            penalty: 10),
        Expense(
            name: "CC Debt",
            amount: 200,
            dueDateType: "Fixed",
            dueDay: DateTime(2025, 5, 25),
            amountPaid: 0,
            penalty: 100,
            originalTotal: 3000),
        Expense(
            name: "Groceries",
            amount: 250,
            dueDateType: "Fixed",
            dueDay: DateTime(2025, 5, 28),
            amountPaid: 0,
            penalty: 25),
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
    ProfileScreen(),
  ];
}
