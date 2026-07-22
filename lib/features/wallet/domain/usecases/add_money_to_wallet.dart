import 'package:mobile_pay_task_1/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/entities/add_money_result.dart';


class AddMoneyToWallet {
  const AddMoneyToWallet(this._repository);
  final WalletRepository _repository;

  Future<AddMoneyResult> call({
    required String bank,
    required double amount,
    required double currentBalance,
  }) =>
      _repository.addMoney(
        bank: bank,
        amount: amount,
        currentBalance: currentBalance,
      );
}
