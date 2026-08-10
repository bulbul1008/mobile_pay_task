import 'package:equatable/equatable.dart';

class KycSubmission extends Equatable{
  const KycSubmission({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.division,
    required this.district,
    required this.fullAddress,
});
  final String fullName;
  final String dateOfBirth;
  final String gender;
  final String division;
  final String district;
  final String fullAddress;


  @override

  List<Object?> get props => [fullName,dateOfBirth,gender,division,district,fullAddress];
}