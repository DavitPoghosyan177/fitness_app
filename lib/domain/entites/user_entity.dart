import 'package:json_annotation/json_annotation.dart';
import '../../data/models/user_model.dart';

class UserEntity {
  UserEntity({
    this.userId,
    this.email,
    this.displayName,
    this.photoUrl,
    this.fullname

  });
  factory UserEntity.fromModel(UserModel userModel) {
    return UserEntity(
        userId: userModel.userId,
        email: userModel.email,
        fullname: userModel.fullname,
        displayName: userModel.displayName,
        photoUrl: userModel.photoUrl);
  }
  UserModel toModel(){
    return UserModel(
       userId: userId,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
        fullname: fullname
    );
  }
  final String? userId;
  @JsonKey(includeIfNull: false)
  final String? email;
  @JsonKey(includeIfNull: false)
  final String? displayName;
  @JsonKey(includeIfNull: false)
  final String? photoUrl;
  @JsonKey(includeIfNull: false)
  final String? fullname;

}
