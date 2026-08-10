import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';


class AddMoneyResult extends Equatable {
  const AddMoneyResult({
    required this.success,
    required this.transactionId,
    required this.newBalance,
    required this.transaction,
  });

  final bool success;
  final String transactionId;
  final double newBalance;

  final TransactionEntity transaction;

  @override
  List<Object?> get props => [success, transactionId, newBalance, transaction];
}
