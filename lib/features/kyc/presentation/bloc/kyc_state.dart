import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_divisions.dart';

enum KycStatus { editing, submitting, success }

final class KycState extends Equatable {
  const KycState({
    this.status = KycStatus.editing,
    this.options = const KycDivisions(divisions: [], districts: {}),
    this.fullName = '',
    this.dateOfBirth,
    this.gender,
    this.division,
    this.district,
    this.fullAddress = '',
  });

  final KycStatus status;
  final KycDivisions options;
  final String fullName;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? division;
  final String? district;
  final String fullAddress;

  bool get step1Valid =>
      fullName.trim().isNotEmpty && dateOfBirth != null && gender != null;

  bool get step2Valid =>
      division != null && district != null && fullAddress.trim().isNotEmpty;

  String get dateOfBirthLabel => dateOfBirth == null
      ? ''
      : '${dateOfBirth!.day.toString().padLeft(2, '0')}/'
            '${dateOfBirth!.month.toString().padLeft(2, '0')}/'
            '${dateOfBirth!.year}';

  String get dateOfBirthIso => dateOfBirth == null
      ? ''
      : '${dateOfBirth!.year}-'
            '${dateOfBirth!.month.toString().padLeft(2, '0')}-'
            '${dateOfBirth!.day.toString().padLeft(2, '0')}';

  KycState copyWith({
    KycStatus? status,
    KycDivisions? options,
    String? fullName,
    DateTime? dateOfBirth,
    String? gender,
    String? division,
    String? district,
    bool clearDistrict = false,
    String? fullAddress,
  }) => KycState(
    status: status ?? this.status,
    options: options ?? this.options,
    fullName: fullName ?? this.fullName,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    gender: gender ?? this.gender,
    division: division ?? this.division,
    district: clearDistrict ? null : (district ?? this.district),
    fullAddress: fullAddress ?? this.fullAddress,
  );

  @override
  List<Object?> get props => [
    status,
    options,
    fullName,
    dateOfBirth,
    gender,
    division,
    district,
    fullAddress,
  ];
}
