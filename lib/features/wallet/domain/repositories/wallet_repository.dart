import 'package:mobile_pay_task_1/features/wallet/domain/entities/add_money_result.dart';

abstract interface class WalletRepository {

  Future<double> getBalance();

  Future<AddMoneyResult> addMoney({
    required String bank,
    required double amount,
    required double currentBalance,
  });
}
