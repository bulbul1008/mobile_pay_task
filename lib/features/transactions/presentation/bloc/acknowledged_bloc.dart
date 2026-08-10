import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/acknowledged_event.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/acknowledged_state.dart';

class AcknowledgedBloc
    extends Bloc<AcknowledgedEvent, AcknowledgedState> {
  AcknowledgedBloc()
      : super(const AcknowledgedState()) {
    on<AcknowledgedStarted>(_onStarted);
    on<AcknowledgedAdded>(_onAdded);
  }

  void _onStarted(
      AcknowledgedStarted event,
      Emitter<AcknowledgedState> emit,
      ) {
    emit(
      AcknowledgedState(
        transactions: event.transactions
            .where((transaction) => transaction.acknowledged)
            .toList(),
      ),
    );
  }

  void _onAdded(
      AcknowledgedAdded event,
      Emitter<AcknowledgedState> emit,
      ) {
    if (state.transactions.any(
          (transaction) => transaction.id == event.transaction.id,
    )) {
      return;
    }

    emit(
      AcknowledgedState(
        transactions: [
          event.transaction.copyWith(acknowledged: true),
          ...state.transactions,
        ],
      ),
    );
  }
}