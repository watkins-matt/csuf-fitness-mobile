class FoodLogItem {
  String name;
  int calories;
  DateTime time;
  String upc;

  FoodLogItem(this.name, this.calories, this.time, {this.upc = ""});
}
