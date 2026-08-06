import 'package:mobile_pay_task_1/features/profile/domain/entities/user_entity.dart';
import 'package:mobile_pay_task_1/features/profile/domain/repositories/user_repository.dart';

class GetUser {
  const GetUser(this._repository);

  final UserRepository _repository;

  Future<UserEntity> call() => _repository.getUser();
}
