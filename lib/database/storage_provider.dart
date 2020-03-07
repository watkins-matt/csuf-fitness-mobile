import 'package:csuf_fitness/food_log_item.dart';
import 'food_database.dart';

abstract class StorageProvider {
  void delete(FoodLogItem item);
  void write(FoodLogItem item);
  void writeAll(List<FoodLogItem> items);
  Future<List<FoodLogItem>> read(DateTime date);

  static StorageProvider get instance => DatabaseStorageProvider();
}

class DatabaseStorageProvider extends StorageProvider {
  @override
  void delete(FoodLogItem item) async {
    FoodDatabase.instance.deleteByTimestamp(item.time);
  }

  @override
  void write(FoodLogItem item) {
    FoodDatabase.instance.insert(item);
  }

  @override
  void writeAll(List<FoodLogItem> items) {
    // TODO: Implement code
    throw UnimplementedError();
  }

  @override
  Future<List<FoodLogItem>> read(DateTime date) async {
    return FoodDatabase.instance.queryBetweenDates(
        DateTime(date.year, date.month, date.day),
        DateTime(date.year, date.month, date.day + 1));
  }
}
