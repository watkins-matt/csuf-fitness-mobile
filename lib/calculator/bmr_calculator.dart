class BasalMetabolicRateCalculator {
  static double calculateBMR(
      double weight, double height, double age, bool male) {
    double bmr = (4.536 * weight) + (15.88 * height) - (5 * age);
    bmr += male ? 5 : -161;

    return bmr;
  }

  static double calculateCalorieRequirementFromBMR(
      double bmr, double activityLevel) {
    return bmr * activityLevel;
  }

  static double calculateCalorieRequirement(double weight, double height,
      double age, bool male, double activityLevel) {
    double bmr = calculateBMR(weight, height, age, male);
    return bmr * activityLevel;
  }
}

abstract class ActivityLevel {
  static const double Sedentary = 1.2;
  static const double LightlyActive = 1.375;
  static const double ModeratelyActive = 1.55;
  static const double HighlyActive = 1.725;
  static const double ExtremelyActive = 1.9;
}
