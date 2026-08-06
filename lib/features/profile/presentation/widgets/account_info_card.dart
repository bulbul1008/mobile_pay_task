import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../wallet/presentation/bloc/wallet_bloc.dart';
import '../../../wallet/presentation/bloc/wallet_state.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import 'info_row.dart';

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Info',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const Divider(height: 20),
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              return switch (state) {
                LoadedWallet(:final balance) => InfoRow(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Current Balance',
                  value: Text(
                    balance.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),

                LoadingWallet() => const InfoRow(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Current Balance',
                  value: SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              };
            },
          ),

          const InfoRow(
            icon: Icons.shield_outlined,
            label: 'Account Status',
            value: Text(
              'Active',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) => InfoRow(
              icon: Icons.phone_outlined,
              label: 'Mobile',
              value: Text(
                state is ProfileLoaded ? state.user.mobile : '—',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
