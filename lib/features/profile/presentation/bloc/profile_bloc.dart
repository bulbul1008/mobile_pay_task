import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/profile/domain/usecases/get_user.dart';
import 'package:mobile_pay_task_1/features/profile/domain/usecases/update_user_name.dart';
import 'package:mobile_pay_task_1/features/profile/presentation/bloc/profile_event.dart';
import 'package:mobile_pay_task_1/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetUser getUser,
    required UpdateUserName updateUserName,
  }) : _getUser = getUser,
       _updateUserName = updateUserName,
       super(const ProfileLoading()) {
    on<ProfileStarted>(_onStarted);
    on<ProfileNameChanged>(_onNameChanged);
  }

  final GetUser _getUser;
  final UpdateUserName _updateUserName;

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    emit(ProfileLoaded(await _getUser()));
  }

  Future<void> _onNameChanged(
    ProfileNameChanged event,
    Emitter<ProfileState> emit,
  ) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    final trimmed = event.name.trim();

    emit(ProfileLoaded(current.user, saving: true));

    final savedName = await _updateUserName(trimmed);

    emit(ProfileLoaded(current.user.copyWith(name: savedName)));
  }
}
