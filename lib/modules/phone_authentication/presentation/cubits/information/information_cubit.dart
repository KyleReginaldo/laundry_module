import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/usecase/update_profile.dart';

part 'information_state.dart';

class InformationCubit extends Cubit<InformationState> {
  final UpdateProfile _updateProfile;
  InformationCubit(this._updateProfile) : super(InformationInitial());

  void updateProfile({
    required String email,
    required String fullname,
  }) async {
    emit(InformationLoading());
    await Future.delayed(const Duration(seconds: 1));
    final eitherFailureOrSuccess = await _updateProfile
        .call(UpdateProfileParams(email: email, fullname: fullname));
    eitherFailureOrSuccess.fold(
        (l) => emit(InformationError(l.message)), (r) => InformationSuccess());
  }
}
