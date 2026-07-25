import 'package:mobile_pay_task_1/features/add_money/domain/repositories/bank_repository.dart';

class GetBanks {
  const GetBanks(this._repository);
  final BankRepository _repository;
  Future<List<String>> call() => _repository.getBanks();
}
