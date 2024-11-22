part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignInWithGoogleEvent extends AuthEvent {}

final class SignOutEvent extends AuthEvent {}

final class SignInEvent extends AuthEvent {
  const SignInEvent(this.email, this.password);
  final String email;
  final String password;
}

final class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  const SignUpEvent(this.email, this.password);
}

