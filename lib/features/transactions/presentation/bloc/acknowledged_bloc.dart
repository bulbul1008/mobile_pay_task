import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/usecases/transactions_usecase.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/acknowledged_event.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/acknowledged_state.dart';


class AcknowledgedBloc extends Bloc<AcknowledgedEvent, AcknowledgedState> {
  AcknowledgedBloc({required TransactionsUseCase getTransactions})
      : _getTransactions = getTransactions,
        super(const AcknowledgedState()) {
    on<AcknowledgedStarted>(_onStarted);
    on<AcknowledgedAdded>(_onAdded);
  }

  final TransactionsUseCase _getTransactions;

  Future<void> _onStarted(
      AcknowledgedStarted event,
      Emitter<AcknowledgedState> emit,
      ) async {
    final all = await _getTransactions();
    emit(AcknowledgedState(
      transactions: [
        for (final tx in all)
          if (tx.acknowledged) tx,
      ],
    ));
  }

  void _onAdded(
      AcknowledgedAdded event,
      Emitter<AcknowledgedState> emit,
      ) {
    if (state.transactions.any((tx) => tx.id == event.transaction.id)) {
      return;
    }
    emit(AcknowledgedState(
      transactions: [
        event.transaction.copyWith(acknowledged: true),
        ...state.transactions,
      ],
    ));
  }
}
