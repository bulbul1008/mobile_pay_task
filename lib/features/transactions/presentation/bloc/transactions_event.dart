import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

final class TransactionsStarted extends TransactionsEvent {
  const TransactionsStarted();
}

final class TransactionAcknowledged extends TransactionsEvent {
  const TransactionAcknowledged(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class TransactionAdded extends TransactionsEvent {
  const TransactionAdded(this.transaction);

  final TransactionEntity transaction;

  @override
  List<Object?> get props => [transaction];
}
