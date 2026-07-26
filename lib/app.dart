import 'package:flutter/material.dart';

import 'core/di/dependency_injection.dart';
import 'core/navigation/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyInjection(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MobilePay',
        routerConfig: appRouter,
      ),
    );
  }
}