import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({required this.mobile, required this.name});

  final String mobile;
  final String name;

  UserEntity copyWith({String? name}) =>
      UserEntity(mobile: mobile, name: name ?? this.name);

  @override
  List<Object?> get props => [mobile, name];
}
