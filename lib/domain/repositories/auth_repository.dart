import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> signOut();
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInUserViaEmail(String email, String password);
  Future<UserCredential> signUpUserViaEmail(String email, String password);
}
