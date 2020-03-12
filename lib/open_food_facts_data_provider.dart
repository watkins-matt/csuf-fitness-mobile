import 'dart:collection';
import 'dart:async';
import 'product_info.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactsDataProvider extends ProductInfoProvider {
  SplayTreeMap<String, ProductResult> cache =
      SplayTreeMap<String, ProductResult>();

  Future<String> getProductTitle(String gtin) async {
    if (cache.containsKey(gtin)) {
      return cache[gtin].product.productName;
    }

    ProductResult result =
        await OpenFoodAPIClient.getProduct(gtin, User.LANGUAGE_EN);
    cache[gtin] = result;

    String name = result.product.productName;
    return name;
  }

  Future<double> getCalories(String gtin) async {
    if (cache.containsKey(gtin)) {
      double calories = -1;

      if (cache[gtin].product.nutriments.energyServing != null) {
        calories = cache[gtin].product.nutriments.energyServing * 0.239006;
      }
      return calories;
    }

    ProductResult result =
        await OpenFoodAPIClient.getProduct(gtin, User.LANGUAGE_EN);
    cache[gtin] = result;

    double calories = -1;

    if (result.product.nutriments.energyServing != null) {
      calories = result.product.nutriments.energyServing * 0.239006;
    }

    return calories;
  }
}
