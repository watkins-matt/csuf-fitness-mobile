import 'package:csuf_fitness/food_log_item.dart';
import 'food_database.dart';

abstract class StorageProvider {
  void write(FoodLogItem item);
  void writeAll(List<FoodLogItem> items);
  List<FoodLogItem> read(DateTime date);

  static StorageProvider get instance => DatabaseStorageProvider();
}

class DatabaseStorageProvider extends StorageProvider {
  @override
  void write(FoodLogItem item) {
    //FoodDatabase.instance.deleteAllRows();
    FoodDatabase.instance.insert(item);
    //FoodDatabase.instance.printAllRows();
    //FoodDatabase.instance.queryBetweenDates(a.time, f.time);
  }

  @override
  void writeAll(List<FoodLogItem> items) {
    // TODO: Implement code
    throw UnimplementedError();
  }

  @override
  List<FoodLogItem> read(DateTime date) {
    // TODO: Implement code
    throw UnimplementedError();
  }
}
