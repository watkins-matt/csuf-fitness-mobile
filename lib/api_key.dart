import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class APIKey {
  static bool initialized = false;
  static String foodDataCentral = '';

  static Future init() async {
    String jsonString = await rootBundle.loadString('assets/api_key.json');
    Map<String, dynamic> result = json.decode(jsonString);

    if (result.containsKey('foodDataCentral')) {
      foodDataCentral = result['foodDataCentral'];
    }

    initialized = true;
  }
}
