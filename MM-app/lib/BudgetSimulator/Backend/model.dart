// Root model containing all scenarios
class BudgetSimulatorData {
  final Map<String, BudgetScenario> scenarios;

  BudgetSimulatorData({
    required this.scenarios,
  });

  // Helper method to retrieve a specific level configuration
  ScenarioLevelConfig getScenarioLevelConfig(String scenarioId, String level) {
    // Ensure the scenario exists
    if (!scenarios.containsKey(scenarioId)) {
      throw Exception("Scenario ID '$scenarioId' not found.");
    }

    // Fetch the scenario
    BudgetScenario scenario = scenarios[scenarioId]!;

    // Ensure the level exists in the scenario
    if (!scenario.levels.containsKey(level)) {
      throw Exception("Level '$level' not found in scenario '$scenarioId'.");
    }

    // Return the level configuration
    return scenario.getLevelConfig(level);
  }
}

// Model representing a single scenario
class BudgetScenario {
  final String id;
  final String name; // Scenario name
  final String description; // Scenario overview
  final Map<String, ScenarioLevelConfig>
      levels; // Level-specific configurations

  BudgetScenario({
    required this.id,
    required this.name,
    required this.description,
    required this.levels,
  });

  // Retrieve a specific level configuration
  ScenarioLevelConfig getLevelConfig(String level) {
    return levels[level]!;
  }
}

// Configuration for each level
// Configuration for each level
class ScenarioLevelConfig {
  final double startingBalance; // Initial debt or funds
  final double apr; // Annual Percentage Rate
  final double monthlyIncome; // Total monthly income
  final List<double>
      biweeklyPaychecks; // Income distribution (e.g., $1250 biweekly)
  final int scenarioLengthMonths; // Duration of the scenario
  double creditScore; // Starting credit score
  final Map<String, double>
      monthlySpendingBreakdown; // Breakdown of spendings by category
  final double savingsAccountBalance; // Starting savings account balance
  final double checkingAccountBalance; // Starting checking account balance
  final double credidCardDebt; // (Josh Added )Starting credit card debt
  final List<Expense> fixedExpenses; // Regular expenses like rent, utilities
  final List<RandomEvent>
      randomEvents; // Randomized events during the simulation
  final List<Milestone> milestones; // Milestones for tracking progress
  final List<Penalty> penalties; // Penalties for poor decisions
  final List<Reward> rewards;
  int wellnessScore;
  // Rewards for good decisions

  ScenarioLevelConfig(
    this.credidCardDebt, {
    required this.startingBalance,
    required this.apr,
    required this.monthlyIncome,
    required this.biweeklyPaychecks,
    required this.scenarioLengthMonths,
    required this.creditScore,
    required this.monthlySpendingBreakdown,
    required this.savingsAccountBalance,
    required this.checkingAccountBalance,
    required this.fixedExpenses,
    required this.randomEvents,
    required this.milestones,
    required this.penalties,
    required this.rewards,
    required this.wellnessScore,
  });
}

// Supporting models for expenses, random events, milestones, penalties, and rewards
class Expense {
  final String name;
  double amount;
  final String dueDateType; // "Fixed" or "Gradual"
  DateTime dueDay; // For fixed expenses (e.g., Day 5)
  double amountPaid;
  final double penalty;
  double originalTotal;

  Expense({
    required this.name,
    required this.amount,
    required this.dueDateType,
    required this.dueDay,
    required this.amountPaid,
    required this.penalty,
    this.originalTotal = 0,
  });
}

class StudentLoan {
  final String name;
  final double interestRate;
  final double monthlyPayment;
   int monthsLeft;

  StudentLoan({
    required this.name,
    required this.interestRate,
    required this.monthlyPayment,
    required this.monthsLeft,
   
  });
}

class Hint {
  final String text;
  final bool good;

  Hint({
    required this.text,
    required this.good,
  });
}

class RandomEvent {
  final String name;
  final String description;
  DateTime trigerDay;


  RandomEvent({
    required this.name,
    required this.description,
    required this.trigerDay,

  });
}

class Transaction {
  final DateTime day;
  final String name;
  final double amount;
  final String toOrFrom;
  final String account;
  final double currentAmount;

  Transaction({
    required this.name,
    required this.day,
    required this.amount,
    required this.toOrFrom,
    required this.account,
    required this.currentAmount,
  });
}

class RandomEventTaken {
  final String name;
  final String choiceTaken;
  final String discription;
  final int moneyEffect;
  final DateTime trigerDay;
  final String effect1;
  final int effect1Amount;
  final String effect2;
  final int effect2Amount;

  RandomEventTaken({
    required this.name,
    required this.choiceTaken,
    required this.discription,
    required this.trigerDay,
    required this.moneyEffect,
    required this.effect1,
    required this.effect1Amount,
    required this.effect2,
    required this.effect2Amount,
  });
}

class Milestone {
  final String name;
  final String description;
  final double
      goalAmount; // Specific target (e.g., pay down $300 above minimum)
  double currentAmount; // Current progress towards the goal (Josh Added)
  final String goalType; // "DebtReduction", "SpendingLimit", etc.
  final int startDay;
  final int endDay; // Valid time window for achieving the milestone

  Milestone({
    required this.name,
    required this.description,
    required this.goalAmount,
    required this.goalType,
    required this.startDay,
    required this.endDay,
    required this.currentAmount,
  });
}

class Penalty {
  final String name;
  final String description;
  final double penaltyAmount; // Fixed or calculated dynamically
  final String triggerCondition; // E.g., "LatePayment", "MissMilestone"

  Penalty({
    required this.name,
    required this.description,
    required this.penaltyAmount,
    required this.triggerCondition,
  });
}

class Reward {
  final String name;
  final String description;
  final double rewardAmount; // Fixed or calculated dynamically
  final String triggerCondition; // E.g., "EarlyPayment", "AchieveMilestone"

  Reward({
    required this.name,
    required this.description,
    required this.rewardAmount,
    required this.triggerCondition,
  });
}
