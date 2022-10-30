import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/usecase/login.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/usecase/update_profile.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/usecase/usercheck.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final LogIn _logIn;
  final UpdateProfile _updateProfile;
  final UserCheck _userCheck;
  AuthenticationCubit(
    this._logIn,
    this._updateProfile,
    this._userCheck,
  ) : super(AuthenticationInitial());

  void logIn({
    required String smsCode,
    required String verificationId,
    required BuildContext context,
  }) async {
    emit(Authenticating());
    final eitherFailureOrSuccess = await _logIn(
      LogInParams(smsCode: smsCode, verificationId: verificationId),
    );

    eitherFailureOrSuccess.fold((l) => emit(AuthenticationError(l.message)),
        (r) {
      Navigator.pop(context);
    });
  }

  void userCheck() async {
    emit(Authenticating());
    final userCheck = _userCheck();
    userCheck.listen((user) {
      if (user != null) {
        if ((user.email ?? '').isEmpty) {
          emit(NewUser());
        } else {
          emit(Authenticated(user: user));
        }
      } else {
        emit(UnAuthenticated());
      }
    });
  }
}
