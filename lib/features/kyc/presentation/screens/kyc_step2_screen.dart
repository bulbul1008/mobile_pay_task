import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/kyc/presentation/bloc/kyc_event.dart';
import 'package:mobile_pay_task_1/features/kyc/presentation/bloc/kyc_state.dart';

import '../bloc/kyc_bloc.dart';

class KycStep2Screen extends StatefulWidget {
  const KycStep2Screen({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<KycStep2Screen> createState() => _KycStep2ScreenState();
}

class _KycStep2ScreenState extends State<KycStep2Screen> {
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController =
        TextEditingController(text: context.read<KycBloc>().state.fullAddress);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KycBloc, KycState>(
        builder: (context, state) {
          final bloc = context.read<KycBloc>();
          final districts = state.options.districtsOf(state.division);
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Address Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: state.division,
                decoration: const InputDecoration(hintText: 'Division'),
                items: [
                  for (final division in state.options.divisions)
                    DropdownMenuItem(value: division, child: Text(division)),
                ],
                onChanged: (division) =>
                    bloc.add(KycAddressChanged(division: division)),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                // Keyed so the field rebuilds when the division resets it.
                key: ValueKey('district-${state.division}'),
                value: state.district,
                decoration: const InputDecoration(hintText: 'District'),
                items: [
                  for (final district in districts)
                    DropdownMenuItem(value: district, child: Text(district)),
                ],
                onChanged: state.division == null
                    ? null
                    : (district) =>
                    bloc.add(KycAddressChanged(district: district)),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: 'Full Address'),
                onChanged: (value) =>
                    bloc.add(KycAddressChanged(fullAddress: value)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: state.step2Valid ? widget.onNext : null,
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
