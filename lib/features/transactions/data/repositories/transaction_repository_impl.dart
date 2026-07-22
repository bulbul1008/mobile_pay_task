import 'package:mobile_pay_task_1/core/data/app_data_source.dart';
import 'package:mobile_pay_task_1/features/transactions/data/models/transaction_model.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(this._dataSource);
  final AppDataSource _dataSource;

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final raw = await _dataSource.getTransactions();
    return raw.map(TransactionModel.fromJson).toList();
  }
}
