import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/add_money/presentation/bloc/add_money_event.dart';

import '../../../wallet/domain/usecases/add_money_to_wallet.dart';
import '../../domain/usecases/get_banks.dart';
import '../bloc/add_money_bloc.dart';
import 'add_money_sheet_body.dart';

Future<void> showAddMoneySheet(BuildContext context) {
  final getBanks = context.read<GetBanks>();
  final addMoneyToWallet = context.read<AddMoneyToWallet>();

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return BlocProvider(
        create: (_) => AddMoneyBloc(
          getBanks: getBanks,
          addMoneyToWallet: addMoneyToWallet,
        )..add(const AddMoneyStarted()),
        child: const AddMoneySheetBody(),
      );
    },
  );
}