// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_authentication/modules/phone_authentication/core/error/failure.dart';

import '../../core/call/usecase.dart';
import '../repository/phone_repository.dart';

class LogIn implements FutureUseCase<void, LogInParams> {
  final PhoneRepository repo;
  LogIn({
    required this.repo,
  });
  @override
  Future<Either<Failure, void>> call(LogInParams params) async {
    return repo.login(smsCode: params.smsCode, id: params.verificationId);
  }
}

class LogInParams extends Equatable {
  final String smsCode;
  final String verificationId;
  const LogInParams({
    required this.smsCode,
    required this.verificationId,
  });

  @override
  List<Object?> get props => [verificationId];
}
