import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_submission.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_result.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/repositories/kyc_repository.dart';

class SubmitKyc {
  const SubmitKyc(this._repository);

  final KycRepository _repository;

  Future<KycResult> call(KycSubmission submission) =>
      _repository.submit(submission);
}
