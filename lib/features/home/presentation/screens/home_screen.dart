import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pay_task_1/core/widgets/mobile_pay_app_bar.dart';
import 'package:mobile_pay_task_1/core/widgets/wallet_balance_card.dart';
import 'package:mobile_pay_task_1/features/add_money/presentation/widgets/show_add_money_sheet.dart';
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
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: QuickActionCard(
                  icon: Icons.money,
                  iconColor: Colors.green,
                  iconBackground: Colors.green.shade200,
                  label: 'Add money',
                  onTap: () => showAddMoneySheet(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: QuickActionCard(
                  icon: Icons.money_sharp,
                  iconColor: Colors.deepPurple,
                  iconBackground: Colors.deepPurple.shade200,
                  label: 'Recent Transactions',
                  onTap: () => context.push('/home/transactions'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: QuickActionCard(
                  icon: Icons.people,
                  iconColor: Colors.orange,
                  iconBackground: Colors.orange.shade200,
                  label: 'KYC',
                  onTap: (){},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
