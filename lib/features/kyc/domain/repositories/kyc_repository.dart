import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_submission.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_divisions.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_result.dart';

abstract interface class KycRepository {
  Future<KycDivisions> getDivisions();

  Future<KycResult> submit(KycSubmission submission);
}
