import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  const TransactionEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.time,
    this.acknowledged = false,
  });

  final String id;
  final String name;
  final double amount;
  final String type;
  final String time;
  final bool acknowledged;

  bool get isCredit => amount > 0;

  TransactionEntity copyWith({bool? acknowledged}) => TransactionEntity(
    id: id,
    name: name,
    amount: amount,
    type: type,
    time: time,
    acknowledged: acknowledged ?? this.acknowledged,
  );

  @override
  List<Object?> get props => [id, name, amount, type, time, acknowledged];
}
