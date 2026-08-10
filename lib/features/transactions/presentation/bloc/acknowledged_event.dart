import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

sealed class AcknowledgedEvent extends Equatable {
  const AcknowledgedEvent();

  @override
  List<Object?> get props => [];
}

final class AcknowledgedStarted extends AcknowledgedEvent {
  const AcknowledgedStarted(this.transactions);

  final List<TransactionEntity> transactions;

  @override
  List<Object?> get props => [transactions];
}

final class AcknowledgedAdded extends AcknowledgedEvent {
  const AcknowledgedAdded(this.transaction);

  final TransactionEntity transaction;

  @override
  List<Object?> get props => [transaction];
}