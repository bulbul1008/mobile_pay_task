import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/usecases/get_wallet_balance.dart';
import 'package:mobile_pay_task_1/features/wallet/presentation/bloc/wallet_event.dart';
import 'package:mobile_pay_task_1/features/wallet/presentation/bloc/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc({required GetWalletBalance getWalletBalance})
    : _getWalletBalance = getWalletBalance,
      super(const LoadingWallet()) {
    on<WalletStarted>(_onStarted);
    on<WalletRefreshed>(_onRefreshed);
    on<WalletBalanceUpdated>(_onBalanceUpdated);
  }

  final GetWalletBalance _getWalletBalance;
  double _balance = 0;

  Future<void> _onStarted(
    WalletStarted event,
    Emitter<WalletState> emit,
  ) async {
    emit(const LoadingWallet());
    await Future.delayed(Duration(seconds: 5));
    _balance = await _getWalletBalance();
    emit(LoadedWallet(_balance));
  }

  Future<void> _onRefreshed(
    WalletRefreshed event,
    Emitter<WalletState> emit,
  ) async {
    emit(const LoadingWallet());
    await Future.delayed(Duration(seconds: 5));
    emit(LoadedWallet(_balance));
  }

  Future<void> _onBalanceUpdated(
    WalletBalanceUpdated event,
    Emitter<WalletState> emit,
  ) async {
    _balance = event.newBalance;
    emit(LoadedWallet(_balance));
  }
}
