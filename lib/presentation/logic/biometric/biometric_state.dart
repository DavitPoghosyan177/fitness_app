part of 'biometric_bloc.dart';

@immutable
sealed class BiometricState {}

final class BiometricInitial extends BiometricState {}

class BiometricSupportChecked extends BiometricState {
  final bool isSupported;
  BiometricSupportChecked(this.isSupported);
}

class BiometricAuthenticated extends BiometricState {
  final bool isAuthenticated;
  BiometricAuthenticated(this.isAuthenticated);
}