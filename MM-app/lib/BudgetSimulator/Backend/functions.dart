class BudgetSimulatorFunctions {
  int calculateWellnessFitness(
      int score, int fitnessAdded, int monthlyFitness) {
    if (fitnessAdded < 0) {
      if (monthlyFitness <= 50) {
        score -= 30;
      } else if (monthlyFitness <= 100) {
        score -= 10;
      } else if (monthlyFitness <= 150) {
        score -= 5;
      }
    } else {
      if (monthlyFitness < 50) {
        score += 30;
      } else if (monthlyFitness < 100) {
        score += 10;
      } else if (monthlyFitness < 150) {
        score += 5;
      }
    }

    return score;
  }

  int calculateWellnessEntertainment(
      int score, int entertainmentAdded, int monthlyEntertainment) {
    if (entertainmentAdded < 0) {
      if (monthlyEntertainment <= 100) {
        score -= 20;
      } else if (monthlyEntertainment <= 200) {
        score -= 10;
      } else if (monthlyEntertainment <= 350) {
        score -= 5;
      }
    } else {
      if (monthlyEntertainment < 100) {
        score += 20;
      } else if (monthlyEntertainment < 200) {
        score += 10;
      } else if (monthlyEntertainment < 350) {
        score += 5;
      }
    }

    return score;
  }
}
