class WeightReductionCalculator {
  static double getMaxCaloriesToLoseWeight(
      double normalMaxCalories, double weightToLosePerWeek) {
    double calorieReductionPerWeek = 3500 * weightToLosePerWeek;
    double calorieReductionPerDay = calorieReductionPerWeek / 7;
    return normalMaxCalories - calorieReductionPerDay;
  }
}
