import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class AppDataSource {
  static const String _appDataPath = 'assets/app_data.json';
  Future<List<Map<String, dynamic>>> getTransactions() async {
    await Future.delayed(Duration(seconds: 3));
    final jsonString = await rootBundle.loadString(_appDataPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return (jsonData['transactions'] as List).cast<Map<String, dynamic>>();
    //return[];
  }

  Future<double> getWalletBalance() async {
    final jsonString = await rootBundle.loadString(_appDataPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    return (jsonData['wallet']['balance'] as num).toDouble();
  }

  Future<Map<String, dynamic>> postAddMoney() async {
    final jsonString = await rootBundle.loadString(_appDataPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return jsonData['addMoney'] as Map<String, dynamic>;
  }

  Future<List<String>> getBanks() async {
    final jsonString = await rootBundle.loadString(_appDataPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return (jsonData['banks'] as List).cast<String>();
  }

}
