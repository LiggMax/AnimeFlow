import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class GetConfigFile {
  static final Logger logger = Logger();

  static Future<Map<String, dynamic>> loadPluginConfig() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/plugins/xfdm.json');

      final Map<String, dynamic> config = json.decode(jsonString);

      return config;
    } catch (e) {
      logger.e(e);
      throw Exception('Failed to load plugin config: $e');
    }
  }
}
