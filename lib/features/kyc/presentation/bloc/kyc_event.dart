import 'package:equatable/equatable.dart';

sealed class KycEvent extends Equatable {
  const KycEvent();

  @override
  List<Object?> get props => [];
}

final class KycStarted extends KycEvent {
  const KycStarted();
}

final class KycPersonalInfoChanged extends KycEvent {
  const KycPersonalInfoChanged({this.fullName, this.dateOfBirth, this.gender});

  final String? fullName;
  final DateTime? dateOfBirth;
  final String? gender;

  @override
  List<Object?> get props => [fullName, dateOfBirth, gender];
}

final class KycAddressChanged extends KycEvent {
  const KycAddressChanged({this.division, this.district, this.fullAddress});

  final String? division;
  final String? district;
  final String? fullAddress;

  @override
  List<Object?> get props => [division, district, fullAddress];
}

final class KycSubmitted extends KycEvent {
  const KycSubmitted();
}

final class KycReset extends KycEvent {
  const KycReset();
}
