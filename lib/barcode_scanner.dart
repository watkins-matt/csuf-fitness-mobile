import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'product_info.dart';
import 'open_food_facts_data_provider.dart';

class BarcodeInfo {
  String upc;
  String productName;
  int calories;

  BarcodeInfo(this.upc, this.productName, this.calories);
}

class BarcodeProvider {
  void Function(BarcodeInfo info) itemScannedCallback;

  void scan() async {
    try {
      ProductInfoProvider info = MultiInfoProvider();

      String gtin = await BarcodeScanner.scan();
      String productName = await info.getProductTitle(gtin);
      int calories = (await info.getCalories(gtin)).round();

      if (itemScannedCallback != null) {
        itemScannedCallback(BarcodeInfo(gtin, productName, calories));
      }
    } catch (ex) {
      print(ex.toString());
    }
  }
}
