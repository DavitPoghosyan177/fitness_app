part of 'biometric_bloc.dart';

sealed class BiometricEvent extends Equatable {
  const BiometricEvent();

  @override
  List<Object?> get props => [];
}

final class CheckBiometricSupportEvent extends BiometricEvent {
  const CheckBiometricSupportEvent();
}

final class AuthenticateUserEvent extends BiometricEvent {
  const AuthenticateUserEvent();
}
