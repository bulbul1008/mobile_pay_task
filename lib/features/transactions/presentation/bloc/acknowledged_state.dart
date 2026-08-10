import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

final class AcknowledgedState extends Equatable {
  const AcknowledgedState({this.transactions = const []});

  final List<TransactionEntity> transactions;

  @override
  List<Object?> get props => [transactions];
}
