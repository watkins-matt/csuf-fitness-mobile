import '../food_log_item.dart';
import 'food_database.dart';

abstract class StorageProvider<T> {
  void delete(T item);
  void write(T item);
  void writeAll(List<T> items);
  Future<List<T>> read(DateTime date);

  static StorageProvider get instance => FoodLogStorageProvider();
}

class FoodLogStorageProvider extends StorageProvider<FoodLogItem> {
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
    items.forEach((item) {
      write(item);
    });
  }

  @override
  Future<List<FoodLogItem>> read(DateTime date) async {
    return FoodDatabase.instance.queryBetweenDates(
        DateTime(date.year, date.month, date.day),
        DateTime(date.year, date.month, date.day + 1));
  }
}
