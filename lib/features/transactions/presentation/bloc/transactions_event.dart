import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();
  @override
  List<Object?> get props => [];
}

final class TransactionsStarted extends TransactionsEvent {
  const TransactionsStarted();
}

final class TransactionsAdded extends TransactionsEvent {
  const TransactionsAdded(this.transaction);
  final TransactionEntity transaction;

  @override
  List<Object?> get props => [transaction];
}
