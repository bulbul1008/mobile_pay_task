import 'package:equatable/equatable.dart';

class KycResult extends Equatable {
  const KycResult({required this.success, required this.status});

  final bool success;
  final String status;

  @override
  List<Object?> get props => [success, status];
}
