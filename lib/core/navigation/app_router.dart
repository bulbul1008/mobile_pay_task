import 'package:go_router/go_router.dart';
import 'package:mobile_pay_task_1/features/home/presentation/screens/home_screen.dart';


final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),

    ),
  ],
);