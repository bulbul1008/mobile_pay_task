import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionsUseCase {
  const TransactionsUseCase(this._repository);
  final TransactionRepository _repository;

  Future<List<TransactionEntity>> call() => _repository.getTransactions();

}
