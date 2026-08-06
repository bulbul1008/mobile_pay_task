import 'package:mobile_pay_task_1/features/profile/domain/entities/user_entity.dart';

abstract interface class UserRepository {
  Future<UserEntity> getUser();

  Future<String> updateName(String name);
}
