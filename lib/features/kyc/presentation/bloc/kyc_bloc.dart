import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pay_task_1/features/kyc/presentation/bloc/kyc_event.dart';
import 'package:mobile_pay_task_1/features/kyc/presentation/bloc/kyc_state.dart';
import '../../domain/entities/kyc_submission.dart';
import '../../domain/usecases/get_kyc_divisions.dart';
import '../../domain/usecases/submit_kyc.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc({
    required GetKycDivisions getKycDivisions,
    required SubmitKyc submitKyc,
  })  : _getKycDivisions = getKycDivisions,
        _submitKyc = submitKyc,
        super(const KycState()) {
    on<KycStarted>(_onStarted);
    on<KycPersonalInfoChanged>(_onPersonalInfoChanged);
    on<KycAddressChanged>(_onAddressChanged);
    on<KycSubmitted>(_onSubmitted);
    on<KycReset>(_onReset);
  }

  final GetKycDivisions _getKycDivisions;
  final SubmitKyc _submitKyc;

  Future<void> _onStarted(KycStarted event, Emitter<KycState> emit) async {
    emit(state.copyWith(options: await _getKycDivisions()));
  }

  void _onPersonalInfoChanged(
      KycPersonalInfoChanged event,
      Emitter<KycState> emit,
      ) {
    emit(state.copyWith(
      fullName: event.fullName,
      dateOfBirth: event.dateOfBirth,
      gender: event.gender,
    ));
  }

  void _onAddressChanged(KycAddressChanged event, Emitter<KycState> emit) {
    final divisionChanged =
        event.division != null && event.division != state.division;
    emit(state.copyWith(
      division: event.division,
      district: event.district,
      clearDistrict: divisionChanged,
      fullAddress: event.fullAddress,
    ));
  }

  Future<void> _onSubmitted(KycSubmitted event, Emitter<KycState> emit) async {
    if (!state.step1Valid || !state.step2Valid) return;

    emit(state.copyWith(status: KycStatus.submitting));
    final result = await _submitKyc(KycSubmission(
      fullName: state.fullName.trim(),
      dateOfBirth: state.dateOfBirthIso,
      gender: state.gender!,
      division: state.division!,
      district: state.district!,
      fullAddress: state.fullAddress.trim(),
    ));
    emit(state.copyWith(
      status: result.success ? KycStatus.success : KycStatus.editing,
    ));
  }

  void _onReset(KycReset event, Emitter<KycState> emit) {
    emit(KycState(options: state.options));
  }
}
