import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_kyc_divisions.dart';
import '../../domain/usecases/submit_kyc.dart';
import '../bloc/kyc_bloc.dart';
import '../bloc/kyc_event.dart';
import '../screens/kyc_flow.dart';

Future<void> showKycFlow(BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) {
        return BlocProvider<KycBloc>(
          create: (context) => KycBloc(
            getKycDivisions: context.read<GetKycDivisions>(),
            submitKyc: context.read<SubmitKyc>(),
          )..add(const KycStarted()),
          child: const KycFlow(),
        );
      },
    ),
  );
}
