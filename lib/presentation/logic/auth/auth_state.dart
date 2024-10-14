part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState(
      {this.displayName, this.email, this.error, this.userId, this.photoUrl});
  final String? error;
  final String? userId;
  final String? displayName;
  final String? email;
  final String? photoUrl;

  @override
  List<Object?> get props => [userId, displayName, email, photoUrl];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthUserLoading extends AuthState {}

final class AuthUserLoaded extends AuthState {
  const AuthUserLoaded(String userId, String displayName, String email, String photoUrl)
      : super(
            userId: userId,
            displayName: displayName,
            email: email,
            photoUrl: photoUrl);
}

final class AuthStateFailed extends AuthState {
  const AuthStateFailed(String error) : super(error: error);
}

final class AuthStateSignedOut extends AuthState {}

final class AuthRegistered extends AuthState {
  const AuthRegistered(String userId) : super(userId : userId);
}