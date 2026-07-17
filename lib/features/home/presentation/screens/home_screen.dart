import 'package:flutter/material.dart';
import 'package:mobile_pay_task_1/core/widgets/mobile_pay_app_bar.dart';
import 'package:mobile_pay_task_1/core/widgets/wallet_balance_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobilePayAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const WalletBalanceCard(),
          const SizedBox(height: 24),
          const Text(
            'Quick Actions',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
