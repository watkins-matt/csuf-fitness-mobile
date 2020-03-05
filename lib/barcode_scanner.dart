import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';

class BarcodeInfo {
  String upc;
  String productName;

  BarcodeInfo(this.upc, this.productName);
}

class BarcodeProvider {
  StreamController<BarcodeInfo> _itemScannedController =
      new StreamController.broadcast();
  Stream<BarcodeInfo> get itemScanned => _itemScannedController.stream;

  void scan() async {
    String barcode = await BarcodeScanner.scan();
    _itemScannedController.add(BarcodeInfo(barcode, barcode));
  }
}
