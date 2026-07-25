import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/add_money/presentation/bloc/add_money_event.dart';
import 'package:mobile_pay_task_1/features/add_money/presentation/bloc/add_money_state.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/usecases/add_money_to_wallet.dart';

import '../../domain/usecases/get_banks.dart';

class AddMoneyBloc extends Bloc<AddMoneyEvent, AddMoneyState> {
  AddMoneyBloc({
    required GetBanks getBanks,
    required AddMoneyToWallet addMoneyToWallet,
  }) : _getBanks = getBanks,
       _addMoneyToWallet = addMoneyToWallet,
       super(const AddMoneyState()) {
    on<AddMoneyStarted>(_onStarted);
    on<BankSelected>(_onBankSelected);
    on<AmountChanged>(_onAmountChanged);
    on<AddMoneySubmitted>(_onSubmitted);
  }

  final GetBanks _getBanks;
  final AddMoneyToWallet _addMoneyToWallet;

  Future<void> _onStarted(
    AddMoneyStarted event,
    Emitter<AddMoneyState> emit,
  ) async {
    emit(
      state.copyWith(status: AddMoneyStatus.ready, banks: await _getBanks()),
    );
  }

  void _onBankSelected(BankSelected event, Emitter<AddMoneyState> emit) {
    emit(state.copyWith(selectedBank: event.bank));
  }

  void _onAmountChanged(AmountChanged event, Emitter<AddMoneyState> emit) {
    emit(state.copyWith(amount: double.tryParse(event.rawAmount) ?? 0));
  }

  Future<void> _onSubmitted(
    AddMoneySubmitted event,
    Emitter<AddMoneyState> emit,
  ) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: AddMoneyStatus.submitting));

    final result = await _addMoneyToWallet(
      bank: state.selectedBank!,
      amount: state.amount,
      currentBalance: event.currentBalance,
    );

    emit(state.copyWith(status: AddMoneyStatus.success, result: result));
  }
}
