import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/usecases/transactions_usecase.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc(this._getTransactions) : super(const TransactionsLoading()) {
    on<TransactionsStarted>(_onStarted);
    on<TransactionsAdded>(_onAdded);
  }

  final TransactionsUseCase _getTransactions;

  Future<void> _onStarted(
    TransactionsStarted event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(const TransactionsLoading());

    try {
      final transactions = await _getTransactions();

      emit(TransactionsLoaded(transactions));
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  void _onAdded(TransactionsAdded event, Emitter<TransactionsState> emit) {
    if (state is TransactionsLoaded) {
      final currentState = state as TransactionsLoaded;

      emit(
        TransactionsLoaded([event.transaction, ...currentState.transactions]),
      );
    }
  }
}
