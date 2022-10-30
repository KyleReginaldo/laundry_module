import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_authentication/modules/phone_authentication/core/error/failure.dart';

//*FIXME: Add in pubsect yaml the dartz , equatable

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class VoidUseCase<Type, Params> {
  void call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
