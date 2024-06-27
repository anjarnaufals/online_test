import 'dart:convert';

import 'package:flutter/services.dart';

class JsonHandler {
  static Future<dynamic> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
}
