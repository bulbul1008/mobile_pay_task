import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/mobile_pay_app_bar.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/acknowledged_bloc.dart';
import '../bloc/acknowledged_event.dart';
import '../bloc/acknowledged_state.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_event.dart';
import '../bloc/transactions_state.dart';
import '../widgets/transactions_card.dart';

class RecentTransactionsScreen extends StatefulWidget {
  const RecentTransactionsScreen({super.key});

  @override
  State<RecentTransactionsScreen> createState() =>
      _RecentTransactionsScreenState();
}

class _RecentTransactionsScreenState extends State<RecentTransactionsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _allScrollController = ScrollController();
  final _ackScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _allScrollController.dispose();
    _ackScrollController.dispose();

    super.dispose();
  }

  void _acknowledge(BuildContext context, TransactionEntity transaction) {
    context.read<TransactionsBloc>().add(
      TransactionAcknowledged(transaction.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AcknowledgedBloc(),
      child: BlocListener<TransactionsBloc, TransactionsState>(
        listener: (context, state) {
          context.read<AcknowledgedBloc>().add(
            AcknowledgedStarted(
              state.transactions
                  .where((transaction) => transaction.acknowledged)
                  .toList(),
            ),
          );
        },
        child: Scaffold(
          appBar: MobilePayAppBar(
            title: 'Recent Transactions',
            leading: BackButton(onPressed: () => context.pop()),
          ),
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: [
                  BlocBuilder<TransactionsBloc, TransactionsState>(
                    builder: (context, state) {
                      return Tab(text: 'All (${state.transactions.length})');
                    },
                  ),
                  BlocBuilder<AcknowledgedBloc, AcknowledgedState>(
                    builder: (context, state) {
                      return Tab(
                        text: 'Acknowledged (${state.transactions.length})',
                      );
                    },
                  ),
                ],
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocBuilder<TransactionsBloc, TransactionsState>(
                      builder: (context, state) {
                        if (state.status == TransactionsStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state.transactions.isEmpty) {
                          return const EmptyState(
                            message: 'No transactions yet.',
                          );
                        }

                        return ListView.builder(
                          controller: _allScrollController,
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = state.transactions[index];

                            return TransactionsCard(
                              transaction: transaction,
                              onAcknowledge: transaction.acknowledged
                                  ? null
                                  : () => _acknowledge(context, transaction),
                            );
                          },
                        );
                      },
                    ),

                    BlocBuilder<AcknowledgedBloc, AcknowledgedState>(
                      builder: (context, state) {
                        if (state.transactions.isEmpty) {
                          return const EmptyState(
                            message: 'No acknowledged transactions.',
                          );
                        }

                        return ListView.builder(
                          controller: _ackScrollController,
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) {
                            return TransactionsCard(
                              transaction: state.transactions[index],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
