import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pay_task_1/core/widgets/mobile_pay_app_bar.dart';
import 'package:mobile_pay_task_1/core/widgets/wallet_balance_card.dart';
import 'package:mobile_pay_task_1/features/home/presentation/widgets/quick_action_card.dart';

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
          const SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: QuickActionCard(
                  icon: Icons.account_balance_outlined,
                  iconColor: Colors.green,
                  iconBackground: Colors.greenAccent,
                  label: 'Add Money',
                  onTap: () => context.push('/transactions'),                ),
              ),
              const SizedBox(width: 12),
            ],
          ),

        ],
      ),
    );
  }
}
