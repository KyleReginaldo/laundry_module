// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:phone_authentication/modules/phone_authentication/core/utils/error_code.dart';

part 'verify_phone_state.dart';

class VerifyPhoneCubit extends Cubit<VerifyPhoneState> {
  VerifyPhoneCubit() : super(VerifyPhoneInitial());

  void verifyPhone(String number) async {
    await FirebaseAuth.instance
        .verifyPhoneNumber(
      phoneNumber: '+63$number',
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('complete');
        emit(VerifySuccess(credential.smsCode!));
      },
      verificationFailed: (FirebaseAuthException e) {
        show('failedv');
        print(e.message);
        emit(VerifyFailed(errorCode(e.code)));
      },
      codeSent: (String verificationId, int? resendToken) async {
        print('code sent');
        print('verificationId');
        emit(VerifyingNow(id: verificationId, resentToken: resendToken));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        emit(CodeAutoRetrievalTimeout());
        print(verificationId);
        print('timeout');
      },
      timeout: const Duration(seconds: 60),
    )
        .catchError((error) {
      show('Error $error');
    });
  }
}
