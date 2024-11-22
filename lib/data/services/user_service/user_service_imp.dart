import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/data/models/user_model.dart';
import 'package:fitness_app/data/services/user_service/user_service.dart';
import 'package:fitness_app/domain/entites/user_entity.dart';


class UserServiceImp implements UserService {
  UserServiceImp(
      {required this.firebaseFirestore, required this.firebaseStorage});
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  @override
  Future<void> saveUserToDB(UserModel userModel) async {
    await firebaseFirestore
        .collection('users')
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  @override
  Future<void> updateUserData(UserEntity userEntity) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEntity.userId)
        .update(userEntity.toModel().toJson());
  }

  @override
  Future<bool> isUserExist(String userId) async {
    if (userId.isEmpty) {
      return false;
    }
    final FDocumentSnapshot snapshot =
        await firebaseFirestore.collection('users').doc(userId).get();
    return snapshot.exists;
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    final FDocumentSnapshot snapshot =
        await firebaseFirestore.collection('users').doc(userId).get();
    if (snapshot.exists && snapshot.data() != null) {
      return UserModel.fromJson(snapshot.data()!);
    }
    throw Exception('User doesn\'t exist');
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> deleteUser(String userId) async {
    await firebaseFirestore.collection('users').doc(userId).delete();
  }
}



