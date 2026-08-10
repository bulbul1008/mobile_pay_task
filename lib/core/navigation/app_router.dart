import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/main_shell.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/transactions/domain/usecases/transactions_usecase.dart';
import '../../features/transactions/presentation/bloc/transactions_bloc.dart';
import '../../features/transactions/presentation/bloc/transactions_event.dart';
import '../../features/transactions/presentation/screens/recent_transactions_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'transactions',
                  builder: (context, state) {
                    return BlocProvider<TransactionsBloc>(
                      create: (context) => TransactionsBloc(
                        getTransactions: context.read<TransactionsUseCase>(),
                      )..add(const TransactionsStarted()),
                      child: const RecentTransactionsScreen(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
