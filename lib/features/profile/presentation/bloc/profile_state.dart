import 'package:equatable/equatable.dart';
import 'package:mobile_pay_task_1/features/profile/domain/entities/user_entity.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.user, {this.saving = false});

  final UserEntity user;
  final bool saving;

  @override
  List<Object?> get props => [user, saving];
}
