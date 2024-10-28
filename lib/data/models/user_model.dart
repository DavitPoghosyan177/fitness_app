import 'package:fitness_app/core/enum/gender.dart';
import 'package:fitness_app/domain/entites/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    super.userId,
    super.email,
    super.displayName,
    super.photoUrl,
    super.fullname,
    super.gender,
    super.age,
    super.weight,
    super.height,
    super.goal,
    super.activity,
    super.nickName,
    super.mobileNumber
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
