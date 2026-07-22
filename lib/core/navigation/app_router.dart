import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/usecases/transactions_usecase.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:mobile_pay_task_1/features/transactions/presentation/bloc/transactions_event.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/transactions/presentation/screens/recent_transactions_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/transactions',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => TransactionsBloc(
            context.read<TransactionsUseCase>(),
          )..add(const TransactionsStarted()),
          child: const RecentTransactionsScreen(),
        );
      },
    ),
  ],
);