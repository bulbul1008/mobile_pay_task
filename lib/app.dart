import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/data/app_data_source.dart';
import 'core/navigation/app_router.dart';
import 'features/transactions/data/repositories/transaction_repository_impl.dart';
import 'features/transactions/domain/repositories/transaction_repository.dart';
import 'features/transactions/domain/usecases/transactions_usecase.dart';
import 'features/transactions/presentation/bloc/transactions_bloc.dart';
import 'features/transactions/presentation/bloc/transactions_event.dart';
import 'features/wallet/data/repositories/wallet_repository_impl.dart';
import 'features/wallet/domain/repositories/wallet_repository.dart';
import 'features/wallet/domain/usecases/add_money_to_wallet.dart';
import 'features/wallet/domain/usecases/get_wallet_balance.dart';
import 'features/wallet/presentation/bloc/wallet_bloc.dart';
import 'features/wallet/presentation/bloc/wallet_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ],
      child: Builder(
        builder: (context) =>
            MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) =>
                      GetWalletBalance(context.read<WalletRepository>()),
                ),
                RepositoryProvider(
                  create: (context) =>
                      AddMoneyToWallet(context.read<WalletRepository>()),
                ),
                RepositoryProvider(
                  create: (context) =>
                      TransactionsUseCase(
                        context.read<TransactionRepository>(),
                      ),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                    WalletBloc(
                      getWalletBalance: context.read<GetWalletBalance>(),
                    )
                      ..add(const WalletStarted()),
                  ),
                  BlocProvider(
                    create: (context) =>
                    TransactionsBloc(
                      context.read<TransactionsUseCase>(),
                    )
                      ..add(const TransactionsStarted()),
                  ),
                ],
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'MobilePay',
                  routerConfig: appRouter,
                ),
              ),
            ),
      ),
    );
  }
}