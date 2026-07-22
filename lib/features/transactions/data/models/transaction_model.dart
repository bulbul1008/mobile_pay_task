import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.time,
    required super.type,
    required super.acknowledged,
  });
factory TransactionModel.fromJson(Map<String, dynamic> json)=>
    TransactionModel(
        id: json['id'] as String,
        name: json['name'] as String,
        amount: (json['amount'] as num).toDouble(),
        time: json['time'] as String,
        type: json['type'] as String,
        acknowledged: json['acknowledged'] as bool? ?? false,
    );
}
