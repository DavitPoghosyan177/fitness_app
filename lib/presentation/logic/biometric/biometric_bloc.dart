import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/repositories/biometric_repository.dart';
import 'package:flutter/material.dart';

part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final BiometricRepository biometricRepository;

  BiometricBloc(this.biometricRepository) : super(BiometricInitial()) {
    on<CheckBiometricSupportEvent>(_mapCheckBiometricSupportToState);
    on<AuthenticateUserEvent>(_mapAuthenticateUserToState);
  }

  Future<void> _mapCheckBiometricSupportToState(
      CheckBiometricSupportEvent event, Emitter<BiometricState> emit) async {
    try {
      final bool isSupported = await biometricRepository.checkBiometricSupport();
      emit(BiometricSupportChecked(isSupported));
    } catch (e) {
      emit(BiometricSupportChecked(false)); 
    }
  }

  Future<void> _mapAuthenticateUserToState(
      AuthenticateUserEvent event, Emitter<BiometricState> emit) async {
    try {
      final bool isAuthenticated = await biometricRepository.authenticateUser();
      emit(BiometricAuthenticated(isAuthenticated));
    } catch (e) {
      emit(BiometricAuthenticated(false));
    }
  }
}
