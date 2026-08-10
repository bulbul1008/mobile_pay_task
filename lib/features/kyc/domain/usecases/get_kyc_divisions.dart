import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_divisions.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/repositories/kyc_repository.dart';

class GetKycDivisions {
  const GetKycDivisions(this._repository);

  final KycRepository _repository;

  Future<KycDivisions> call() => _repository.getDivisions();
}
