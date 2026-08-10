import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}
final class WalletStarted extends WalletEvent{
  const WalletStarted();
}
final class WalletRefreshed extends WalletEvent{
  const WalletRefreshed();
}
final class WalletBalanceUpdated extends WalletEvent{
  const WalletBalanceUpdated(this.newBalance);
  final double newBalance;
  @override
  List<Object?> get props =>[newBalance];
}