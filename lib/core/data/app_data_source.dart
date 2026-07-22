import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class AppDataSource {
  Future<List<Map<String, dynamic>>> getTransactions() async {
    await Future.delayed(const Duration(seconds: 10));

    final jsonString = await rootBundle.loadString('assets/app_data.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);
    await Future.delayed(const Duration(seconds: 3));

    return (jsonData['transactions'] as List)
        .cast<Map<String, dynamic>>();
    //return [];
  }
}