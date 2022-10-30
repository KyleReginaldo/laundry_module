// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_authentication/modules/phone_authentication/core/error/exception.dart';
import 'package:phone_authentication/modules/phone_authentication/core/error/failure.dart';
import 'package:phone_authentication/modules/phone_authentication/core/utils/error_code.dart';

import 'package:phone_authentication/modules/phone_authentication/data/datasource/abstract/remote_data_source.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/repository/phone_repository.dart';

class PhoneRepositoryImpl implements PhoneRepository {
  final RemoteDataSource remote;
  PhoneRepositoryImpl({
    required this.remote,
  });
  @override
  Future<Either<Failure, void>> login({
    required String smsCode,
    required String id,
  }) async {
    try {
      await remote.login(smsCode: smsCode, id: id);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure(errorCode(e.code)));
    } on InternetException catch (e) {
      return Left(InternetFailure(errorCode(e.message)));
    } catch (e) {
      return Left(ServerFailure('$e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile({
    required String email,
    required String fullname,
  }) async {
    try {
      await remote.updateProfile(email: email, fullname: fullname);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure(errorCode(e.code)));
    } on InternetException catch (e) {
      return Left(InternetFailure(errorCode(e.message)));
    } catch (e) {
      return Left(ServerFailure('$e'));
    }
  }

  @override
  Stream<User?> userCheck() => remote.userCheck();
}
