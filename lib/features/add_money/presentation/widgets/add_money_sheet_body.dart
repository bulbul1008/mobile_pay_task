import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../transactions/presentation/bloc/transactions_bloc.dart';
import '../../../transactions/presentation/bloc/transactions_event.dart';
import '../../../wallet/presentation/bloc/wallet_bloc.dart';
import '../../../wallet/presentation/bloc/wallet_event.dart';
import '../../../wallet/presentation/bloc/wallet_state.dart';
import '../bloc/add_money_bloc.dart';
import '../bloc/add_money_event.dart';
import '../bloc/add_money_state.dart';

class AddMoneySheetBody extends StatelessWidget {
  const AddMoneySheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMoneyBloc, AddMoneyState>(
      listener: (context, state) {
        if (state.status == AddMoneyStatus.success && state.result != null) {
          final result = state.result!;

          context.read<WalletBloc>().add(
            WalletBalanceUpdated(result.newBalance),
          );

          context.read<TransactionsBloc>().add(
            TransactionAdded(result.transaction),
          );

          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Money added successfully'),
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<AddMoneyBloc>();

        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Money',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              if (state.status == AddMoneyStatus.loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                )
              else ...[
                DropdownButtonFormField<String>(
                  value: state.selectedBank,
                  decoration: const InputDecoration(
                    hintText: 'Select Bank',
                  ),
                  items: state.banks
                      .map(
                        (bank) => DropdownMenuItem<String>(
                          value: bank,
                          child: Text(bank),
                        ),
                  )
                      .toList(),
                  onChanged: (bank) {
                    if (bank != null) {
                      bloc.add(BankSelected(bank));
                    }
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                  ),
                  onChanged: (value) {
                    bloc.add(AmountChanged(value));
                  },
                ),

                const SizedBox(height: 20),

                FilledButton(
                  onPressed: state.canSubmit
                      ? () {
                    final walletState =
                        context
                            .read<WalletBloc>()
                            .state;

                    if (walletState is LoadedWallet) {
                      bloc.add(
                        AddMoneySubmitted(
                          currentBalance: walletState.balance,
                        ),
                      );
                    }
                  }
                      : null,
                  child: state.status == AddMoneyStatus.submitting
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text('Add Money'),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}