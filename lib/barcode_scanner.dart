import 'package:qrscan/qrscan.dart' as QRScan;

import 'product_info.dart';

class BarcodeInfo {
  String upc;
  String productName;
  int calories;

  BarcodeInfo(this.upc, this.productName, this.calories);
}

class BarcodeProvider {
  void Function(BarcodeInfo info) itemScannedCallback;
  void Function(bool searching) searchingStatusCallback;

  void scan() async {
    try {
      ProductInfoProvider info = MultiInfoProvider();
      String gtin = await QRScan.scan();

      if (searchingStatusCallback != null) {
        searchingStatusCallback(true);
      }

      String productName = await info.getProductTitle(gtin);
      int calories = (await info.getCalories(gtin)).round();

      if (itemScannedCallback != null) {
        itemScannedCallback(BarcodeInfo(gtin, productName, calories));
      }
    } catch (ex) {
      print(ex.toString());
    } finally {
      if (searchingStatusCallback != null) {
        searchingStatusCallback(false);
      }
    }
  }
}
