import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/data/app_data_source.dart';
import 'core/navigation/app_router.dart';
import 'features/transactions/data/repositories/transaction_repository_impl.dart';
import 'features/transactions/domain/repositories/transaction_repository.dart';
import 'features/transactions/domain/usecases/transactions_usecase.dart';
import 'features/transactions/presentation/bloc/transactions_bloc.dart';
import 'features/transactions/presentation/bloc/transactions_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = AppDataSource();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TransactionRepository>(
          create: (_) => TransactionRepositoryImpl(dataSource),
        ),
        RepositoryProvider<TransactionsUseCase>(
          create: (context) =>
              TransactionsUseCase(context.read<TransactionRepository>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MobilePay',
        routerConfig: appRouter,
      ),
    );
  }
}
