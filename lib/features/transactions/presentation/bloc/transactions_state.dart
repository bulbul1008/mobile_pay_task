import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

enum TransactionsStatus { loading, loaded }

final class TransactionsState extends Equatable {
  const TransactionsState({
    this.status = TransactionsStatus.loading,
    this.transactions = const [],
  });

  final TransactionsStatus status;
  final List<TransactionEntity> transactions;

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<TransactionEntity>? transactions,
  }) => TransactionsState(
    status: status ?? this.status,
    transactions: transactions ?? this.transactions,
  );

  @override
  List<Object?> get props => [status, transactions];
}
