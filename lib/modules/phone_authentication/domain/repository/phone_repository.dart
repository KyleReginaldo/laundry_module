import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_authentication/modules/phone_authentication/core/error/failure.dart';

abstract class PhoneRepository {
  Future<Either<Failure, void>> login({
    required String smsCode,
    required String id,
  });
  Future<Either<Failure, void>> updateProfile({
    required String email,
    required String fullname,
  });
  Stream<User?> userCheck();
}
