import 'package:flutter/material.dart';
import 'package:mobile_pay_task_1/core/widgets/mobile_pay_app_bar.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobilePayAppBar(),
    );
  }
}
