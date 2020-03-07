import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'product_info.dart';

class BarcodeInfo {
  String upc;
  String productName;
  int calories;

  BarcodeInfo(this.upc, this.productName, this.calories);
}

class BarcodeProvider {
  StreamController<BarcodeInfo> _itemScannedController =
      new StreamController.broadcast();
  Stream<BarcodeInfo> get itemScanned => _itemScannedController.stream;

  void scan() async {
    try {
      ProductInfoProvider info = FoodDataCentralDataProvider();

      String gtin = await BarcodeScanner.scan();
      String productName = await info.getProductTitle(gtin);
      int calories = (await info.getCalories(gtin)).round();

      _itemScannedController.add(BarcodeInfo(gtin, productName, calories));
    } catch (ex) {
      print(ex.toString());
    }
  }

  void dispose() {
    //_itemScannedController.close();
  }
}
