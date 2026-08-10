import 'package:mobile_pay_task_1/core/data/app_data_source.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_submission.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_divisions.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/entities/kyc_result.dart';
import 'package:mobile_pay_task_1/features/kyc/domain/repositories/kyc_repository.dart';

class KycRepositoryImpl implements KycRepository {
  const KycRepositoryImpl(this._dataSource);

  final AppDataSource _dataSource;

  @override
  Future<KycDivisions> getDivisions() async {
    final raw = await _dataSource.getKycDivisions();
    final rawDistricts = raw['districts'] as Map<String, dynamic>;
    return KycDivisions(
      divisions: (raw['divisions'] as List).cast<String>(),
      districts: rawDistricts.map(
        (division, list) => MapEntry(division, (list as List).cast<String>()),
      ),
    );
  }

  @override
  Future<KycResult> submit(KycSubmission submission) async {
    final raw = await _dataSource.postKycSubmit();
    return KycResult(
      success: raw['success'] as bool? ?? false,
      status: raw['status'] as String? ?? 'submitted',
    );
  }
}
