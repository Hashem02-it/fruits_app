part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final UserEntitiy userEntitiy;

  SignupSuccess({required this.userEntitiy});
}

final class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});
}
