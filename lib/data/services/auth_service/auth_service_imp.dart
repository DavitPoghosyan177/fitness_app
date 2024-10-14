import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/data/services/auth_service/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceImp implements AuthService {
  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn(scopes: ["profile", "email"],).signIn();
    final GoogleSignInAuthentication? gAuth = await gUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
   @override
  Future<UserCredential> signInUserViaEmail(
      String email, String password) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
  @override
  Future<UserCredential> signUpUserViaEmail(
      String email, String password) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}