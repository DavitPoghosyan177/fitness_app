import 'package:fitness_app/domain/entites/user_entity.dart';


abstract class UserRepository {
  Future<void> saveUserToDB(UserEntity userEntity);
  Future<UserEntity> getUserById(String userId);
  Future<void> deleteUser(String userId);
  Future<void> signOut();
  Future<bool> isUserExist(String userId);
  Future<void> updateUserData(UserEntity userEntity);
}
