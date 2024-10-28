import 'package:fitness_app/core/enum/gender.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../data/models/user_model.dart';

class UserEntity {
  UserEntity({
    this.userId,
    this.email,
    this.displayName,
    this.photoUrl,
    this.fullname,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activity,
    this.nickName,
    this.mobileNumber

  });
  factory UserEntity.fromModel(UserModel userModel) {
    return UserEntity(
        userId: userModel.userId,
        email: userModel.email,
        fullname: userModel.fullname,
        displayName: userModel.displayName,
        photoUrl: userModel.photoUrl,
        gender: userModel.gender,
        age: userModel.age,
        weight: userModel.weight,
        height: userModel.height,
        goal: userModel.goal,
        activity: userModel.activity,
        nickName: userModel.nickName,
        mobileNumber: userModel.mobileNumber


        );
  }
  UserModel toModel(){
    return UserModel(
       userId: userId,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
        fullname: fullname,
        gender: gender,
        age: age,
        weight: weight,
        height: height,
        goal: goal,
        activity: activity,
        nickName: nickName,
        mobileNumber: mobileNumber
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
 @JsonKey(includeIfNull: false)
  final Gender? gender;
   @JsonKey(includeIfNull: false)
  final String? age;
   @JsonKey(includeIfNull: false)
  final String? weight;
   @JsonKey(includeIfNull: false)
  final String? height;
   @JsonKey(includeIfNull: false)
  final String? goal;
   @JsonKey(includeIfNull: false)
  final String? activity;
   @JsonKey(includeIfNull: false)
  final String? nickName;
   @JsonKey(includeIfNull: false)
  final String? mobileNumber;
}
