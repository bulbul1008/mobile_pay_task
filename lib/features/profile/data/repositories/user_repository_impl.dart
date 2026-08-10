import 'package:mobile_pay_task_1/core/data/app_data_source.dart';
import 'package:mobile_pay_task_1/features/profile/data/models/user_model.dart';
import 'package:mobile_pay_task_1/features/profile/domain/entities/user_entity.dart';
import 'package:mobile_pay_task_1/features/profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._dataSource);

  final AppDataSource _dataSource;

  @override
  Future<UserEntity> getUser() async =>
      UserModel.fromJson(await _dataSource.getUser());

  @override
  Future<String> updateName(String name) async {
    final raw = await _dataSource.patchUserName();
    final saved = raw['name'] as String? ?? '';
    return saved.isEmpty ? name : saved;
  }
}
