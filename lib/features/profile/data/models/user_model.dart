import 'package:mobile_pay_task_1/features/profile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.mobile, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(mobile: json['mobile'] as String, name: json['name'] as String);
}
