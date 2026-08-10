import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/kyc/presentation/bloc/kyc_event.dart';
import 'package:mobile_pay_task_1/features/kyc/presentation/bloc/kyc_state.dart';

import '../bloc/kyc_bloc.dart';

class KycStep3Screen extends StatelessWidget {
  const KycStep3Screen({
    super.key,
    required this.onEditStep1,
    required this.onEditStep2,
    required this.onSubmitted,
  });

  final VoidCallback onEditStep1;
  final VoidCallback onEditStep2;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<KycBloc, KycState>(
        listener: (context, state) {
          if (state.status == KycStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('KYC submitted successfully')),
            );
            onSubmitted();
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Review & Submit',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              _ReviewSection(
                title: 'Personal Information',
                onEdit: onEditStep1,
                rows: {
                  'Full Name': state.fullName,
                  'Date of Birth': state.dateOfBirthLabel,
                  'Gender': state.gender ?? '',
                },
              ),
              const SizedBox(height: 16),
              _ReviewSection(
                title: 'Address Information',
                onEdit: onEditStep2,
                rows: {
                  'Division': state.division ?? '',
                  'District': state.district ?? '',
                  'Full Address': state.fullAddress,
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: state.status == KycStatus.submitting
                    ? null
                    : () => context.read<KycBloc>().add(const KycSubmitted()),
                child: state.status == KycStatus.submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Submit KYC'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    required this.title,
    required this.rows,
    required this.onEdit,
  });

  final String title;
  final Map<String, String> rows;
  final VoidCallback onEdit;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              InkWell(
                onTap: onEdit,
                child: const Row(
                  children: [
                    Icon(Icons.edit, size: 14, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          for (final entry in rows.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
