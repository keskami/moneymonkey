class BudgetSimulatorFunctions {

  
  int calculateWellness(int score, int fitness, int expenses) {
    return score + fitness - expenses;
  }
}
