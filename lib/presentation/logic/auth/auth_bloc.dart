import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepositories) : super(const AuthInitial()) {
    on<SignOutEvent>(_mapSignOutEventToState);
    on<SignInWithGoogleEvent>(_mapSignInWithGoogleEventToState);
    on<SignUpEvent>(_mapSignUpEventToState);
    on<SignInEvent>(_mapSignInEventToState);
  }
  final AuthRepository authRepositories;

  FutureOr<void> _mapSignInWithGoogleEventToState(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthUserLoading());
      final UserCredential userCredential =
          await authRepositories.signInWithGoogle();
      emit(AuthUserLoaded(
          userCredential.user?.uid ?? '',
          userCredential.user?.displayName ?? '',
          userCredential.user?.email ?? '',
          userCredential.user?.photoURL ?? ''));
    } on FirebaseAuthException catch (e) {
      emit(AuthStateFailed(e.message ?? e.code));
    } catch (e) {
      emit(AuthStateFailed(e.toString()));
    }
  }

  FutureOr<void> _mapSignOutEventToState(
      SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthUserLoading());
      await authRepositories.signOut();
      emit(AuthStateSignedOut());
    } on FirebaseAuthException catch (e) {
      emit(AuthStateFailed(e.message ?? e.code));
    } catch (e) {
      emit(AuthStateFailed(e.toString()));
    }
  }

  FutureOr<void> _mapSignInEventToState(
      SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthUserLoading());
      final UserCredential userCredential =
          await authRepositories.signInUserViaEmail(
        event.email,
        event.password,
      );
      emit(AuthRegistered(userCredential.user?.uid ?? ''));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          emit(const AuthStateFailed('The email address is not valid.'));
          break;
        case 'user-disabled':
          emit(const AuthStateFailed('The user has been disabled.'));
          break;
        case 'user-not-found':
          emit(const AuthStateFailed('No user found for that email.'));
          break;
        case 'wrong-password':
          emit(const AuthStateFailed('Wrong password provided.'));
          break;
        default:
          emit(AuthStateFailed(e.message ?? 'An unknown error occurred.'));
      }
    } catch (e) {
      emit(AuthStateFailed(e.toString()));
    }
  }

  FutureOr<void> _mapSignUpEventToState(
      SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthUserLoading());
      final UserCredential userCredential = await authRepositories
          .signUpUserViaEmail(event.email, event.password);
      emit(AuthRegistered(userCredential.user?.uid ?? ''));
    } on FirebaseAuthException catch (error) {
      emit(AuthStateFailed(error.message ?? error.toString()));
    }
  }
}
