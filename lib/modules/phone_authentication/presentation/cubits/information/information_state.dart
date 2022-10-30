part of 'information_cubit.dart';

abstract class InformationState extends Equatable {
  const InformationState();

  @override
  List<Object> get props => [];
}

class InformationInitial extends InformationState {}

class InformationLoading extends InformationState {}

class InformationError extends InformationState {
  final String message;

  const InformationError(this.message);
}

class InformationSuccess extends InformationState {}
