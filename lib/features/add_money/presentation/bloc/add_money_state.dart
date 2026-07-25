import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/entities/add_money_result.dart';


enum AddMoneyStatus { loading, ready, submitting, success }

final class AddMoneyState extends Equatable {
  const AddMoneyState({
    this.status = AddMoneyStatus.loading,
    this.banks = const [],
    this.selectedBank,
    this.amount = 0,
    this.result,
  });

  final AddMoneyStatus status;
  final List<String> banks;
  final String? selectedBank;
  final double amount;
  final AddMoneyResult? result;

  bool get canSubmit =>
      status == AddMoneyStatus.ready && selectedBank != null && amount > 0;

  AddMoneyState copyWith({
    AddMoneyStatus? status,
    List<String>? banks,
    String? selectedBank,
    double? amount,
    AddMoneyResult? result,
  }) {
    return AddMoneyState(
      status: status ?? this.status,
      banks: banks ?? this.banks,
      selectedBank: selectedBank ?? this.selectedBank,
      amount: amount ?? this.amount,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [status, banks, selectedBank, amount, result];
}
