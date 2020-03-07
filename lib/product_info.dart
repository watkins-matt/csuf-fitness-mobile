import 'dart:collection';
import 'api_key.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';
import 'dart:async';

abstract class ProductInfoProvider {
  Future<String> getProductTitle(String gtin);
  Future<double> getCalories(String gtin);
}

class FoodDataCentralDataProvider extends ProductInfoProvider {
  SplayTreeMap<String, int> idCache = SplayTreeMap<String, int>();
  FoodDataCentralDataProvider({apiKey = ''});

  Future<String> getProductTitle(String gtin) async {
    String apiKey = APIKey.foodDataCentral;
    if (apiKey.isEmpty) return '';

    String url =
        'https://api.nal.usda.gov/fdc/v1/search?api_key=$apiKey&generalSearchInput=$gtin';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    Map<String, dynamic> result = json.decode(response.body);

    if (result["totalHits"] == 1) {
      String title = result["foods"][0]["description"];

      // Cache the fdcId for fast lookups
      int fdcId = int.parse(result["foods"][0]["fdcId"]);
      idCache[gtin] = fdcId;

      return title.titleCase;
    }

    return '';
  }

  Future<int> getFdcID(String gtin) async {
    // Don't perform another lookup if we cached this barcode
    if (idCache.containsKey(gtin)) {
      return idCache[gtin];
    }

    String apiKey = APIKey.foodDataCentral;
    if (apiKey.isEmpty) return -1;

    String url =
        'https://api.nal.usda.gov/fdc/v1/search?api_key=$apiKey&generalSearchInput=$gtin';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    Map<String, dynamic> result = json.decode(response.body);

    if (result["totalHits"] == 1) {
      String id = result["foods"][0]["fdcId"];
      return int.parse(id);
    }

    return -1;
  }

  Future<double> getCalories(String gtin) async {
    int id = await getFdcID(gtin);
    return getCaloriesFromId(id);
  }

  Future<double> getCaloriesFromId(int fdcId) async {
    String apiKey = APIKey.foodDataCentral;
    if (apiKey.isEmpty || fdcId < 0) return -1;

    String url = 'https://api.nal.usda.gov/fdc/v1/$fdcId?api_key=$apiKey';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    Map<String, dynamic> result = json.decode(response.body);

    if (!result.containsKey('foodPortions') ||
        !result.containsKey('foodNutrients')) {
      return -1;
    }

    double gramWeight = double.parse(result["foodPortions"][0]["gramWeight"]);
    double caloriesPer100g = double.parse(result["foodNutrients"][0]["amount"]);
    double multiplier = gramWeight / 100;

    return caloriesPer100g * multiplier;
  }
}
