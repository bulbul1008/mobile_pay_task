import 'package:mobile_pay_task_1/core/data/app_data_source.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/entities/add_money_result.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  const WalletRepositoryImpl(this._dataSource);

  final AppDataSource _dataSource;

  @override
  Future<double> getBalance() => _dataSource.getWalletBalance();

  @override
  Future<AddMoneyResult> addMoney({
    required String bank,
    required double amount,
    required double currentBalance,
  }) async {
    final raw = await _dataSource.postAddMoney();
    final newBalance = currentBalance + amount;
    final txnId = 'txn_${DateTime.now().millisecondsSinceEpoch}';
    return AddMoneyResult(
      success: raw['success'] as bool? ?? true,
      transactionId: txnId,

      newBalance: newBalance,
      transaction: TransactionEntity(
        id: txnId,
        name: 'Add Money',
        amount: amount,
        type: 'Add Money',
        time: 'Just now',
      ),
    );
  }
}
