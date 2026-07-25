import 'package:mobile_pay_task_1/core/data/app_data_source.dart';
import 'package:mobile_pay_task_1/features/add_money/domain/repositories/bank_repository.dart';

class BankRepositoryImpl implements BankRepository {
  const BankRepositoryImpl(this._dataSource);

  final AppDataSource _dataSource;

  @override
  Future<List<String>> getBanks() => _dataSource.getBanks();
}
