import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class LoginFailure extends Failure {
  @override
  final String message;

  const LoginFailure(this.message) : super(message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class EmptyFailure extends Failure {
  @override
  final String message;

  const EmptyFailure(this.message) : super(message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class InternetFailure extends Failure {
  @override
  final String message;

  const InternetFailure(this.message) : super(message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class AuthenticationFailure extends Failure {
  @override
  final String message;

  const AuthenticationFailure(this.message) : super(message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  @override
  final String message;

  const ServerFailure(this.message) : super(message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class CacheFailure extends Failure {
  @override
  final String message;

  const CacheFailure(this.message) : super(message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}
