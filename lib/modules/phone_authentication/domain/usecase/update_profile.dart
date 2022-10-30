// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:phone_authentication/modules/phone_authentication/core/call/usecase.dart';
import 'package:phone_authentication/modules/phone_authentication/core/error/failure.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/repository/phone_repository.dart';

class UpdateProfile implements FutureUseCase<void, UpdateProfileParams> {
  final PhoneRepository repo;
  UpdateProfile({
    required this.repo,
  });
  @override
  Future<Either<Failure, void>> call(UpdateProfileParams params) async {
    return repo.updateProfile(email: params.email, fullname: params.fullname);
  }
}

class UpdateProfileParams extends Equatable {
  final String email;
  final String fullname;
  const UpdateProfileParams({
    required this.email,
    required this.fullname,
  });

  @override
  List<Object?> get props => [email];
}
