import 'package:fitness_app/data/services/auth_service/auth_service.dart';
import 'package:fitness_app/data/services/user_service/user_service.dart';
import 'package:fitness_app/domain/entites/user_entity.dart';
import 'package:fitness_app/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  UserRepositoryImp({required this.userService, required this.authService});

  final UserService userService;
  final AuthService authService;

  @override
  Future<void> deleteUser(String userId) async {
    await userService.deleteUser(userId);
  }

  @override
  Future<UserEntity> getUserById(String userId) {
    return userService.getUserById(userId);
  }

  @override
  Future<void> saveUserToDB(UserEntity userEntity) async {
    await userService.saveUserToDB(userEntity.toModel());
  }
  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isUserExist(String userId) async {
    return await userService.isUserExist(userId);
  }

  @override
  Future<void> updateUserData(UserEntity userEntity) async {
    return await userService.updateUserData(userEntity);
  }
}
