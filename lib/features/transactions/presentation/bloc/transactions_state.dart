import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

final class TransactionsLoading extends TransactionsState {
  const TransactionsLoading();
}

final class TransactionsLoaded extends TransactionsState {
  const TransactionsLoaded(this.transactions);

  final List<TransactionEntity> transactions;

  @override
  List<Object?> get props => [transactions];
}

final class TransactionsError extends TransactionsState {
  const TransactionsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
