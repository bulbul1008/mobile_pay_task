import 'package:flutter/material.dart';

import 'core/navigation/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MobilePay',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}