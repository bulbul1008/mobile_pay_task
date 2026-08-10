import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/kyc/presentation/bloc/kyc_event.dart';
import 'package:mobile_pay_task_1/features/kyc/presentation/bloc/kyc_state.dart';

import '../bloc/kyc_bloc.dart';

class KycStep1Screen extends StatefulWidget {
  const KycStep1Screen({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<KycStep1Screen> createState() => _KycStep1ScreenState();
}

class _KycStep1ScreenState extends State<KycStep1Screen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: context.read<KycBloc>().state.fullName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    final bloc = context.read<KycBloc>();
    final picked = await showDatePicker(
      context: context,
      initialDate: bloc.state.dateOfBirth ?? DateTime(1995),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      bloc.add(KycPersonalInfoChanged(dateOfBirth: picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KycBloc, KycState>(
        builder: (context, state) {
          final bloc = context.read<KycBloc>();
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Full Name'),
                onChanged: (value) =>
                    bloc.add(KycPersonalInfoChanged(fullName: value)),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: _pickDateOfBirth,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    hintText: 'Date of Birth',
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  ),
                  child: Text(
                    state.dateOfBirth == null
                        ? 'Date of Birth'
                        : state.dateOfBirthLabel,
                    style: TextStyle(
                      color: state.dateOfBirth == null
                          ? Colors.grey.shade600
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: state.gender,
                decoration: const InputDecoration(hintText: 'Gender'),
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (gender) =>
                    bloc.add(KycPersonalInfoChanged(gender: gender)),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: state.step1Valid ? widget.onNext : null,
                child: const Text('Next'),
              ),
            ],
          );
        },
      ),
    );
  }
}
