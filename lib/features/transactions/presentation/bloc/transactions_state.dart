import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

final class InitialTransactions extends TransactionsState{
  const InitialTransactions();
}
final class LoadingTransactions extends TransactionsState {
  const LoadingTransactions();
}

final class LoadedTransactions extends TransactionsState {
  const LoadedTransactions(this.transactions);

  final List<TransactionEntity> transactions;

  @override
  List<Object?> get props => [transactions];
}

final class ErrorTransactions extends TransactionsState {
  const ErrorTransactions(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
