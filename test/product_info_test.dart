// import 'package:test/test.dart';
import 'package:csuf_fitness/api_key.dart';
import 'package:csuf_fitness/product_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Is Product Title: Toaster Pastries?', () async {
    APIKey.foodDataCentral = 'dp5nZdJdElWh76HXcIc6zxMNGomOE9K3UJp5drAv';
    ProductInfoProvider pip = FoodDataCentralDataProvider();

    String test = '038000304101';
    String output = await pip.getProductTitle(test);
    expect(output, "Unfrosted Toaster Pastries, Strawberry");
  });

  test('Toaster Pastry Calories: 200?', () async {
    APIKey.foodDataCentral = 'dp5nZdJdElWh76HXcIc6zxMNGomOE9K3UJp5drAv';
    ProductInfoProvider pip = FoodDataCentralDataProvider();

    String test = '038000304101';
    double output = await pip.getCalories(test);
    int result = output.round();
    expect(result, 200);
  });
}
