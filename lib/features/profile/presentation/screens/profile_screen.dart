import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/mobile_pay_app_bar.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../widgets/account_info_card.dart';
import '../widgets/change_name_dialog.dart';
import '../widgets/profile_header_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobilePayAppBar(title: 'Profile'),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is! ProfileLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = state.user;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProfileHeaderCard(
                name: user.name,
                mobile: user.mobile,
                onEditName: () => showChangeNameDialog(context, user.name),
              ),
              const SizedBox(height: 16),
              const AccountInfoCard(),
            ],
          );
        },
      ),
    );
  }
}
