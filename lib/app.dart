import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/data/app_data_source.dart';
import 'core/navigation/app_router.dart';
import 'features/add_money/data/repositories/bank_repository_impl.dart';
import 'features/add_money/domain/repositories/bank_repository.dart';
import 'features/add_money/domain/usecases/get_banks.dart';
import 'features/profile/data/repositories/user_repository_impl.dart';
import 'features/profile/domain/repositories/user_repository.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/domain/usecases/update_user_name.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/presentation/bloc/profile_event.dart';
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
        RepositoryProvider<BankRepository>(
          create: (_) => BankRepositoryImpl(dataSource),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepositoryImpl(dataSource),
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
                create: (_) =>
                    TransactionsUseCase(context.read<TransactionRepository>()),
              ),
              RepositoryProvider<GetBanks>(
                create: (_) => GetBanks(context.read<BankRepository>()),
              ),
              RepositoryProvider(
                create: (context) => GetUser(context.read<UserRepository>()),
              ),
              RepositoryProvider(
                create: (context) =>
                    UpdateUserName(context.read<UserRepository>()),
              ),
            ],
            child: Builder(
              builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => WalletBloc(
                        getWalletBalance: context.read<GetWalletBalance>(),
                      )..add(const WalletStarted()),
                    ),
                    BlocProvider(
                      create: (context) => TransactionsBloc(
                        getTransactions: context.read<TransactionsUseCase>(),
                      )..add(const TransactionsStarted()),
                    ),
                    BlocProvider(
                      create: (context) => ProfileBloc(
                        getUser: context.read<GetUser>(),
                        updateUserName: context.read<UpdateUserName>(),
                      )..add(const ProfileStarted()),
                    ),
                  ],
                  child: Builder(
                    builder: (context) {
                      return MaterialApp.router(
                        debugShowCheckedModeBanner: false,
                        title: 'MobilePay',
                        routerConfig: appRouter,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
