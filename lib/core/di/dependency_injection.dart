import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/core/data/app_data_source.dart';
import 'package:mobile_pay_task_1/features/add_money/data/repositories/bank_repository_impl.dart';
import 'package:mobile_pay_task_1/features/add_money/domain/repositories/bank_repository.dart';
import 'package:mobile_pay_task_1/features/add_money/domain/usecases/get_banks.dart';
import 'package:mobile_pay_task_1/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/usecases/transactions_usecase.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/acknowledged_bloc.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/acknowledged_event.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:mobile_pay_task_1/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/usecases/add_money_to_wallet.dart';
import 'package:mobile_pay_task_1/features/wallet/domain/usecases/get_wallet_balance.dart';
import 'package:mobile_pay_task_1/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:mobile_pay_task_1/features/wallet/presentation/bloc/wallet_event.dart';

class DependencyInjection extends StatelessWidget {
  const DependencyInjection({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dataSource = AppDataSource();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WalletRepository>(
          create: (_) => WalletRepositoryImpl(dataSource),
        ),
        RepositoryProvider<TransactionRepository>(
          create: (_) => TransactionRepositoryImpl(dataSource),
        ),
        RepositoryProvider<BankRepository>(
          create: (_) => BankRepositoryImpl(dataSource),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<GetWalletBalance>(
                create: (_) =>
                    GetWalletBalance(context.read<WalletRepository>()),
              ),
              RepositoryProvider<AddMoneyToWallet>(
                create: (_) =>
                    AddMoneyToWallet(context.read<WalletRepository>()),
              ),
              RepositoryProvider<TransactionsUseCase>(
                create: (_) => TransactionsUseCase(
                  context.read<TransactionRepository>(),
                ),
              ),
              RepositoryProvider<GetBanks>(
                create: (_) =>
                    GetBanks(context.read<BankRepository>()),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => WalletBloc(
                    getWalletBalance:
                    context.read<GetWalletBalance>(),
                  )..add(const WalletStarted()),
                ),
                BlocProvider(
                  create: (context) => TransactionsBloc(
                    getTransactions:
                    context.read<TransactionsUseCase>(),
                  )..add(const TransactionsStarted()),
                ),
                BlocProvider(
                  create: (context) => AcknowledgedBloc(
                    getTransactions:
                    context.read<TransactionsUseCase>(),
                  )..add(const AcknowledgedStarted()),
                ),
              ],
              child: child,
            ),
          );
        },
      ),
    );
  }
}