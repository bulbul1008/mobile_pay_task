import 'package:mobile_pay_task_1/features/profile/domain/repositories/user_repository.dart';

class UpdateUserName {
  const UpdateUserName(this._repository);

  final UserRepository _repository;

  Future<String> call(String name) => _repository.updateName(name);
}
