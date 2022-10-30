// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User? user;
  const Authenticated({
    required this.user,
  });
}

class UnAuthenticated extends AuthenticationState {}

class NewUser extends AuthenticationState {}

class Authenticating extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String errormsg;
  const AuthenticationError(
    this.errormsg,
  );
}

class Error extends AuthenticationState {}
