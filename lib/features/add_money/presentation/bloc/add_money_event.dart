import 'package:equatable/equatable.dart';

final class AddMoneyEvent extends Equatable {
  const AddMoneyEvent();

  @override
  List<Object?> get props => [];
}

final class AddMoneyStarted extends AddMoneyEvent {
  const AddMoneyStarted();
}

final class BankSelected extends AddMoneyEvent {
  const BankSelected(this.bank);

  final String bank;

  @override
  List<Object?> get props => [bank];
}

final class AmountChanged extends AddMoneyEvent {
  const AmountChanged(this.rawAmount);

  final String rawAmount;

  @override
  List<Object?> get props => [rawAmount];
}

final class AddMoneySubmitted extends AddMoneyEvent {
  const AddMoneySubmitted({required this.currentBalance});

  final double currentBalance;

  @override
  List<Object?> get props => [currentBalance];
}
