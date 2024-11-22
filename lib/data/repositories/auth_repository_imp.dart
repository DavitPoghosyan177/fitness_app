import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/domain/repositories/auth_repository.dart';

import '../services/auth_service/auth_service.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImp({required this.authService});

  @override
  Future<UserCredential> signInWithGoogle() async {
    return authService.signInWithGoogle();
  }
  
  @override
  Future<UserCredential> signInUserViaEmail(String email, String password) async{
    return authService.signInUserViaEmail(email, password);
  }

  @override
  Future<UserCredential> signUpUserViaEmail(String email, String password) async{
    return authService.signUpUserViaEmail(email, password);
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}
