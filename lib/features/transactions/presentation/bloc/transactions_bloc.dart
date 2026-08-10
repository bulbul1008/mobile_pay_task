import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/usecases/transactions_usecase.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({required TransactionsUseCase getTransactions})
      : _getTransactions = getTransactions,
        super(const TransactionsState()) {
    on<TransactionsStarted>(_onStarted);
    on<TransactionAcknowledged>(_onAcknowledged);
    on<TransactionAdded>(_onAdded);
  }

  final TransactionsUseCase _getTransactions;

  Future<void> _onStarted(TransactionsStarted event,
      Emitter<TransactionsState> emit,) async {
    emit(state.copyWith(status: TransactionsStatus.loading));
    final transactions = await _getTransactions();
    emit(state.copyWith(
      status: TransactionsStatus.loaded,
      transactions: transactions,
    ));
  }

  void _onAcknowledged(TransactionAcknowledged event,
      Emitter<TransactionsState> emit,) {
    emit(state.copyWith(
      transactions: [
        for (final tx in state.transactions)
          tx.id == event.id ? tx.copyWith(acknowledged: true) : tx,
      ],
    ));
  }

  void _onAdded(TransactionAdded event,
      Emitter<TransactionsState> emit,) {
    emit(state.copyWith(
      transactions: [event.transaction, ...state.transactions],
    ));
  }
}
