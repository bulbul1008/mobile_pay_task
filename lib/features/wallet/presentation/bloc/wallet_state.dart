import 'package:equatable/equatable.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

final class LoadingWallet extends WalletState {
  const LoadingWallet();
}

final class LoadedWallet extends WalletState {
  const LoadedWallet(this.balance);

  final double balance;

  @override
  List<Object?> get props => [balance];
}
