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

  Future<Map<String, dynamic>> getUser() async {
    final jsonString = await rootBundle.loadString(_appDataPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return (jsonData['user'] as Map<String, dynamic>);
  }
  Future<Map<String, dynamic>> patchUserName() async {
    final jsonString = await rootBundle.loadString(_appDataPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return (jsonData['updateName'] as Map<String, dynamic>);
  }
  Future<Map<String, dynamic>> getKycDivisions() async {
    final jsonString = await rootBundle.loadString(_appDataPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return (jsonData['kyc'] as Map<String, dynamic>);
  }
  Future<Map<String,dynamic>> postKycSubmit() async {
    final jsonString = await rootBundle.loadString(_appDataPath);
    final Map<String,dynamic> jsonData = json.decode(jsonString);
    return (jsonData['kycSubmit'] as Map<String, dynamic>);
  }
}
