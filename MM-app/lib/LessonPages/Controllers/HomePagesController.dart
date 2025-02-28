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
      emotionalScore: 300,
      mentalScore: 300,
      physicalScore: 300,
      randomEvents: [],
      wellnessScore: 300,
      name: 'Crush the Credit Card Debt',
      checkingAccountBalance: 300,
      savingsAccountBalance: 300,
      creditCardDebt: 3000,
      startingBalance: 600,
      creditScore: 243,
      savingsAPY: 3,
      ccAPY: 19.99,
      hints: [Hint(text: "", good: true)],
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
            currentAmount: 100),
        Milestone(
            name: 'Build an Emergency Cushion',
            description:
                'By the end of Month 2, accumulate at\nleast 10% of your monthly income\n(\$250) in your savings account.',
            goalAmount: 25,
            goalType: 'Savings',
            startDay: DateTime.now().day,
            endDay:
                DateTime(DateTime.now().year, DateTime.now().month + 1, 1).day,
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
            amount: 150,
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
    ProfileScreen(),
  ];
}
