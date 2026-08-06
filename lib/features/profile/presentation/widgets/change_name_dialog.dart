import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/profile/presentation/bloc/profile_event.dart';

import '../bloc/profile_bloc.dart';

Future<void> showChangeNameDialog(BuildContext context, String currentName) {
  final controller = TextEditingController(text: currentName);
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Change Name'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Full Name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            context.read<ProfileBloc>().add(
              ProfileNameChanged(controller.text),
            );
            Navigator.of(dialogContext).pop();
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
