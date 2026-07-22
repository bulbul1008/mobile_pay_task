import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

abstract interface class TransactionRepository {
  Future<List<TransactionEntity>> getTransactions();
}
