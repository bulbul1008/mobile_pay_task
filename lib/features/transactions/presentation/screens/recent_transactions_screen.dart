import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/widgets/transactions_card.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/mobile_pay_app_bar.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_state.dart';

class RecentTransactionsScreen extends StatefulWidget {
  const RecentTransactionsScreen({super.key});

  @override
  State<RecentTransactionsScreen> createState() =>
      _RecentTransactionsScreenState();
}

class _RecentTransactionsScreenState
    extends State<RecentTransactionsScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobilePayAppBar(
        title: 'Recent Transactions',
        leading: BackButton(
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          if (state is TransactionsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TransactionsLoaded) {
            if (state.transactions.isEmpty) {
              return const EmptyState(
                message: 'No transactions yet.',
              );
            }

            return ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                return TransactionsCard(
                  transaction: state.transactions[index],
                );
              },
            );
          }

          if (state is TransactionsError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}